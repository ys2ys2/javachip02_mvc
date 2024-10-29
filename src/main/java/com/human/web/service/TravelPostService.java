package com.human.web.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.human.web.vo.TravelMediaVO;
import com.human.web.vo.TravelPostVO;

public interface TravelPostService {

    // 여행기 포스트 작성 메서드
    int insertTravelPost(TravelPostVO vo, HttpServletRequest request);

    // 태그 삽입 메서드
    void insertTag(Map<String, Object> params);

    // 태그 중복 체크 메서드
    int checkDuplicateTag(Map<String, Object> params);

    // 특정 여행기 게시물 조회
    TravelPostVO getTravelPost(int tp_idx);

    // 첨부파일 처리 메서드
    void insertTravelMedia(TravelMediaVO mediaVO);

    // 태그를 기반으로 게시물 조회
    List<TravelPostVO> getPostsByTag(String tag);

    // 최신 3개 게시물을 태그별로 조회
    List<TravelPostVO> getRecentPostsByTag(String tag);

    // 필터와 페이지네이션을 적용하여 게시물 조회
    List<TravelPostVO> getPostsByFilterWithPagination(String filter, int page, int pageSize);

    // 필터에 따른 게시물 수 조회
    int getTotalPostCountByFilter(String filter);

    // 페이지네이션을 적용한 모든 게시물 조회
    List<TravelPostVO> getAllPostsWithPagination(int page, int pageSize);

    // 전체 게시물 수 조회
    int getTotalPostCount();

    List<TravelPostVO> getAllPosts();

    List<TravelPostVO> getPostsByFilterAndQuery(String filter, int page, int pageSize, String query);

    int countPostsByFilterAndQuery(String filter, String query);

    // 랜덤으로 메인페이지에 TravelPost 가져오기
	List<Map<String, Object>> getRandomTravelPost(int limit);
	 
	
}
