package com.human.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.human.web.repository.MypageDAO;
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
	
	
    @Override
      public List<MypageVO> getSavedList(int m_idx) {
          List<MypageVO> savedList = mypageDao.getSavedList(m_idx);
          System.out.println("가져온 저장 데이터 목록: " +savedList);
	    // DAO를 호출하여 데이터를 가져옴
          return savedList;
    }
}
