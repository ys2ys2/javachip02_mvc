package com.human.web.vo;

import java.sql.Timestamp;

public class CommentVO {
    private int commentId;
    private int postId;
    private String username;
    private String content;
    private Timestamp createdAt;

    // 기본 생성자
    public CommentVO() {}

    // 모든 필드를 포함한 생성자
    public CommentVO(int commentId, int postId, String username, String content, Timestamp createdAt) {
        this.commentId = commentId;
        this.postId = postId;
        this.username = username;
        this.content = content;
        this.createdAt = createdAt;
    }

    // Getter 및 Setter 메소드
    public int getCommentId() { return commentId; }
    public void setCommentId(int commentId) { this.commentId = commentId; }

    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
