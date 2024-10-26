package com.human.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.LikeDAO;


@Service
public class LikeServiceImpl implements LikeService {

    @Autowired
    private LikeDAO likeDAO;

    @Override
    public void addLike(int postId, String userId) {
        if (likeExists(postId, userId)) {
            throw new IllegalArgumentException("이미 좋아요를 누른 게시글입니다.");
        }
        likeDAO.insertLike(postId, userId);
        likeDAO.updateLikeCount(postId); // 좋아요 개수 업데이트
    }

    @Override
    public void removeLike(int postId, String userId) {
        if (!likeExists(postId, userId)) {
            throw new IllegalArgumentException("좋아요가 존재하지 않습니다.");
        }
        likeDAO.deleteLike(postId, userId);
        likeDAO.updateLikeCount(postId); // 좋아요 개수 업데이트
    }

    @Override
    public boolean likeExists(int postId, String userId) {
        return likeDAO.likeExists(postId, userId);
    }

    @Override
    public int getLikeCount(int postId) {
        return likeDAO.getLikeCount(postId); // LikeDAO에서 좋아요 개수를 가져옴
    }
}

