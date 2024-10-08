package com.human.web.repository;

import java.sql.SQLException;

import com.human.web.jdbc.DBCP;
import com.human.web.vo.GoogleVO;

public class GoogleDAO extends DBCP {

    // 구글 로그인 정보를 데이터베이스에 삽입하는 메서드
    public int insertGoogleLogin(GoogleVO googleVO) {
        System.out.println("insertGoogleLogin 메소드 호출됨");

        int result = 0; // 입력 실패 시 결과값

        // SQL INSERT 문 정의
        String sql = "INSERT INTO google_login (google_id, m_idx, google_name, create_at) VALUES (?, ?, ?, ?)";

        try {
            // 오토 커밋 중지
            conn.setAutoCommit(false);

            // SQL 객체 준비 및 ?에 대한 값 설정
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, googleVO.getGoogleId());
            pstmt.setInt(2, googleVO.getMIdx());
            pstmt.setString(3, googleVO.getGoogleName());
            pstmt.setTimestamp(4, googleVO.getCreateAt());

            // SQL 문 실행
            result = pstmt.executeUpdate();

            // 예외 없이 정상 실행되면 커밋
            conn.commit();

        } catch (Exception e) {
            System.out.println("구글 로그인 정보 입력 중 예외 발생: " + e.getMessage());
            e.printStackTrace(); // 예외의 자세한 스택 트레이스를 출력
            try {
                // 예외 발생 시 롤백
                conn.rollback();
            } catch (SQLException e1) {
                System.out.println("롤백 실패");
                e1.printStackTrace();
            }
        } finally {
            try {
                // 오토 커밋 기능 다시 활성화
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return result;
    }
    // 구글 사용자 정보 조회 메서드 (예시)
    public GoogleVO getGoogleUserById(String googleId) {
        // 데이터베이스에서 Google ID로 사용자 정보를 조회하는 로직 작성 필요
        return null; // 데이터 조회 후 GoogleVO 객체 반환 (임시 코드)
    }
	
	}

