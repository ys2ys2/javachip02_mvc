package com.human.web.service;

import com.human.web.repository.TravelLikeDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TravelLikeServiceImpl implements TravelLikeService {

    @Autowired
    private TravelLikeDAO travelLikeDAO;

    @Override
    public void addLike(int tp_idx, String userId) {
        if (likeExists(tp_idx, userId)) {
            throw new IllegalArgumentException("이미 좋아요를 누른 여행기입니다.");
        }
        travelLikeDAO.insertLike(tp_idx, userId);
        travelLikeDAO.updateLikeCount(tp_idx);
    }

    @Override
    public void removeLike(int tp_idx, String userId) {
        if (!likeExists(tp_idx, userId)) {
            throw new IllegalArgumentException("좋아요가 존재하지 않습니다.");
        }
        travelLikeDAO.deleteLike(tp_idx, userId);
        travelLikeDAO.updateLikeCount(tp_idx);
    }

    @Override
    public boolean likeExists(int tp_idx, String userId) {
        return travelLikeDAO.likeExists(tp_idx, userId);
    }

    @Override
    public int getLikeCount(int tp_idx) {
        return travelLikeDAO.getLikeCount(tp_idx);
    }
}
