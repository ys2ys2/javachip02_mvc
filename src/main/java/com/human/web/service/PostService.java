package com.human.web.service;

import com.human.web.vo.PostVO;
import java.util.List;

public interface PostService {
    List<PostVO> getAllPosts();  // 모든 게시글 조회
    PostVO getPostById(int postId);  // ID로 게시글 조회
    int createPost(PostVO post);  // 게시글 생성
    void updateCommentCount(int postId); // 댓글 수 업데이트
    
    // 특정 게시글에 대해 사용자가 좋아요를 눌렀는지 여부 확인
    boolean isLikedByUser(int postId, int m_idx);
}
