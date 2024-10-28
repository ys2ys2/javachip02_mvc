package com.human.web.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class LikeDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String MAPPER = "com.human.web.mapper.LikeMapper";

    public void insertLike(int postId, Integer m_idx) {
        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("m_idx", m_idx);
        sqlSession.insert(MAPPER + ".insertLike", params);
    }

    public void deleteLike(int postId, Integer m_idx) {
        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("m_idx", m_idx);
        sqlSession.delete(MAPPER + ".deleteLike", params);
    }

    public void updateLikeCount(int postId) {
        sqlSession.update(MAPPER + ".updateLikeCount", postId);
    }

    public boolean likeExists(int postId, Integer m_idx) {
        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("m_idx", m_idx);
        Integer result = sqlSession.selectOne(MAPPER + ".likeExists", params);
        return result != null && result > 0;
    }

    public int getLikeCount(int postId) {
        return sqlSession.selectOne(MAPPER + ".getLikeCount", postId);
    }
}
