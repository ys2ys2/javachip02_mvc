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

    // 여행기 포스트를 작성하고, 태그를 추가하는 메서드
    @Override
    @Transactional
    public int insertTravelPost(TravelPostVO vo, HttpServletRequest request) {
        // 게시글을 먼저 삽입하고 tp_idx를 가져옵니다.
        int result = travelPostDAO.insertTravelPost(vo);

        // 게시글 삽입이 성공적으로 완료된 경우에만 태그를 추가합니다.
        Integer tp_idx = vo.getTp_idx(); // 새로 생성된 tp_idx를 가져옵니다.
        if (result > 0 && tp_idx != null) {
            // 태그 추가 로직 수행
            insertTagsForPost(tp_idx, vo.getTags());
        } else {
            throw new IllegalStateException("게시글 삽입 실패 또는 tp_idx 누락");
        }

        return result;
    }


    // 게시글에 태그 삽입 및 중복 확인 로직을 캡슐화한 메서드
    private void insertTagsForPost(int tp_idx, List<String> tags) {
        if (tags == null || tags.isEmpty()) {
            return;
        }

        for (String tag : tags) {
            Map<String, Object> params = Map.of("tp_idx", tp_idx, "tag", tag);
            if (travelPostDAO.checkDuplicateTag(params) == 0) {
                travelPostDAO.insertTag(params);
            } else {
                System.out.println("중복된 태그: " + tag);
            }
        }
    }



    // 태그 삽입 메서드
    @Override
    public void insertTag(Map<String, Object> params) {
        travelPostDAO.insertTag(params);
    }

    // 모든 게시물을 가져오는 메서드
    @Override
    public List<TravelPostVO> getAllPosts() {
        return travelPostDAO.getAllPosts();
    }

    // 특정 여행기 게시물을 조회하는 메서드
    @Override
    public TravelPostVO getTravelPost(int tp_idx) {
        TravelPostVO post = travelPostDAO.getTravelPost(tp_idx);

        // 태그 추가
        List<String> tags = travelPostDAO.getTagsForPost(tp_idx);
        post.setTags(tags);

        return post;
    }

    // 첨부파일을 처리하는 메서드
    @Override
    public void insertTravelMedia(TravelMediaVO mediaVO) {
        travelPostDAO.insertTravelMedia(mediaVO);
    }

    // 특정 태그를 기반으로 게시물을 조회하는 메서드
    @Override
    public List<TravelPostVO> getPostsByTag(String tag) {
        return travelPostDAO.getPostsByTag(tag);
    }

    // 특정 태그로 최신 3개의 게시물을 조회하는 메서드
    @Override
    public List<TravelPostVO> getRecentPostsByTag(String tag) {
        return travelPostDAO.selectRecentPostsByTag(tag, 3);
    }

    // 태그 중복 여부를 확인하는 메서드
    @Override
    public int checkDuplicateTag(Map<String, Object> params) {
        return travelPostDAO.checkDuplicateTag(params);
    }

    // 페이지네이션과 필터를 적용하여 게시물을 가져오는 메서드
    @Override
    public List<TravelPostVO> getPostsByFilterWithPagination(String filter, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return travelPostDAO.getPostsByFilterWithPagination(filter, offset, pageSize);
    }

    // 특정 필터에 해당하는 게시물의 총 개수를 가져오는 메서드
    @Override
    public int getTotalPostCountByFilter(String filter) {
        return travelPostDAO.getTotalPostCountByFilter(filter);
    }

    // 페이지네이션을 적용하여 모든 게시물을 가져오는 메서드
    @Override
    public List<TravelPostVO> getAllPostsWithPagination(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return travelPostDAO.getAllPostsWithPagination(pageSize, offset);
    }

    // 모든 게시물의 총 개수를 가져오는 메서드
    @Override
    public int getTotalPostCount() {
        return travelPostDAO.getTotalPostCount();
    }

    @Override
    public List<TravelPostVO> getPostsByFilterAndQuery(String filter, int page, int pageSize, String query) {
        int offset = (page - 1) * pageSize;
        return travelPostDAO.selectPostsByFilterAndQuery(filter, offset, pageSize, query);
    }

    @Override
    public int countPostsByFilterAndQuery(String filter, String query) {
        return travelPostDAO.countPostsByFilterAndQuery(filter, query);
    }

    //랜덤으로 커뮤니티 가져오기
    @Override
    public List<Map<String, Object>> getRandomTravelPost(int limit) {
        return travelPostDAO.getRandomTravelPost(limit);
    }
}
