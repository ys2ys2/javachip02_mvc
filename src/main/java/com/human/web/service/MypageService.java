package com.human.web.service;

import java.util.List;

import com.human.web.vo.MypageVO;

public interface MypageService {


	List<MypageVO> getRandomHotplaceList();

	List<MypageVO> getSavedList(int m_idx);

	
	
}
