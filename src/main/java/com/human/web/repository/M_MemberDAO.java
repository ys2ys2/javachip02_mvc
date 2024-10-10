package com.human.web.repository;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.M_MemberVO;

import lombok.RequiredArgsConstructor;

@Repository // 데이터베이스 작업을 담당하는 클래스에 붙여줌
@RequiredArgsConstructor // Lombok으로 의존성 자동 주입을 위한 생성자 생성
public class M_MemberDAO {

    // MyBatis의 SqlSession 객체를 이용해서 DBCP 사용
    @Autowired
	private SqlSession sqlSession;

    // MyBatis의 Mapper와 연결하기 위해 사용되는 상수 정의
    public static final String MAPPER = "com.human.web.mapper.M_MemberMapper";

	/*
	 * // 아이디 중복 검사 public int checkId(String memberId) { try { return
	 * sqlSession.selectOne(MAPPER + ".checkId", memberId); } catch (Exception e) {
	 * System.out.println("아이디 중복검사 중 예외 발생: " + e.getMessage()); return 0; } }
	 */

    // 회원 가입
    public int insertM_Member(M_MemberVO vo) {
        
        int result = 0;
        try {
            result = sqlSession.insert(MAPPER + ".insertM_Member", vo);
            if (result > 0) {
                return vo.getM_idx();  // 삽입 후 자동 생성된 m_idx 반환
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
  }
