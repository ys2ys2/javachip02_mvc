package com.human.web.service;

import java.util.List;

import com.human.web.vo.TravelVO;

public interface TravelService {



	List<TravelVO> getTravelListByMidx(Integer m_idx);

}
