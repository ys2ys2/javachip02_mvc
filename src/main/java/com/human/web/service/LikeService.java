package com.human.web.service;

public interface LikeService {
    void addLike(int postId, Integer m_idx);    // 좋아요 추가
    void removeLike(int postId, Integer m_idx); // 좋아요 취소
    boolean likeExists(int postId, Integer m_idx); // 좋아요 존재 확인
    int getLikeCount(int postId);
}
