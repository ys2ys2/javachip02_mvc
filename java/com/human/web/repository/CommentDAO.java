package com.human.web.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.human.web.vo.CommentVO;

public class CommentDAO {
    private DataSource ds;

    public CommentDAO() {
        try {
            Context initContext = new InitialContext();
            ds = (DataSource) initContext.lookup("java:/comp/env/mysql_dbcp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 댓글 저장 및 댓글 수 업데이트 메서드
    public void saveComment(CommentVO comment) {
        String sql = "INSERT INTO comments (postId, username, content, createdAt) VALUES (?, ?, ?, NOW())";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, comment.getPostId());
            pstmt.setString(2, comment.getUsername());
            pstmt.setString(3, comment.getContent());
            pstmt.executeUpdate();
            updateCommentCount(comment.getPostId());  // 댓글 수 업데이트 호출
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 댓글 수 업데이트 메서드
    private void updateCommentCount(int postId) {
        String updateSql = "UPDATE posts SET commentCount = commentCount + 1 WHERE postId = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
            pstmt.setInt(1, postId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<CommentVO> getCommentsByPostId(int postId) {
        List<CommentVO> comments = new ArrayList<>();
        String sql = "SELECT * FROM comments WHERE postId = ? ORDER BY createdAt ASC";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                CommentVO comment = new CommentVO();
                comment.setCommentId(rs.getInt("commentId"));
                comment.setPostId(rs.getInt("postId"));
                comment.setUsername(rs.getString("username"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getTimestamp("createdAt"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
    
}
