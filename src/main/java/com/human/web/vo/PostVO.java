package com.human.web.vo;

import java.sql.Timestamp;

public class PostVO {
    private int postId;
    private String username;
    private String content;
    private int likeCount;
    private int commentCount;
    private Timestamp createdAt;

    // 기본 생성자 추가
    public PostVO() {
    }

    // 모든 필드를 포함한 생성자
    public PostVO(int postId, String username, String content, int likeCount, int commentCount, Timestamp createdAt) {
        this.postId = postId;
        this.username = username;
        this.content = content;
        this.likeCount = likeCount;
        this.commentCount = commentCount;
        this.createdAt = createdAt;
    }

    // Getter 및 Setter 메서드
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
