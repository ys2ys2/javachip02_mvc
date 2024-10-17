package com.human.web.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.human.web.repository.HotPlaceDAO;

@Service
public class HotPlaceServiceImpl implements HotPlaceService {

    @Autowired
    private HotPlaceDAO hotplaceDAO;

    @Transactional
    @Override
    public String insertHotPlaceData(String selectedContentIds, List<Map<String, Object>> detailItemList) {
        String[] contentIdArray = selectedContentIds.split(",");
        
        try {
            for (String contentId : contentIdArray) {
                contentId = contentId.trim();
                
                // detailItemList에서 contentId에 맞는 데이터를 찾음
                for (Map<String, Object> detailData : detailItemList) {
                    if (contentId.equals(detailData.get("contentid"))) {
                        
                        // 추가 이미지 URL 처리
                        StringBuilder imageUrls = new StringBuilder((String) detailData.get("firstimage"));
                        List<Map<String,String>> images = (List<Map<String,String>>) detailData.get("images");
                        
                        if (images != null && !images.isEmpty()) {
                            for (Map<String, String> imageData : images) {
                                if (imageUrls.length() > 0) {
                                    imageUrls.append(",");
                                }
                                imageUrls.append(imageData.get("originimgurl"));
                            }
                        }
                        
                        // DAO 호출 (DB에 데이터 삽입)
                        try {
                            int result = hotplaceDAO.insertHotPlace(
                                contentId,
                                (String) detailData.get("title"),
                                (String) detailData.get("addr1"),
                                (String) detailData.get("overview"),
                                Double.parseDouble((String) detailData.get("mapx")),
                                Double.parseDouble((String) detailData.get("mapy")),
                                imageUrls.toString(),
                                (String) detailData.get("areacode")
                            );
                        } catch (Exception e) {
                            System.out.println("DB 삽입 중 오류 발생: " + e.getMessage());
                            e.printStackTrace();
                        }

                        break;
                    }
                }
            }
            return "데이터가 성공적으로 저장되었습니다.";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "데이터 저장 중 예외 발생: " + e.getMessage();
        }
    }

    
    // 랜덤으로 hotplace 상세 정보를 가져오는 메서드 (firstimage 첫 번째 이미지 처리)
    @Override
    public List<Map<String, Object>> getRandomHotplaceDetail(int limit) {
        // DB에서 랜덤으로 여러 필드를 가져옴
        List<Map<String, Object>> hotplaces = hotplaceDAO.getRandomHotplaceDetail(limit);

        // firstimage 필드에서 첫 번째 이미지 URL만 남기기
        return hotplaces.stream().map(hotplace -> {
            String firstimage = (String) hotplace.get("firstimage");
            if (firstimage != null && firstimage.contains(",")) {
                // 쉼표로 구분된 이미지 중 첫 번째만 추출
                firstimage = firstimage.split(",")[0].trim();
            }
            hotplace.put("firstimage", firstimage);
            return hotplace;
        }).collect(Collectors.toList());
    }


    //contentId로 페이지 이동
	@Override
	public Map<String, Object> getHotplaceById(int contentid) {
		return hotplaceDAO.getHotPlaceById(contentid);
	}


	
	//hotplace 저장하면 mypage 테이블로 저장
	@Override
	public void saveHotplace(int m_idx, String contentid) {
        hotplaceDAO.insertMyPage(m_idx, contentid);
	}



}
