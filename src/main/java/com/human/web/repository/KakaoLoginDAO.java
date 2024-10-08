package com.human.web.repository;

import java.sql.SQLException;

import com.human.web.jdbc.DBCP;
import com.human.web.vo.KakaoLoginVO;

public class KakaoLoginDAO extends DBCP {

		public int insertKAKAOLOGIN(KakaoLoginVO kakaoLoginVO) {
		System.out.println("insertKAKAOLOGIN 메소드 호출됨");
		
       
        int result = 0;//입력 실패 시 결과값
		
		//연결객체를 이용해서 SQL객체를 생성함
        String sql = "INSERT INTO kakao_login (kakao_id, m_idx, kakao_nickname, create_at) VALUES (?, ?, ?, ?)";
        

		try {
			conn.setAutoCommit(false);//오토 커밋 중지시킴
			
			pstmt = conn.prepareStatement(sql);
			//SQL객체의 ?에 입력값을 세팅해서 SQL문을 완성시킴
			pstmt.setLong(1, kakaoLoginVO.getKakao_id());
	        pstmt.setInt(2, kakaoLoginVO.getM_idx());
	        pstmt.setString(3, kakaoLoginVO.getKakao_nickname());
	        pstmt.setTimestamp(4, kakaoLoginVO.getCreate_at());
			
	        
			//SQL문 실행시킴
			result = pstmt.executeUpdate();
			
			conn.commit();//회원정보 입력 중 예외가 발생하지 않았을 경우 커밋
			
		} catch (Exception e) {
			System.out.println("회원정보 입력 중 예외 발생" + e.getMessage());
			e.printStackTrace(); // 예외의 자세한 스택 트레이스를 출력
			try {
				conn.rollback();//회원정보 입력 중 예외가 발생하면 이전으로 돌림
			} catch (SQLException e1) {
				System.out.println("롤백 실패");
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.setAutoCommit(true);//오토커밋 기능이 되도록 함
			} catch (SQLException e) { e.printStackTrace();}
		}
		
		return result;
		}
}