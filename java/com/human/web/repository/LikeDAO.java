package com.human.web.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.human.web.vo.LikeVO;

public class LikeDAO {
    private DataSource ds;

    public LikeDAO() {
        try {
            Context initContext = new InitialContext();
            ds = (DataSource) initContext.lookup("java:/comp/env/mysql_dbcp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 좋아요 추가
    public void saveLike(LikeVO like) {
        String sql = "INSERT INTO likes (postId, username) VALUES (?, ?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, like.getPostId());
            pstmt.setString(2, like.getUsername());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 좋아요 삭제
    public void removeLike(int postId, String username) {
        String sql = "DELETE FROM likes WHERE postId = ? AND username = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            pstmt.setString(2, username);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 사용자가 해당 게시글에 좋아요를 눌렀는지 확인
    public boolean checkIfUserLiked(int postId, String username) {
        String sql = "SELECT * FROM likes WHERE postId = ? AND username = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            pstmt.setString(2, username);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
