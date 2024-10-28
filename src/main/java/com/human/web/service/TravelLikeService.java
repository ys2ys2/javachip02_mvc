package com.human.web.service;

public interface TravelLikeService {
    void addLike(int tp_idx, Integer m_idx);    // 좋아요 추가
    void removeLike(int tp_idx, Integer m_idx); // 좋아요 취소
    boolean likeExists(int tp_idx, Integer m_idx); // 좋아요 존재 확인
    int getLikeCount(int tp_idx);
}
