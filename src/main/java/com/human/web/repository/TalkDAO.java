package com.human.web.repository;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.human.web.jdbc.DBCP;
import com.human.web.vo.TalkVO;


public class TalkDAO extends DBCP {

    // 댓글 입력하기
    public int insertTalk(TalkVO vo) {
        int result = 0;

        String sql = "INSERT INTO talk (talk_nickname, talk_email, talk_text) VALUES (?, ?, ?)";
        try {
            conn.setAutoCommit(false); // 오토 커밋 중지

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vo.getTalkNickname()); // talk_nickname 설정
            pstmt.setString(2, vo.getTalkEmail()); // talk_email 설정
            pstmt.setString(3, vo.getTalkText()); // talk_text 설정

            result = pstmt.executeUpdate();
            conn.commit();

        } catch (Exception e) {
            System.out.println("댓글 입력 중 예외 발생");
            e.printStackTrace();
            try {
                conn.rollback(); // 댓글 입력 중 예외 발생 시 롤백
            } catch (SQLException e1) {
                System.out.println("롤백 실패");
                e1.printStackTrace();
            }
        } finally {
            try {
                conn.setAutoCommit(true); // 오토 커밋 가능
            } catch (SQLException e) {
                e.printStackTrace();
            }
            close(); // 자원 반납
        }

        return result;
    }

    // 댓글 리스트 가져오기
    public List<TalkVO> getAllTalks() {
        List<TalkVO> talkList = new ArrayList<>(); // TalkDTO 리스트 생성
        String sql = "SELECT talk_idx, talk_nickname, talk_email, talk_text, talk_created_at, talk_updated_at FROM talk ORDER BY talk_created_at DESC";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) { // 각 댓글에 대해 반복
            	TalkVO talk = new TalkVO();
                talk.setTalkIdx(rs.getInt("talk_idx")); // talk_idx 설정 (이 부분 추가)
                talk.setTalkNickname(rs.getString("talk_nickname")); // talk_nickname 설정
                talk.setTalkEmail(rs.getString("talk_email")); // talk_email 설정 추가
                talk.setTalkText(rs.getString("talk_text")); // talk_text 설정
                talk.setTalkCreatedAt(rs.getTimestamp("talk_created_at")); // talk_created_at 설정
                talk.setTalkUpdatedAt(rs.getTimestamp("talk_updated_at")); // 수정된 시간 설정

                talkList.add(talk); // 리스트에 추가
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(); // 자원 해제
        }
        
        return talkList; // 댓글 리스트 반환
    }
    
    // 댓글 총 갯수 가져오기
    public int getTotalTalkCount() {
        int totalCount = 0;
        String sql = "SELECT COUNT(*) AS total_count FROM talk";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                totalCount = rs.getInt("total_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return totalCount;
    }

    
    // 댓글 삭제
    public int deleteTalk(int talkIdx) {
        int result = 0;
        String sql = "DELETE FROM talk WHERE talk_idx = ?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, talkIdx); // 삭제할 댓글의 ID 설정
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        
        return result;
    }
    
    
    // 댓글 수정
    public int updateTalk(int talkIdx, String updatedText) {
    	int result = 0;
    	String sql = " UPDATE talk SET talk_text = ? WHERE talk_idx = ? ";
    	
    	try {
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, updatedText);	// 수정할 댓글 내용 설정
    		pstmt.setInt(2, talkIdx);			// 수정할 댓글의 ID 설정
    		result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
        return result;
    }
    
    
}



