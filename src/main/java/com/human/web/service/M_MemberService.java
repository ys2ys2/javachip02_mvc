package com.human.web.service;

import com.human.web.vo.M_MemberVO;

public interface M_MemberService {
    int checkId(String memberId);
    int insertMember(M_MemberVO vo);
}
