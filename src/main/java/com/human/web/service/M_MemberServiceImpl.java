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

	//이메일 중복체크 
	@Override
	public int checkId(String m_email) {
		return dao.checkId(m_email);
	}

	//닉네임 중복체크 
	@Override
	public int checkNickname(String m_nickname) {
		return dao.checkNickname(m_nickname);
	}
	
	
    // 이메일로 회원 조회 (네이버 로그인 시 사용)
    @Override
    public M_MemberVO findByEmail(String m_email) {
        return dao.findByEmail(m_email);
    }

  //회원정보 변경
    @Override
	public M_MemberVO updateMember(M_MemberVO vo) {
    	M_MemberVO newVo = null; //회원정보 변경 실패시 결과값
    	
    	// 1. 닉네임 중복 체크
        int nicknameCount = dao.checkNickname(vo.getM_nickname());

        // 2. 닉네임이 중복된 경우 처리
        if (nicknameCount > 0) {
            System.out.println("중복된 닉네임입니다.");
            return null; // 닉네임 중복 시 null 반환
        }

        // 3. 중복되지 않으면 회원 정보 업데이트 진행
        if (dao.updateMember(vo) == 1) {
            newVo = dao.getMember(vo.getM_idx()); // 업데이트 후 새로운 회원 정보 가져옴
        }

        return newVo; // 변경된 회원 정보 반환
	}

  //회원탈퇴
  	@Override
  	public int cancel(int m_idx) {
  		return dao.cancel(m_idx);
  	}
}
