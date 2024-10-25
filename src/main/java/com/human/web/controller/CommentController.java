package com.human.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.human.web.service.CommentService;
import com.human.web.service.PostService;
import com.human.web.vo.CommentVO;

@RestController
@RequestMapping("/post/{postId}/comments")
public class CommentController {

    @Autowired
    private CommentService commentService;
    @Autowired
    private PostService postService;

    // 특정 게시글의 댓글 목록 조회
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<CommentVO>> getComments(@PathVariable("postId") int postId) {
        List<CommentVO> comments = commentService.getComments(postId);
        if (comments == null || comments.isEmpty()) {
            System.out.println("댓글이 존재하지 않습니다.");
            return ResponseEntity.ok(new ArrayList<>()); // 빈 배열 반환
        }
        return ResponseEntity.ok(comments);
    }

    // 댓글 추가
    @PostMapping(value = "/add", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> addComment(@PathVariable int postId, @RequestBody CommentVO comment) {
        try {
            System.out.println("댓글 작성 시도 - postId: " + postId + ", 내용: " + comment.getCommentContent());

            comment.setPostId(postId);
            commentService.addComment(comment);

            // 댓글 수 업데이트
            postService.updateCommentCount(postId);

            Map<String, String> response = new HashMap<>();
            response.put("message", "댓글이 작성되었습니다.");
            return ResponseEntity.ok().body(response);
        } catch (Exception e) {
            e.printStackTrace(); // 로그로 오류를 확인하세요
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "댓글 작성 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    // 댓글 삭제
    @DeleteMapping(value = "/{commentId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> deleteComment(@PathVariable("commentId") int commentId) {
        commentService.deleteComment(commentId);
        Map<String, String> response = new HashMap<>();
        response.put("message", "댓글이 삭제되었습니다.");
        return ResponseEntity.ok(response);
    }

}
