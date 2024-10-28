package com.human.web.repository;

import com.human.web.vo.TravelCommentVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class TravelCommentDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String MAPPER = "com.human.web.mapper.TravelCommentMapper";

    // 특정 여행기의 댓글 목록 조회
    public List<TravelCommentVO> getCommentsByTravelPostId(int tpIdx) {
        return sqlSession.selectList(MAPPER + ".getCommentsByTravelPostId", tpIdx);
    }

    // 여행기 댓글 추가
    public void insertTravelComment(TravelCommentVO comment) {
        sqlSession.insert(MAPPER + ".insertTravelComment", comment);
    }

    // 여행기 댓글 삭제
    public void deleteTravelComment(int commentId) {
        sqlSession.delete(MAPPER + ".deleteTravelComment", commentId);
    }

    // 댓글 수정
    public void updateTravelComment(int commentId, String commentContent) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("commentId", commentId);
        paramMap.put("commentContent", commentContent);
        sqlSession.update(MAPPER + ".updateTravelComment", paramMap);
    }

	public int getCommentAuthorId(int commentId) {
		 return sqlSession.selectOne(MAPPER + ".getCommentAuthorId", commentId);
	}
}
