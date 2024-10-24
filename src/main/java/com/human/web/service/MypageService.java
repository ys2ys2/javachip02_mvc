package com.human.web.service;

import java.util.List;

import com.human.web.vo.MypageSchedVO;
import com.human.web.vo.MypageVO;

public interface MypageService {


	List<MypageVO> getRandomHotplaceList();

	List<MypageVO> getSavedList(int m_idx);

	List<MypageVO> getSavedPostList(int m_idx);

	List<MypageVO> getSavedPostListByMidx(Integer m_idx);

	List<MypageVO> getSavedListByMidx(Integer m_idx);

	List<MypageSchedVO> getUpcomingTrips(int m_idx);

	List<MypageSchedVO> getPastTrips(int m_idx);
	
	MypageSchedVO getLatestPastTrip(Integer m_idx);

	MypageSchedVO getLatestUpcomingTripByMidx(Integer m_idx);


	
	
}
