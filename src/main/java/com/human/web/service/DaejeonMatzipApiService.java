package com.human.web.service;

import java.util.List;

import com.human.web.vo.DaejeonEventApiVO;
import com.human.web.vo.DaejeonMatzipApiVO;


public interface DaejeonMatzipApiService {
	int insertDaejeonMatzip();
	List<DaejeonMatzipApiVO.Damat> getAllDaejeonMatzip();
}