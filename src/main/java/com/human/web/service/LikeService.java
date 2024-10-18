package com.human.web.service;


public interface LikeService {
    void addLike(int postId, String userId);    // 좋아요 추가
    void removeLike(int postId, String userId); // 좋아요 취소
	boolean likeExists(int postId, String userId);
	int getLikeCount(int postId);
}
