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
    private static final String NAMESPACE = "com.human.web.mapper.TravelPostMapper";

    // 여행기 게시물 삽입
    public int insertTravelPost(TravelPostVO vo) {
        return sqlSession.insert(NAMESPACE + ".insertTravelPost", vo);
    }

    // 태그 삽입
    public void insertTag(Map<String, Object> params) {
        sqlSession.insert(NAMESPACE + ".insertTag", params);
    }

    // 태그 중복 여부 확인
    public int checkDuplicateTag(Map<String, Object> params) {
        return sqlSession.selectOne(NAMESPACE + ".checkDuplicateTag", params);
    }

    // 모든 여행기 게시물 조회
    public List<TravelPostVO> getAllPosts() {
        return sqlSession.selectList(NAMESPACE + ".getAllPosts");
    }

    // 특정 여행기 게시물 조회
    public TravelPostVO getTravelPost(int tp_idx) {
        return sqlSession.selectOne(NAMESPACE + ".getTravelPost", tp_idx);
    }

    // 태그 리스트 가져오기
    public List<String> getTagsForPost(int tp_idx) {
        return sqlSession.selectList(NAMESPACE + ".getTagsForPost", tp_idx);
    }

    // 첨부파일 삽입
    public void insertTravelMedia(TravelMediaVO mediaVO) {
        sqlSession.insert(NAMESPACE + ".insertTravelMedia", mediaVO);
    }

    // 태그를 기반으로 게시물 조회
    public List<TravelPostVO> getPostsByTag(String tag) {
        return sqlSession.selectList(NAMESPACE + ".getPostsByTag", tag);
    }

    // 최신 게시물 3개 조회
    public List<TravelPostVO> selectRecentPostsByTag(String tag, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("tag", tag);
        params.put("limit", limit);
        return sqlSession.selectList(NAMESPACE + ".selectRecentPostsByTag", params);
    }

    // 필터와 페이지네이션을 적용한 게시물 조회
    public List<TravelPostVO> getPostsByFilterWithPagination(String filter, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("filter", filter);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return sqlSession.selectList(NAMESPACE + ".getPostsByFilterWithPagination", params);
    }

    // 필터에 맞는 게시물 수 조회
    public int getTotalPostCountByFilter(String filter) {
        return sqlSession.selectOne(NAMESPACE + ".getTotalPostCountByFilter", filter);
    }

    // 페이지네이션을 적용한 모든 게시물 조회
    public List<TravelPostVO> getAllPostsWithPagination(int pageSize, int offset) {
        Map<String, Object> params = new HashMap<>();
        params.put("pageSize", pageSize);
        params.put("offset", offset);
        return sqlSession.selectList(NAMESPACE + ".getAllPostsWithPagination", params);
    }

    // 전체 게시물 수 조회
    public int getTotalPostCount() {
        return sqlSession.selectOne(NAMESPACE + ".getTotalPostCount");
    }

    // 필터와 검색어로 게시글 목록을 가져오는 메서드
    public List<TravelPostVO> selectPostsByFilterAndQuery(String filter, int offset, int pageSize, String query) {
        Map<String, Object> params = new HashMap<>();
        params.put("filter", filter != null && !filter.equals("전체") ? filter : null);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        params.put("query", query);
        return sqlSession.selectList(NAMESPACE + ".selectPostsByFilterAndQuery", params);
    }

    // 필터와 검색어로 게시글의 총 개수를 가져오는 메서드
    public int countPostsByFilterAndQuery(String filter, String query) {
        Map<String, Object> params = new HashMap<>();
        params.put("filter", filter != null && !filter.equals("전체") ? filter : null);
        params.put("query", query);
        return sqlSession.selectOne(NAMESPACE + ".countPostsByFilterAndQuery", params);
    }

    // 댓글 수 업데이트
    public void updateCommentCount(int tpIdx) {
        sqlSession.update(NAMESPACE + ".updateCommentCount", tpIdx);
    }

}
