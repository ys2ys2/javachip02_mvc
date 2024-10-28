package com.human.web.vo;

import java.time.LocalDateTime;

public class TravelLikeVO {
    private int likeId;
    private int tp_idx;               // 여행기 ID
    private Integer m_idx;            // 사용자 ID (m_idx로 변경)
    private LocalDateTime likeDate;   // 좋아요 누른 날짜

    public TravelLikeVO() {}

    public TravelLikeVO(int likeId, int tp_idx, Integer m_idx, LocalDateTime likeDate) {
        this.likeId = likeId;
        this.tp_idx = tp_idx;
        this.m_idx = m_idx;
        this.likeDate = likeDate;
    }

    public int getLikeId() {
        return likeId;
    }

    public void setLikeId(int likeId) {
        this.likeId = likeId;
    }

    public int getTp_idx() {
        return tp_idx;
    }

    public void setTp_idx(int tp_idx) {
        this.tp_idx = tp_idx;
    }

    public Integer getM_idx() {
        return m_idx;
    }

    public void setM_idx(Integer m_idx) {
        this.m_idx = m_idx;
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
                ", tp_idx=" + tp_idx +
                ", m_idx=" + m_idx +
                ", likeDate=" + likeDate +
                '}';
    }
}
