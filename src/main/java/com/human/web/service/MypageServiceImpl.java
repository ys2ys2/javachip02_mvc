package com.human.web.service;

import java.util.List;
import java.util.stream.Collectors;

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
  	    // firstimage 필드에서 첫 번째 이미지 URL만 남기기
  	    return savedList.stream().map(mypage -> {
  	        String firstimage = mypage.getFirstimage();  // firstimage 필드 가져오기
  	        if (firstimage != null && firstimage.contains(",")) {
  	            // 쉼표로 나눈 후 첫 번째 이미지 URL만 남김
  	            firstimage = firstimage.split(",")[0].trim();
  	        }
  	        mypage.setFirstimage(firstimage);  // 필드 값 수정
  	        return mypage;
  	    }).collect(Collectors.toList());
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
	    // DB에서 저장 목록 가져오기
	    List<MypageVO> savedList = mypageDao.getSavedListByMidx(m_idx);
	    
	    // firstimage 필드에서 첫 번째 이미지 URL만 남기기
	    return savedList.stream().map(mypage -> {
	        String firstimage = mypage.getFirstimage();  // firstimage 필드 가져오기
	        if (firstimage != null && firstimage.contains(",")) {
	            // 쉼표로 나눈 후 첫 번째 이미지 URL만 남김
	            firstimage = firstimage.split(",")[0].trim();
	        }
	        mypage.setFirstimage(firstimage);  // 필드 값 수정
	        return mypage;
	    }).collect(Collectors.toList());
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

//메인홈화면에 지난여행/ 다가오는 여행 불러오기 (최신만)
	@Override
	public MypageSchedVO getLatestPastTrip(Integer m_idx) {
		return mypageDao.getLatestPastTrip(m_idx);
	}

	@Override
	public MypageSchedVO getLatestUpcomingTripByMidx(Integer m_idx) {
		return mypageDao.getLatestUpcomingTripByMidx(m_idx);
	}

}
