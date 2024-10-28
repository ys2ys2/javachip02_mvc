package com.human.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.LikeDAO;

@Service
public class LikeServiceImpl implements LikeService {

    @Autowired
    private LikeDAO likeDAO;

    @Override
    public void addLike(int postId, Integer m_idx) {
        if (likeExists(postId, m_idx)) {
            throw new IllegalArgumentException("이미 좋아요를 누른 게시글입니다.");
        }
        likeDAO.insertLike(postId, m_idx);
        likeDAO.updateLikeCount(postId);
    }

    @Override
    public void removeLike(int postId, Integer m_idx) {
        if (!likeExists(postId, m_idx)) {
            throw new IllegalArgumentException("좋아요가 존재하지 않습니다.");
        }
        likeDAO.deleteLike(postId, m_idx);
        likeDAO.updateLikeCount(postId);
    }

    @Override
    public boolean likeExists(int postId, Integer m_idx) {
        return likeDAO.likeExists(postId, m_idx);
    }

    @Override
    public int getLikeCount(int postId) {
        return likeDAO.getLikeCount(postId);
    }
}
