package com.human.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.human.web.service.TravelLikeService;
import com.human.web.vo.M_MemberVO;

@RestController
@RequestMapping("/Community/travelPost")
public class TravelLikeController {

    @Autowired
    private TravelLikeService travelLikeService;

    // 좋아요 추가 또는 취소
    @PostMapping(value = "/{tp_idx}/like", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> toggleLike(
        @PathVariable("tp_idx") int tp_idx, HttpServletRequest request) {
        
        // 세션에서 로그인된 사용자 정보 가져오기
        HttpSession session = request.getSession();
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        if (member == null) {
            // 로그인되지 않은 사용자는 좋아요 요청 불가능
            return ResponseEntity.status(403).body(null);  // 권한 거부 상태 반환
        }

        Integer m_idx = member.getM_idx();  // 현재 로그인된 사용자의 m_idx 가져오기
        System.out.println("tp_idx: " + tp_idx + ", m_idx: " + m_idx);  // tp_idx와 m_idx 값 확인 로그 추가

        Map<String, Object> response = new HashMap<>();

        if (travelLikeService.likeExists(tp_idx, m_idx)) {
            // 이미 좋아요가 눌려있으면 취소 처리
            travelLikeService.removeLike(tp_idx, m_idx);
            response.put("isLiked", false);
        } else {
            // 좋아요 추가 처리
            travelLikeService.addLike(tp_idx, m_idx);
            response.put("isLiked", true);
        }

        // 새로운 좋아요 상태 및 개수 반환
        response.put("likeCount", travelLikeService.getLikeCount(tp_idx));
        return ResponseEntity.ok(response);
    }
}
