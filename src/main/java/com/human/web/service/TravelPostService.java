package com.human.web.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.human.web.vo.TravelMediaVO;
import com.human.web.vo.TravelPostVO;

public interface TravelPostService {

    int insertTravelPost(TravelPostVO vo, HttpServletRequest request);

    void insertTag(Map<String, Object> params);  // 태그 삽입 메서드
    
    int checkDuplicateTag(Map<String, Object> params); // 태그 중복 체크
    
    List<TravelPostVO> getAllPosts();

    TravelPostVO getTravelPost(int tp_idx);

    void insertTravelMedia(TravelMediaVO mediaVO); // 첨부파일 처리
    
    List<TravelPostVO> getPostsByTag(String tag); // 태그로 게시물 조회
    
    List<TravelPostVO> getRecentPostsByTag(String tag); // 태그별로 최신 3개의 게시물 가져오기
}
