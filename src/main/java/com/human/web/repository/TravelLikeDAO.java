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

    private static final String NAMESPACE = "com.human.web.mapper.TravelLikeMapper";

    public void insertLike(int tp_idx, String userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("tp_idx", tp_idx);
        params.put("userId", userId);
        sqlSession.insert(NAMESPACE + ".insertLike", params);
    }

    public void deleteLike(int tp_idx, String userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("tp_idx", tp_idx);
        params.put("userId", userId);
        sqlSession.delete(NAMESPACE + ".deleteLike", params);
    }

    public void updateLikeCount(int tp_idx) {
        sqlSession.update(NAMESPACE + ".updateLikeCount", tp_idx);
    }

    public boolean likeExists(int tp_idx, String userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("tp_idx", tp_idx);
        params.put("userId", userId);
        Integer result = sqlSession.selectOne(NAMESPACE + ".likeExists", params);
        return result != null && result > 0;
    }

    public int getLikeCount(int tp_idx) {
        return sqlSession.selectOne(NAMESPACE + ".getLikeCount", tp_idx);
    }
}
