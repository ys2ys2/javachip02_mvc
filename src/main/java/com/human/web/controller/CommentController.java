package com.human.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.human.web.vo.M_MemberVO;

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
            return ResponseEntity.ok(new ArrayList<>());
        }
        return ResponseEntity.ok(comments);
    }

    // 댓글 추가
    @PostMapping(value = "/add")
    public ResponseEntity<String> addComment(@PathVariable int postId, @RequestBody CommentVO comment, HttpSession session) {
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        if (member == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        comment.setPostId(postId);
        comment.setM_idx(member.getM_idx()); // m_idx 설정
        comment.setCommentWriter(member.getM_nickname()); // comment_writer에 닉네임 설정

        commentService.addComment(comment);

        return ResponseEntity.ok("댓글이 작성되었습니다.");
    }


    // 댓글 삭제
    @DeleteMapping(value = "/{commentId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> deleteComment(@PathVariable("commentId") int commentId, @PathVariable("postId") int postId, HttpSession session) {
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        // 로그인하지 않은 경우
        if (member == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("message", "로그인이 필요합니다."));
        }

        int m_idx = member.getM_idx();
        boolean isDeleted = commentService.deleteComment(commentId, postId, m_idx);

        Map<String, String> response = new HashMap<>();
        if (isDeleted) {
            response.put("message", "댓글이 삭제되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "본인이 작성한 댓글만 삭제할 수 있습니다.");
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(response);
        }
    }

}
