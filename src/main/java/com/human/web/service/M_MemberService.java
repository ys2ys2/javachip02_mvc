package com.human.web.service;

import com.human.web.vo.M_MemberVO;

public interface M_MemberService {
   
    
    int insertM_Member(M_MemberVO vo);
    
	M_MemberVO login(String m_email, String m_password);


}
