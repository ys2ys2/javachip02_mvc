package com.human.web.service;

import com.human.web.repository.CommentDAO;
import com.human.web.vo.CommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentDAO commentDAO;

    @Override
    public List<CommentVO> getComments(int postId) {
        return commentDAO.getCommentsByPostId(postId);
    }

    @Override
    public void addComment(CommentVO comment) {
        commentDAO.insertComment(comment);
    }

    @Override
    public void deleteComment(int commentId) {
        commentDAO.deleteComment(commentId);
    }
}
