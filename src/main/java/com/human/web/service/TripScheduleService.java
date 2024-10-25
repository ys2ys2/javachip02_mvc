package com.human.web.service;

import java.util.List;
import com.human.web.vo.TripScheduleVO;

public interface TripScheduleService {
    void saveTripSchedule(TripScheduleVO tripSchedVO);
    List<TripScheduleVO> getTripScheduleList();
    List<TripScheduleVO> getTripScheduleById(int postId);
}
