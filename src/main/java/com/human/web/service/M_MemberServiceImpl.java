package com.human.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.M_MemberDAO;
import com.human.web.vo.M_MemberVO;

@Service
public class M_MemberServiceImpl implements M_MemberService {

    @Autowired
    private M_MemberDAO memberDAO;

    @Override
    public int checkId(String memberId) {
        return memberDAO.checkId(memberId);
    }

    @Override
    public int insertMember(M_MemberVO vo) {
        return memberDAO.insertM_Member(vo);
    }
}
