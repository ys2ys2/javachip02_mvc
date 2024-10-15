package com.human.web.repository;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.M_MemberVO;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;

@Repository // 데이터베이스 작업을 담당하는 클래스에 붙여줌
@RequiredArgsConstructor
@AllArgsConstructor// Lombok으로 의존성 자동 주입을 위한 생성자 생성
public class M_MemberDAO {

    // MyBatis의 SqlSession 객체를 이용해서 DBCP 사용
    @Autowired
	private SqlSession sqlSession;

    // MyBatis의 Mapper와 연결하기 위해 사용되는 상수 정의
    public static final String MAPPER = "com.human.web.mapper.M_MemberMapper";

	

    // 회원 가입
    public int insertM_Member(M_MemberVO memberVO) {
    	 System.out.println("M_MemberDAO - insertM_Member 호출됨");
        
        int result = 0;
        try {
            result = sqlSession.insert(MAPPER + ".insertM_Member", memberVO);
            if (result > 0) {
                return memberVO.getM_idx();  // 삽입 후 자동 생성된 m_idx 반환
            }
        } catch (Exception e) {
            System.out.println("회원정보 입력 중 예외 발생: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;  // 삽입 실패 시 -1 반환
    }
    

	public M_MemberVO login(Map<String, String> map) {
		M_MemberVO vo = null;//로그인 실패시 결과값
		try {
			vo = sqlSession.selectOne(MAPPER+".login", map);
		} catch (Exception e) {
			System.out.println("로그인 중 예외발생");		
			 e.printStackTrace();
		
		}
		
		return vo;
	
		}



	public int checkId(String m_email) {
		int result= 0;
		 try {
			result = sqlSession.selectOne(MAPPER+".checkId", m_email);
			
		} catch (Exception e) {
			System.out.println("아이디 중복검사 중 예외 발생"+ e.getMessage());
			  e.printStackTrace();  // 스택 트레이스 출력
		}
		
		return result;
		
		 
	}


	public int checkNickname(String m_nickname) {
		int result =0;
	
		try {
			result = sqlSession.selectOne(MAPPER+".checkNickname", m_nickname);
		} catch (Exception e) {
			System.out.println("닉네임 중복 검사 중 예외 발생"+e.getMessage());
			e.printStackTrace();
		}
		
		return result;
	}


	 
	    public M_MemberVO findByEmail(String email) {
	        return sqlSession.selectOne(MAPPER + ".findByEmail", email);
	    }


	    // 카카오 ID로 기존 회원 찾기
	    public M_MemberVO findByKakaoId(Long kakaoId) {
	        return sqlSession.selectOne(MAPPER + ".findByKakaoId", kakaoId);
	    }

	 // 구글 회원정보 가져오기
	    public M_MemberVO getMemberByGoogleId(String googleId) {
	        // 디버깅용 출력: 전달된 Google ID 확인
	        System.out.println("디버깅: getMemberByGoogleId 호출됨. Google ID: " + googleId);

	        // SQL 조회 실행
	        M_MemberVO memberVO = sqlSession.selectOne(MAPPER + ".getMemberByGoogleId", googleId);

	        // 디버깅용 출력: 데이터베이스에서 조회된 결과 확인
	        if (memberVO != null) {
	            System.out.println("디버깅: 조회된 회원 정보: " + memberVO);
	        } else {
	            System.out.println("디버깅: 해당 Google ID에 해당하는 회원이 존재하지 않습니다.");
	        }

	        return memberVO;
	    }


		public int countByNickname(String m_nickname) {
			 return sqlSession.selectOne(MAPPER + ".countByNickname", m_nickname);
		}


		public int updateMemberProfile(M_MemberVO member) {
			   return sqlSession.update(MAPPER + ".updateMemberProfile", member);
		}


  }
