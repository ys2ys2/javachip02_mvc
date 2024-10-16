package com.human.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.human.web.repository.MypageDAO;
import com.human.web.vo.MypageVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MypageServiceImpl implements MypageService {

	private MypageDAO mypageDao;  // 마이페이지 관련 DAO
	
	@Override
	public List<MypageVO> getMypageList() {
		/* System.out.println("MypageServiceImpl - getMypageList 호출됨"); */
		return mypageDao.getMypageList();  // 마이페이지 목록 조회는 MypageDAO 사용
	}

	/*
	 * @Override public M_MemberVO updateMember(M_MemberVO vo) { M_MemberVO newVo =
	 * null; // 회원정보 변경 실패 시 결과값
	 * 
	 * // 회원정보 업데이트가 성공하면 변경된 정보 조회 if (memberDao.updateMember(vo) == 1) { newVo =
	 * memberDao.getMember(vo.getM_idx());
	 * System.out.println("Service - 회원 정보 업데이트 성공: " + newVo); // 업데이트된 회원 정보 확인
	 * }else { System.out.println("Service - 회원 정보 업데이트 실패"); // 디버깅 }
	 * 
	 * 
	 * return newVo; }
	 * 
	 * // 회원탈퇴 처리
	 * 
	 * @Override public int cancel(int m_idx) { return memberDao.cancel(m_idx); //
	 * 회원탈퇴는 M_MemberDAO에서 처리 }
	 */
}
