package com.human.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.PostDAO;
import com.human.web.vo.PostVO;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostDAO postDAO;
    
    @Override
    public List<PostVO> getAllPosts() {
        return postDAO.getAllPosts();
    }

    @Override
    public PostVO getPostById(int postId) {
        return postDAO.getPostById(postId);
    }

    public int createPost(PostVO post) {
        return postDAO.createPost(post); // post 객체에 m_idx가 포함되어 있어야 함
    }

   
    @Override
    public void updateCommentCount(int postId) {
        postDAO.updateCommentCount(postId);
    }
    
    // 특정 사용자가 해당 게시글을 좋아요 했는지 여부 확인
    @Override
    public boolean isLikedByUser(int postId, int m_idx) {
        return postDAO.isLikedByUser(postId, m_idx);
    }
}
