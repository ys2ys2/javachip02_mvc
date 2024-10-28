package com.human.web.service;

import com.human.web.vo.CommentVO;
import java.util.List;

public interface CommentService {
    List<CommentVO> getComments(int postId);  // 댓글 조회
    void addComment(CommentVO comment);       // 댓글 추가
    boolean deleteComment(int commentId, int postId, int m_idx); // 댓글 삭제 (작성자 확인 포함)
    void updateCommentCount(int postId);	 // 댓글 수 업데이트
}
