package com.human.web.service;

import com.human.web.vo.SeoulEventApiVO;
import java.util.List;

public interface SeoulEventApiService {
    List<SeoulEventApiVO.Row> getAllEvents();
    //int saveEvent(SeoulEventApiVO.Row event);
	int insertSeoul();
}