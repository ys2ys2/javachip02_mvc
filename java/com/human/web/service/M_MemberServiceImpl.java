package com.human.web.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.human.web.repository.M_MemberDAO;
import com.human.web.vo.M_MemberVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class M_MemberServiceImpl implements M_MemberService {

	private M_MemberDAO dao;

	@Override
	public int insertM_Member(M_MemberVO memberVO) {
		return dao.insertM_Member(memberVO);
	}

	@Override
	public M_MemberVO login(String m_email, String m_password) {
		Map<String, String> map = new HashMap<>();
		map.put("m_email", m_email);
		map.put("m_password", m_password);

		return dao.login(map);
	}

	// 이메일 중복체크
	@Override
	public int checkId(String m_email) {
		return dao.checkId(m_email);
	}

	// 닉네임 중복체크
	@Override
	public int checkNickname(String m_nickname) {
		return dao.checkNickname(m_nickname);
	}

	// 이메일로 회원 조회 (네이버 로그인 시 사용)
	@Override
	public M_MemberVO findByEmail(String m_email) {
		return dao.findByEmail(m_email);
	}

	// 닉네임 중복 체크를 boolean 값으로 반환
	@Override
	public boolean isNicknameAvailable(String m_nickname) {
		int count = dao.countByNickname(m_nickname); // DAO에서 닉네임 중복 체크
		return count == 0; // 중복되지 않으면 true 반환
	}

	@Override
	public boolean updateMemberProfile(M_MemberVO member) {
		int result = dao.updateMemberProfile(member); // DAO에서 프로필 업데이트 수행
		return result > 0;
	}
}
