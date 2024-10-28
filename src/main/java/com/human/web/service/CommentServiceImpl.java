package com.human.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.CommentDAO;
import com.human.web.repository.PostDAO;
import com.human.web.vo.CommentVO;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentDAO commentDAO;

    @Autowired
    private PostDAO postDAO;

    @Override
    public List<CommentVO> getComments(int postId) {
        return commentDAO.getCommentsByPostId(postId);
    }

    @Override
    public void addComment(CommentVO comment) {
        commentDAO.insertComment(comment);
        updateCommentCount(comment.getPostId());  // 댓글 추가 후 댓글 수 업데이트
    }

   

    @Override
    public void updateCommentCount(int postId) {
        postDAO.updateCommentCount(postId);  // 댓글 수 업데이트 쿼리 호출
    }
    @Override
    public boolean deleteComment(int commentId, int postId, int m_idx) {
        Integer authorIdx = commentDAO.getCommentAuthor(commentId);

        if (authorIdx != null && authorIdx == m_idx) { // 작성자 확인
            commentDAO.deleteComment(commentId);
            postDAO.updateCommentCount(postId); // 댓글 수 감소
            return true;
        } else {
            return false; // 작성자가 일치하지 않을 경우 삭제 불가
        }
    }
	
}

