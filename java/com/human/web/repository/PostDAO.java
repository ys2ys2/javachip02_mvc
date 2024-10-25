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

import com.human.web.vo.PostVO;

public class PostDAO {
    private DataSource ds;

    public PostDAO() {
        try {
            Context initContext = new InitialContext();
            ds = (DataSource) initContext.lookup("java:/comp/env/mysql_dbcp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 게시글 저장
    public void savePost(PostVO post) {
        String sql = "INSERT INTO posts (username, content, likeCount, commentCount, createdAt) VALUES (?, ?, 0, 0, NOW())";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, post.getUsername());
            pstmt.setString(2, post.getContent());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 특정 ID의 게시글 조회
    public PostVO getPostById(int postId) {
        String sql = "SELECT * FROM posts WHERE postId = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new PostVO(
                    rs.getInt("postId"),
                    rs.getString("username"),
                    rs.getString("content"),
                    rs.getInt("likeCount"),
                    rs.getInt("commentCount"),
                    rs.getTimestamp("createdAt")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 전체 게시글 목록 조회
    public List<PostVO> getAllPosts() {
        List<PostVO> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts ORDER BY createdAt DESC";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                PostVO post = new PostVO(
                    rs.getInt("postId"),
                    rs.getString("username"),
                    rs.getString("content"),
                    rs.getInt("likeCount"),
                    rs.getInt("commentCount"),
                    rs.getTimestamp("createdAt")
                );
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // 게시글의 좋아요 수 업데이트
    public void updateLikeCount(int postId, int increment) {
        String sql = "UPDATE posts SET likeCount = likeCount + ? WHERE postId = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, increment);  // +1 또는 -1 전달
            pstmt.setInt(2, postId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 게시글의 댓글 수 업데이트
    public void updateCommentCount(int postId, int increment) {
        String sql = "UPDATE posts SET commentCount = commentCount + ? WHERE postId = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, increment);  // +1 또는 -1 전달
            pstmt.setInt(2, postId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
 

}
