package com.human.web.service;

import java.util.List;

import com.human.web.vo.DaejeonEventApiVO;


public interface DaejeonEventApiService {
	int insertDaejeonEvent();
	List<DaejeonEventApiVO.Item> getAllDaejeonEvent();
}