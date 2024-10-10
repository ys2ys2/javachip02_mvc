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
    public int insertM_Member(M_MemberVO vo) {
    	return dao.insertM_Member(vo);
    }


	@Override
	public M_MemberVO login(String m_email, String m_password) {
		Map<String, String> map = new HashMap<>();
		map.put("m_email", m_email);
		map.put("m_password", m_password);
		
		return dao.login(map);
	}
}
