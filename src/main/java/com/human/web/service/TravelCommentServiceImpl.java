package com.human.web.service;

import com.human.web.repository.TravelCommentDAO;
import com.human.web.repository.TravelPostDAO;
import com.human.web.vo.TravelCommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TravelCommentServiceImpl implements TravelCommentService {

    @Autowired
    private TravelCommentDAO travelCommentDAO;

    @Autowired
    private TravelPostDAO travelPostDAO;  // 댓글 수 업데이트를 위해 필요

    @Override
    public List<TravelCommentVO> getCommentsByTravelPostId(int tpIdx) {
        return travelCommentDAO.getCommentsByTravelPostId(tpIdx);
    }

    @Override
    @Transactional
    public void addCommentToTravelPost(TravelCommentVO comment) {
        travelCommentDAO.insertTravelComment(comment);
        travelPostDAO.updateCommentCount(comment.getTpIdx());  // 댓글 수 업데이트
    }

    @Override
    @Transactional
    public void deleteTravelComment(int commentId) {
        travelCommentDAO.deleteTravelComment(commentId);
        // tpIdx는 별도로 필요하지 않으므로 여기서 삭제
    }

    @Override
    @Transactional
    public void updateTravelComment(int commentId, String commentContent) {
        travelCommentDAO.updateTravelComment(commentId, commentContent);
    }

	@Override
	public int getCommentAuthorId(int commentId) {
		return travelCommentDAO.getCommentAuthorId(commentId);
	}
}
