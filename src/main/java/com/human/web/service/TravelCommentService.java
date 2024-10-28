package com.human.web.service;

import com.human.web.vo.TravelCommentVO;
import java.util.List;

public interface TravelCommentService {
    List<TravelCommentVO> getCommentsByTravelPostId(int tpIdx);  // 특정 여행기의 댓글 조회
    void addCommentToTravelPost(TravelCommentVO comment);        // 댓글 추가
    void deleteTravelComment(int commentId);                     // 댓글 삭제
    void updateTravelComment(int commentId, String commentContent);  // 댓글 수정
	int getCommentAuthorId(int commentId);
}
