package com.human.web.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.web.vo.TravelMediaVO;
import com.human.web.vo.TravelPostVO;

import lombok.AllArgsConstructor;

@Repository
@AllArgsConstructor
public class TravelPostDAO {

    private final SqlSession sqlSession;
    private static final String NAMESPACE = "com.human.web.mapper.TravelPostMapper"; // MyBatis Mapper 네임스페이스

    // 여행기 등록
    public int insertTravelPost(TravelPostVO vo) {
        return sqlSession.insert(NAMESPACE + ".insertTravelPost", vo);
    }

    // 태그 등록
    public void insertTag(Map<String, Object> params) {
        sqlSession.insert(NAMESPACE + ".insertTag", params);
    }
    
    // 태그 중복 체크 (DB에서 해당 태그가 이미 있는지 확인)
    public int checkDuplicateTag(Map<String, Object> params) {
        return sqlSession.selectOne(NAMESPACE + ".checkDuplicateTag", params);
    }

    // 모든 여행기 조회
    public List<TravelPostVO> getAllPosts() {
        return sqlSession.selectList(NAMESPACE + ".getAllPosts");
    }

    // 특정 여행기 조회
    public TravelPostVO getTravelPost(int tp_idx) {
        return sqlSession.selectOne(NAMESPACE + ".getTravelPost", tp_idx);
    }

    // 첨부파일 등록
    public void insertTravelMedia(TravelMediaVO mediaVO) {
        sqlSession.insert(NAMESPACE + ".insertTravelMedia", mediaVO);
    }

    // 태그별 게시물 조회
    public List<TravelPostVO> getPostsByTag(String tag) {
        return sqlSession.selectList(NAMESPACE + ".getPostsByTag", tag);
    }

    // 태그별로 최신 게시물 3개 조회
    public List<TravelPostVO> selectRecentPostsByTag(String tag, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("tag", tag);
        params.put("limit", limit); // 최신 3개를 제한
        return sqlSession.selectList(NAMESPACE + ".selectRecentPostsByTag", params);
    }
}
