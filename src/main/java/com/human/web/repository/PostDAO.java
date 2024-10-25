package com.human.web.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.CommentVO;
import com.human.web.vo.MypageVO;
import com.human.web.vo.PostVO;

@Repository
public class PostDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String POST_MAPPER = "com.human.web.mapper.PostMapper";
    private static final String COMMENT_MAPPER = "com.human.web.mapper.CommentMapper";
    private static final String MYPAGE_MAPPER = "com.human.web.mapper.MypageMapper";
  
    
    // 특정 게시글 조회

   

    

    // 모든 게시글 조회
    public List<PostVO> getAllPosts() {
        return sqlSession.selectList(POST_MAPPER + ".getAllPosts");
    }

    // 특정 게시글 조회
    public PostVO getPostById(int postId) {
        return sqlSession.selectOne(POST_MAPPER + ".getPostById", postId);
    }

    // 게시글 생성
    public int createPost(PostVO post) {
        return sqlSession.insert(POST_MAPPER + ".createPost", post);
       
    }

    // 예슬: m_mypage 테이블에 데이터 삽입
    public int createPostAndMypage(PostVO post) {
        int result = sqlSession.insert(POST_MAPPER + ".createPost", post);

        if (result > 0) {
            MypageVO mypage = new MypageVO();
            mypage.setM_idx(post.getM_idx()); // m_idx 값 설정

            sqlSession.insert(MYPAGE_MAPPER + ".insertMypage", mypage);
        }

        return result;
    }

    // 특정 게시글의 댓글 목록 조회
    public List<CommentVO> getComments(int postId) {
        return sqlSession.selectList(COMMENT_MAPPER + ".getCommentsByPostId", postId);
    }

    // 댓글 추가
    public void insertComment(CommentVO comment) {
        sqlSession.insert(COMMENT_MAPPER + ".insertComment", comment);
    }

    // 댓글 삭제
    public void deleteComment(int commentId) {
        sqlSession.delete(COMMENT_MAPPER + ".deleteComment", commentId);
    }

    // 댓글 수 업데이트
    public void updateCommentCount(int postId) {
        System.out.println("댓글 수 업데이트 - postId: " + postId);
        sqlSession.update(POST_MAPPER + ".updateCommentCount", postId);
    }

    public boolean isLikedByUser(int postId, String userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("userId", userId);
        return sqlSession.selectOne(POST_MAPPER + ".isLikedByUser", params);
    }

    
}
