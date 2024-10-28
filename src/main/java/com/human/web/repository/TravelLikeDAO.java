package com.human.web.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class TravelLikeDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String MAPPER = "com.human.web.mapper.TravelLikeMapper";

    public void insertLike(int tp_idx, Integer m_idx) {
        Map<String, Object> params = new HashMap<>();
        params.put("tp_idx", tp_idx);
        params.put("m_idx", m_idx);
        sqlSession.insert(MAPPER + ".insertLike", params);
    }

    public void deleteLike(int tp_idx, Integer m_idx) {
        Map<String, Object> params = new HashMap<>();
        params.put("tp_idx", tp_idx);
        params.put("m_idx", m_idx);
        sqlSession.delete(MAPPER + ".deleteLike", params);
    }

    public void updateLikeCount(int tp_idx) {
        sqlSession.update(MAPPER + ".updateLikeCount", tp_idx);
    }

    public boolean likeExists(int tp_idx, Integer m_idx) {
        Map<String, Object> params = new HashMap<>();
        params.put("tp_idx", tp_idx);
        params.put("m_idx", m_idx);
        Integer result = sqlSession.selectOne(MAPPER + ".likeExists", params);
        return result != null && result > 0;
    }

    public int getLikeCount(int tp_idx) {
        return sqlSession.selectOne(MAPPER + ".getLikeCount", tp_idx);
    }
}
