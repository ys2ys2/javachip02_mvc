package com.human.web.vo;

import java.time.LocalDateTime;

public class TravelLikeVO {
    private int likeId;
    private int tpIdx;
    private String userId;
    private LocalDateTime likeDate;

    public TravelLikeVO() {}

    public TravelLikeVO(int likeId, int tpIdx, String userId, LocalDateTime likeDate) {
        this.likeId = likeId;
        this.tpIdx = tpIdx;
        this.userId = userId;
        this.likeDate = likeDate;
    }

    public int getLikeId() {
        return likeId;
    }

    public void setLikeId(int likeId) {
        this.likeId = likeId;
    }

    public int getTpIdx() {
        return tpIdx;
    }

    public void setTpIdx(int tpIdx) {
        this.tpIdx = tpIdx;
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
        return "TravelLikeVO{" +
                "likeId=" + likeId +
                ", tpIdx=" + tpIdx +
                ", userId='" + userId + '\'' +
                ", likeDate=" + likeDate +
                '}';
    }
}
