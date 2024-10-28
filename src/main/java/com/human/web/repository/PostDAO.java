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

    private static final String POST_NAMESPACE = "com.human.web.mapper.PostMapper";
    private static final String COMMENT_NAMESPACE = "com.human.web.mapper.CommentMapper";
    private static final String MYPAGE_MAPPER = "com.human.web.mapper.MypageMapper";

    public List<PostVO> getAllPosts() {
        return sqlSession.selectList(POST_NAMESPACE + ".getAllPosts");
    }

    public PostVO getPostById(int postId) {
        return sqlSession.selectOne(POST_NAMESPACE + ".getPostById", postId);
    }

    public int createPost(PostVO post) {
        return sqlSession.insert(POST_NAMESPACE + ".createPost", post);
    }

    public List<CommentVO> getComments(int postId) {
        return sqlSession.selectList(COMMENT_NAMESPACE + ".getCommentsByPostId", postId);
    }

    public void insertComment(CommentVO comment) {
        sqlSession.insert(COMMENT_NAMESPACE + ".insertComment", comment);
    }

    public void deleteComment(int commentId) {
        sqlSession.delete(COMMENT_NAMESPACE + ".deleteComment", commentId);
    }

    public void updateCommentCount(int postId) {
        System.out.println("댓글 수 업데이트 - postId: " + postId);
        sqlSession.update(POST_NAMESPACE + ".updateCommentCount", postId);
    }

    public boolean isLikedByUser(int postId, int m_idx) {
        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("m_idx", m_idx);
        return sqlSession.selectOne(POST_NAMESPACE + ".isLikedByUser", params);
    }

    // 예슬: m_mypage 테이블에 데이터 삽입
    public int createPostAndMypage(PostVO post) {
        int result = sqlSession.insert(POST_NAMESPACE + ".createPost", post);

        if (result > 0) {
            MypageVO mypage = new MypageVO();
            mypage.setM_idx(post.getM_idx()); // m_idx 값 설정

            sqlSession.insert(MYPAGE_MAPPER + ".insertMypage", mypage);
        }

        return result;
    }

}