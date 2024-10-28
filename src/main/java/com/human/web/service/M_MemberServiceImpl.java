package com.human.web.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.human.web.repository.M_MemberDAO;
import com.human.web.vo.M_MemberVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class M_MemberServiceImpl implements M_MemberService {

	private M_MemberDAO dao;
	


    @Override
    public int insertM_Member(M_MemberVO memberVO) {
    	memberVO.setM_registration_type("email");
    	return dao.insertM_Member(memberVO);
    }


	@Override
	public M_MemberVO login(String m_email, String m_password) {
		Map<String, String> map = new HashMap<>();
		map.put("m_email", m_email);
		map.put("m_password", m_password);
		//DAO에서 로그인 정보로 회원 조회
		M_MemberVO member = dao.login(map);
		
		//조회된 회원이 탈퇴 상태인지 확인
		if(member != null && " deleted".equals(member.getM_status())) {
			return null;
		}
		
		return member; //탈퇴하지 않은 회원의 경우 member 반환
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
    @Override
    public M_MemberVO updateMember(M_MemberVO vo) {
        M_MemberVO newVo = null; // 회원정보 변경 실패 시 반환값

        // 1. 세션에서 기존 정보를 가져와 닉네임이 변경되었는지 확인
        M_MemberVO existingMember = dao.getMember(vo.getM_idx()); // 기존 회원 정보 조회
        
        if (!vo.getM_nickname().equals(existingMember.getM_nickname())) {
            // 2. 닉네임이 변경되었을 경우에만 중복 체크 수행
            int nicknameCount = dao.checkNickname(vo.getM_nickname());
            if (nicknameCount > 0) {
                System.out.println("중복된 닉네임입니다.");
                return null; // 닉네임 중복 시 null 반환
            }
        }

        // 3. 회원 정보 업데이트 진행
        if (dao.updateMember(vo) == 1) {
            newVo = dao.getMember(vo.getM_idx()); // 업데이트 후 새로운 회원 정보 가져옴
        }

        return newVo; // 변경된 회원 정보 반환
    }

    
    //회원정보 변경시 비밀번호 유효성 검사
    public boolean isValidPassword(String password) {
        // 최소 8자 이상, 하나 이상의 영문자, 숫자 및 특수문자 포함
        String passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$";
        return password != null && password.matches(passwordPattern);
    }

    
    //프로필 이미지 변경
    @Override
    public M_MemberVO updateProfileImage(M_MemberVO vo) {
        int result = dao.updateProfileImage(vo); // 업데이트 메서드 호출
        return (result > 0) ? dao.getMember(vo.getM_idx()) : null; // 업데이트 성공 시 회원 정보 반환
    }

 

  //회원탈퇴
  	@Override
  	public int cancel(int m_idx) {
  		return dao.cancel(m_idx);
  	}

  	
  	//회원정보 찾기 - 아이디
	@Override
	public String findIdByRegistrationAndNickname(String registrationType, String nickname) {
		return dao.findIdByRegistrationAndNickname(registrationType, nickname);
	}


	@Override
	public boolean updatePassword(String m_email, String newPassword) {
	    int result = dao.updatePassword(m_email, newPassword); 
	    return result > 0;  // 업데이트 성공 여부 반환
	}



	
}
