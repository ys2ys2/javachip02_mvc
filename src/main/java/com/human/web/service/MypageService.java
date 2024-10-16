package com.human.web.service;

import java.util.List;

import com.human.web.vo.MypageVO;

public interface MypageService {

	List<MypageVO> getMypageList();
	
	/*
	 * M_MemberVO updateMember(M_MemberVO vo);
	 * 
	 * int cancel(int m_idx);
	 */
}
