package com.human.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.human.web.service.LikeService;
import com.human.web.vo.M_MemberVO;

@RestController
@RequestMapping("/post")
public class LikeController {

    @Autowired
    private LikeService likeService;

    @PostMapping(value = "/{postId}/like", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> toggleLike(
        @PathVariable("postId") int postId, HttpSession session) {

        M_MemberVO member = (M_MemberVO) session.getAttribute("member");
        if (member == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                                 .body(Map.of("message", "로그인이 필요합니다."));
        }

        Integer m_idx = member.getM_idx();
        System.out.println("로그인된 사용자 ID (m_idx): " + m_idx);
        System.out.println("좋아요 토글 요청된 게시글 ID: " + postId);

        Map<String, Object> response = new HashMap<>();

        if (likeService.likeExists(postId, m_idx)) {
            likeService.removeLike(postId, m_idx);
            response.put("isLiked", false);
        } else {
            likeService.addLike(postId, m_idx);
            response.put("isLiked", true);
        }

        response.put("likeCount", likeService.getLikeCount(postId));
        return ResponseEntity.ok(response);
    }
}
