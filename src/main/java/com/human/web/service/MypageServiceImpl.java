package com.human.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.human.web.repository.MypageDAO;
import com.human.web.vo.MypageSchedVO;
import com.human.web.vo.MypageVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MypageServiceImpl implements MypageService {

	private MypageDAO mypageDao; // 마이페이지 관련 DAO

	/*
	 * @Override public List<MypageVO> getHotplaceList() {
	 * System.out.println("MypageServiceImpl - getMypageList 호출됨"); return
	 * mypageDao.getHotplaceList(); // 마이페이지 목록 조회는 MypageDAO 사용 }
	 */

	@Override
	public List<MypageVO> getRandomHotplaceList() {
		return mypageDao.getRandomHotplaceList();
	}
	
	//핫플 저장리스트 가져옴
    @Override
      public List<MypageVO> getSavedList(int m_idx) {
          List<MypageVO> savedList = mypageDao.getSavedList(m_idx);
          System.out.println("가져온 저장 데이터 목록: " +savedList);
	    // DAO를 호출하여 데이터를 가져옴
          return savedList;
    }

    //게시글 불러오기
    @Override
    public List<MypageVO> getSavedPostList(int m_idx) {
        System.out.println("서비스에서 전달된 m_idx: " + m_idx);  // m_idx 값 로그 확인
        List<MypageVO> savedPostList = mypageDao.getSavedPostList(m_idx);
        System.out.println("서비스에서 가져온 저장 데이터 목록: " + savedPostList);  // 가져온 데이터 출력
        return savedPostList;
    }
    //마이페이지 홈에 게시글 불러오기
	@Override
	  public List<MypageVO> getSavedPostListByMidx(Integer m_idx) {
        return mypageDao.getSavedPostListByMidx(m_idx);
    }

	//마이페이지 홈에 저장목록 불러오기
	@Override
	public List<MypageVO> getSavedListByMidx(Integer m_idx) {
		return mypageDao.getSavedListByMidx(m_idx);
	}

	//여행 일정에 다가오는 일정 불러오기
	@Override
	public List<MypageSchedVO> getUpcomingTrips(int m_idx) {
		System.out.println("서비스에 전달된 m_idx: " +m_idx);
		 return mypageDao.getUpcomingTrips(m_idx);
//		List<MypageSchedVO> upcomingTrips =mypageDao.getUpcomingTrips(m_idx);
	}
	
	//여행 일정에 지난 일정 불러오기
	@Override
	public List<MypageSchedVO> getPastTrips(int m_idx) {
		System.out.println("서비스에 전달된 m_idx: " +m_idx);
		 return mypageDao.getPastTrips(m_idx);
	}

	@Override
	public List<MypageSchedVO> getUpcomingTripsByMidx(Integer m_idx) {
		return mypageDao.getUpcomingTripsByMidx(m_idx);
	}

	@Override
	public List<MypageSchedVO> getPastTripsByMidx(Integer m_idx) {
		return mypageDao.getPastTripsByMidx(m_idx);
	}

}
