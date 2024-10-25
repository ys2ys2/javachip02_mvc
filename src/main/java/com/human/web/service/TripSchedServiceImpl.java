package com.human.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.TripSchedDAO;
import com.human.web.vo.TripSchedVO;

@Service
public class TripSchedServiceImpl implements TripSchedService {

    @Autowired
    private TripSchedDAO tripSchedDAO;

    @Override
    public void saveTripSchedule(TripSchedVO tripSchedVO) {
    	
    	// 현재 저장된 post_id 중 가장 큰 값 찾기
        Integer maxPostId = tripSchedDAO.getMaxPostId();  // DAO에서 post_id 최대값 조회
        int newPostId = (maxPostId != null) ? maxPostId + 1 : 1; // 새로운 post_id 설정
    	
    	
    	
        // 각 DAY의 장소 정보를 반복문을 통해 저장 + 같은 post_id 같기
        for (int i = 0; i < tripSchedVO.getDayNumbers().length; i++) {
            TripSchedVO vo = new TripSchedVO();
            
            vo.setM_idx(tripSchedVO.getM_idx());
            vo.setM_email(tripSchedVO.getM_email());
            vo.setM_nickname(tripSchedVO.getM_nickname());
            vo.setTitle(tripSchedVO.getTitle());
            vo.setPeriod_start(tripSchedVO.getPeriod_start());
            vo.setPeriod_end(tripSchedVO.getPeriod_end());
            
            vo.setPost_id(newPostId);  // 같은 post_id를 설정


            // 배열에서 해당 인덱스의 데이터들을 설정
            vo.setDay_number(tripSchedVO.getDayNumbers()[i]);
            vo.setCity_name(tripSchedVO.getCityNames()[i]);
            vo.setLabel_number(tripSchedVO.getLabelNumbers()[i]);
            vo.setPlace_name(tripSchedVO.getPlaceNames()[i]);
            vo.setPlace_address(tripSchedVO.getPlaceAddresses()[i]);
            
            
         // 현재 Day에 해당하는 좌표들을 수집
            List<Map<String, Double>> coordinates = new ArrayList<>();
            for (int j = 0; j < tripSchedVO.getLabelNumbers().length; j++) {
                if (tripSchedVO.getDayNumbers()[i] == tripSchedVO.getDayNumbers()[j]) {
                    Map<String, Double> coord = new HashMap<>();
                    coord.put("lat", tripSchedVO.getPlaceLatitudes()[j]);  // 위도
                    coord.put("lng", tripSchedVO.getPlaceLongitudes()[j]); // 경도
                    coordinates.add(coord);
                }
            }

            // 각 Day에 해당하는 썸네일 URL 생성
            String thumbnailUrl = generateThumbnailUrl(coordinates);
            vo.setThumbnail(thumbnailUrl); // 각 Day별 썸네일을 설정

            // DAO에 데이터 저장
            tripSchedDAO.insertTripSchedule(vo);
        }
    }

 // 썸네일 URL 생성 함수
    public String generateThumbnailUrl(List<Map<String, Double>> coordinates) {
        String baseUrl = "https://maps.googleapis.com/maps/api/staticmap?";
        StringBuilder markers = new StringBuilder();
        StringBuilder path = new StringBuilder("&path=color:0xFF0000FF|weight:5"); // 선의 색상과 두께 설정


        // 좌표 리스트를 바탕으로 마커 생성
        for (int i = 0; i < coordinates.size(); i++) {
            Map<String, Double> coord = coordinates.get(i);
            markers.append("&markers=label:" + (i + 1) + "%7C" + coord.get("lat") + "," + coord.get("lng"));
            path.append("|" + coord.get("lat") + "," + coord.get("lng")); // 경로 추가

        }

        // 썸네일 URL 생성
        String mapUrl = baseUrl + "center=" + coordinates.get(0).get("lat") + "," + coordinates.get(0).get("lng")
                + "&zoom=15&size=600x400&maptype=roadmap" + markers.toString()
                + path.toString() // 경로 추가
                + "&key=AIzaSyBBGXfM-W2P67M4VmuJdGHedKT73_rMEWQ";

        return mapUrl;
    }    

}
