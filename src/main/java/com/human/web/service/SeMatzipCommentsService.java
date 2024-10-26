package com.human.web.service;

import java.util.List;

import com.human.web.vo.SeoulMatzipCommentsVO;

public interface SeMatzipCommentsService {
	    List<SeoulMatzipCommentsVO> getAllComments(); // 댓글 목록 가져오기 메서드
	    boolean deleteCommentById(int t_smc_idx);  // 댓글 삭제 메서드
	    boolean updateCommentById(int t_smc_idx, String newComment);
		int insertComment(SeoulMatzipCommentsVO commentVO); // 댓글 추가 메서드



}
