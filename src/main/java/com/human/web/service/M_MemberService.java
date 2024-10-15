package com.human.web.service;

import com.human.web.vo.M_MemberVO;

public interface M_MemberService {

	int insertM_Member(M_MemberVO memberVO);

	M_MemberVO login(String m_email, String m_password);

	int checkId(String m_email);

	int checkNickname(String m_nickname);

	M_MemberVO findByEmail(String email);

	boolean isNicknameAvailable(String nickname);

	boolean updateMemberProfile(M_MemberVO member);

}
