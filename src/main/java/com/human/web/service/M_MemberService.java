package com.human.web.service;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.human.web.vo.M_MemberVO;

public interface M_MemberService {
   
    
    int insertM_Member(M_MemberVO memberVO);
    
	M_MemberVO login(String m_email, String m_password);

	int checkId(String m_email);
	
	int checkNickname(String m_nickname);
	
	M_MemberVO findByEmail(String email);
	
	M_MemberVO updateMember(M_MemberVO vo);

	int cancel(int m_idx);

	boolean isValidPassword(String m_password);
	
	 M_MemberVO updateProfileImage(M_MemberVO vo);

	String findIdByRegistrationAndNickname(String registrationType, String nickname);

	boolean updatePassword(String m_email, String newPassword);

	

	
}
