package com.human.web.repository;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.MypageVO;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;



//스프링에서 이 클래스가 DAO임을 알려주는 어노테이션
@Repository //DB와 관련된 작업을 하는 클래스에 붙여줌
@RequiredArgsConstructor
@AllArgsConstructor 
public class MypageDAO {

	@Autowired  // 의존성 주입을 통해 SqlSession 객체를 사용 가능하게 함
	private SqlSession sqlSession;
	
	 // NAMESPACE: MyBatis에서 사용할 매퍼 파일의 네임스페이스를 지정
	private static final String MAPPER = "com.human.web.mapper.MypageMapper";	
	
	 // getMypageList: 데이터베이스에서 M_Mypage 테이블의 모든 데이터를 가져오는 메서드
    // 반환값: List<MypageVO> - M_Mypage 테이블의 모든 데이터를 VO 객체 리스트로 반환
	public List<MypageVO> getMypageList() {
		 System.out.println("MypageDAO - getMypageList 호출됨");  // 메서드 호출 시 출력
	        
	        List<MypageVO> list = sqlSession.selectList(MAPPER + ".getMypageList");

	        // 쿼리 결과 출력
	        if (list != null && !list.isEmpty()) {
	            System.out.println("조회된 데이터 수: " + list.size());
	            for (MypageVO vo : list) {
	                System.out.println(vo);
	            }
	        } else {
	            System.out.println("쿼리 결과가 없습니다.");
	        }
	        
	        return list;
		
	        
	        
	}
	
	
	/*
	 * public int updateMember(M_MemberVO vo) { int result = 0; //회원정보변경 실패시 결과값
	 * 
	 * try { System.out.println("업데이트할 회원정보: " + vo.toString()); // 업데이트할 정보 확인
	 * result = sqlSession.update(MAPPER+".updateMember", vo);
	 * System.out.println("회원정보 업데이트 결과: " + result); // 업데이트 성공 여부 확인
	 * 
	 * } catch (Exception e) { System.out.println("회원정보 변경 중 예외발생");
	 * e.printStackTrace();
	 * 
	 * }
	 * 
	 * return result; } // 회원정보 조회 public M_MemberVO getMember(int m_idx) {
	 * M_MemberVO vo = null; try { System.out.println("DAO - 업데이트할 회원 정보: " + vo);
	 * // VO 값 확인 vo = sqlSession.selectOne(MEMBER_MAPPER + ".getMember", m_idx);
	 * System.out.println("회원정보 조회 성공: " + vo); } catch (Exception e) {
	 * System.out.println("회원정보 조회 중 예외 발생"); e.printStackTrace(); } return vo; }
	 * 
	 * // 회원탈퇴 처리 public int cancel(int m_idx) { int result = 0; try { result =
	 * sqlSession.update(MEMBER_MAPPER + ".cancel", m_idx);
	 * System.out.println("회원탈퇴 성공, 결과값: " + result); } catch (Exception e) {
	 * System.out.println("회원탈퇴 중 예외 발생"); e.printStackTrace(); } return result; }
	 */
	}


