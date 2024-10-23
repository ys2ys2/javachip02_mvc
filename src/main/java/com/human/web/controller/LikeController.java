package com.human.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.human.web.service.LikeService;

@RestController
@RequestMapping("/post")
public class LikeController {

    @Autowired
    private LikeService likeService;

    // 좋아요 추가 또는 취소 (produces를 사용해 JSON으로 응답)
    @PostMapping(value = "/{postId}/like", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> toggleLike(@PathVariable int postId, @RequestBody Map<String, String> requestData) {
        String userId = requestData.get("userId");
        System.out.println("postId: " + postId + ", userId: " + userId);  // 로그 추가
        
        Map<String, Object> response = new HashMap<>();
        
        if (likeService.likeExists(postId, userId)) {
            // 좋아요가 이미 눌렸으면 취소 처리
            likeService.removeLike(postId, userId);
            response.put("isLiked", false);
        } else {
            // 좋아요 추가 처리
            likeService.addLike(postId, userId);
            response.put("isLiked", true);
        }

        // 새로운 좋아요 상태 및 개수 반환
        response.put("likeCount", likeService.getLikeCount(postId)); // 좋아요 수 가져오기
        return ResponseEntity.ok(response);
    }

    // 좋아요 여부 확인 (produces를 사용해 JSON으로 응답)
    @GetMapping(value = "/{postId}/like/exists", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> likeExists(@PathVariable int postId, @RequestParam String userId) {
        boolean exists = likeService.likeExists(postId, userId);

        // 좋아요 여부와 좋아요 개수를 함께 반환
        Map<String, Object> response = new HashMap<>();
        response.put("isLiked", exists);
        response.put("likeCount", likeService.getLikeCount(postId)); // 좋아요 수 가져오기
        return ResponseEntity.ok(response);
    }
}
