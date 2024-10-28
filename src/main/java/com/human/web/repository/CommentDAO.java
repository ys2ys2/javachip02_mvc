package com.human.web.repository;

import com.human.web.vo.CommentVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class CommentDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String MAPPER = "com.human.web.mapper.CommentMapper";

    // 특정 게시글의 댓글 목록 조회
    public List<CommentVO> getCommentsByPostId(int postId) {
        return sqlSession.selectList(MAPPER + ".getCommentsByPostId", postId);
    }

    // 댓글 추가
    public void insertComment(CommentVO comment) {
        sqlSession.insert(MAPPER + ".insertComment", comment);
    }

    // 댓글 삭제
    public void deleteComment(int commentId) {
        sqlSession.delete(MAPPER + ".deleteComment", commentId);
    }
    // 댓글 작성자 확인 메서드
	public Integer getCommentAuthor(int commentId) {
		return sqlSession.selectOne(MAPPER + ".getCommentAuthor", commentId);
	}
}
