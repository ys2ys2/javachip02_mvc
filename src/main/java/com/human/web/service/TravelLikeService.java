package com.human.web.service;

public interface TravelLikeService {
    void addLike(int tp_idx, String userId);    // 좋아요 추가
    void removeLike(int tp_idx, String userId); // 좋아요 취소
    boolean likeExists(int tp_idx, String userId);
    int getLikeCount(int tp_idx);
}
