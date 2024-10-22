package com.human.web.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.human.web.repository.TravelPostDAO;
import com.human.web.vo.TravelMediaVO;
import com.human.web.vo.TravelPostVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class TravelPostServiceImpl implements TravelPostService {

    private final TravelPostDAO travelPostDAO;

    // 트랜잭션을 적용하여 포스트 삽입과 태그 삽입을 하나의 트랜잭션으로 처리
    @Override
    @Transactional
    public int insertTravelPost(TravelPostVO vo, HttpServletRequest request) {
        // 포스트 삽입
        int result = travelPostDAO.insertTravelPost(vo);

        // 태그 삽입 (포스트가 성공적으로 삽입된 경우에만 태그 삽입)
        if (vo.getTags() != null && !vo.getTags().isEmpty()) {
            for (String tag : vo.getTags()) {
                Map<String, Object> params = Map.of("tp_idx", vo.getTp_idx(), "tag", tag);
                
                // 태그 중복 체크 후 삽입
                int count = travelPostDAO.checkDuplicateTag(params);
                if (count == 0) {
                    travelPostDAO.insertTag(params);
                }
            }
        }

        return result;
    }

    // 태그 삽입 메서드
    @Override
    public void insertTag(Map<String, Object> params) {
        travelPostDAO.insertTag(params);
    }

    // 모든 게시물 조회
    @Override
    public List<TravelPostVO> getAllPosts() {
        return travelPostDAO.getAllPosts();
    }

    // 특정 게시물 조회
    @Override
    public TravelPostVO getTravelPost(int tp_idx) {
        return travelPostDAO.getTravelPost(tp_idx);
    }

    // 첨부파일 삽입
    @Override
    public void insertTravelMedia(TravelMediaVO mediaVO) {
        travelPostDAO.insertTravelMedia(mediaVO);
    }

    // 태그별 게시물 조회
    @Override
    public List<TravelPostVO> getPostsByTag(String tag) {
        return travelPostDAO.getPostsByTag(tag);
    }

    // 태그별로 최신 게시물 3개 조회
    @Override
    public List<TravelPostVO> getRecentPostsByTag(String tag) {
        return travelPostDAO.selectRecentPostsByTag(tag, 3); // 최신 3개를 가져옴
    }

    // 태그 중복 체크
    @Override
    public int checkDuplicateTag(Map<String, Object> params) {
        return travelPostDAO.checkDuplicateTag(params);
    }
}
