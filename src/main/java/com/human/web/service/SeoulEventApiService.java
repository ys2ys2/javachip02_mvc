package com.human.web.service;

import java.util.List;

import com.human.web.vo.SeoulEventApiVO.Row;

public interface SeoulEventApiService {
    List<Row> getAllEvents();
    //int saveEvent(SeoulEventApiVO.Row event);
	int insertSeoul();

}