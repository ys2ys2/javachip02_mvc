package com.human.web.service;

import com.human.web.vo.CommentVO;
import java.util.List;

public interface CommentService {
    List<CommentVO> getComments(int postId);  // 댓글 조회
    void addComment(CommentVO comment);       // 댓글 추가
    void deleteComment(int commentId);        // 댓글 삭제
}
