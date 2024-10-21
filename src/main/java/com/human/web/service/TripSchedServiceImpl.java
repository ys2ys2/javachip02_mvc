package com.human.web.service;

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
        // 각 DAY의 장소 정보를 반복문을 통해 저장
        for (int i = 0; i < tripSchedVO.getDayNumbers().length; i++) {
            TripSchedVO vo = new TripSchedVO();
            vo.setM_idx(tripSchedVO.getM_idx());
            vo.setM_email(tripSchedVO.getM_email());
            vo.setM_nickname(tripSchedVO.getM_nickname());
            vo.setTitle(tripSchedVO.getTitle());
            vo.setPeriod_start(tripSchedVO.getPeriod_start());
            vo.setPeriod_end(tripSchedVO.getPeriod_end());

            // 배열에서 해당 인덱스의 데이터들을 설정
            vo.setDay_number(tripSchedVO.getDayNumbers()[i]);
            vo.setCity_name(tripSchedVO.getCityNames()[i]);
            vo.setLabel_number(tripSchedVO.getLabelNumbers()[i]);
            vo.setPlace_name(tripSchedVO.getPlaceNames()[i]);
            vo.setPlace_address(tripSchedVO.getPlaceAddresses()[i]);

            // DAO에 데이터 저장
            tripSchedDAO.insertTripSchedule(vo);
        }
    }
}
