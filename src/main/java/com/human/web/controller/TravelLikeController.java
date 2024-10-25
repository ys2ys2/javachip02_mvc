package com.human.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.human.web.service.TravelLikeService;

@RestController
@RequestMapping("/Community/travelPost")
public class TravelLikeController {

    @Autowired
    private TravelLikeService travelLikeService;

    // 좋아요 추가 또는 취소
    @PostMapping(value = "/{tp_idx}/like", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> toggleLike(@PathVariable("tp_idx") int tp_idx, @RequestBody Map<String, String> requestData) {
        String userId = requestData.get("userId");
        System.out.println("tp_idx: " + tp_idx + ", userId: " + userId);  // tp_idx 값을 확인하는 로그 추가

        Map<String, Object> response = new HashMap<>();

        if (travelLikeService.likeExists(tp_idx, userId)) {
            // 좋아요가 이미 눌렸으면 취소 처리
            travelLikeService.removeLike(tp_idx, userId);
            response.put("isLiked", false);
        } else {
            // 좋아요 추가 처리
            travelLikeService.addLike(tp_idx, userId);
            response.put("isLiked", true);
        }

        // 새로운 좋아요 상태 및 개수 반환
        response.put("likeCount", travelLikeService.getLikeCount(tp_idx));
        return ResponseEntity.ok(response);
    }

}
