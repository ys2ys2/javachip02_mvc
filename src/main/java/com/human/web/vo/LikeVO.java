package com.human.web.vo;

import java.time.LocalDateTime;

public class LikeVO {
    private int likeId;           // 좋아요 ID
    private int postId;           // 게시글 ID
    private String userId;        // 좋아요를 누른 사용자 ID
    private LocalDateTime likeDate; // 좋아요 누른 날짜

    // 기본 생성자
    public LikeVO() {}

    // 매개변수 생성자
    public LikeVO(int likeId, int postId, String userId, LocalDateTime likeDate) {
        this.likeId = likeId;
        this.postId = postId;
        this.userId = userId;
        this.likeDate = likeDate;
    }

    // Getters and Setters
    public int getLikeId() {
        return likeId;
    }

    public void setLikeId(int likeId) {
        this.likeId = likeId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public LocalDateTime getLikeDate() {
        return likeDate;
    }

    public void setLikeDate(LocalDateTime likeDate) {
        this.likeDate = likeDate;
    }

    @Override
    public String toString() {
        return "LikeVO{" +
                "likeId=" + likeId +
                ", postId=" + postId +
                ", userId='" + userId + '\'' +
                ", likeDate=" + likeDate +
                '}';
    }
}
