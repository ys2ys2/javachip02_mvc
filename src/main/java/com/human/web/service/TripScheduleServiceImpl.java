package com.human.web.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.human.web.repository.TripScheduleDAO;
import com.human.web.vo.TripScheduleVO;

@Service
public class TripScheduleServiceImpl implements TripScheduleService {

    @Autowired
    private TripScheduleDAO tripSchedDAO;

    @Override
    public void saveTripSchedule(TripScheduleVO tripSchedVO) {
        tripSchedDAO.insertTripSchedule(tripSchedVO);
    }

    @Override
    public List<TripScheduleVO> getTripScheduleList() {
        return tripSchedDAO.getTripScheduleList();
    }

    @Override
    public List<TripScheduleVO> getTripScheduleById(int postId) {
        return tripSchedDAO.getTripScheduleById(postId);
    }
}
