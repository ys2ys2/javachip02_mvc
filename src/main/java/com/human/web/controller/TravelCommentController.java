package com.human.web.controller;

import com.human.web.service.TravelCommentService;
import com.human.web.vo.TravelCommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/Community/travelPost/{tp_idx}/comments")
public class TravelCommentController {

    @Autowired
    private TravelCommentService travelCommentService;

    // 특정 여행기의 댓글 목록 조회
    @GetMapping
    public ResponseEntity<List<TravelCommentVO>> getComments(@PathVariable("tp_idx") int tpIdx) {
        List<TravelCommentVO> comments = travelCommentService.getCommentsByTravelPostId(tpIdx);
        return ResponseEntity.ok(comments);
    }

    // 여행기 댓글 추가
    @PostMapping("/add")
    public ResponseEntity<String> addComment(@PathVariable("tp_idx") int tpIdx, @RequestBody TravelCommentVO comment) {
        comment.setTpIdx(tpIdx);
        travelCommentService.addCommentToTravelPost(comment);
        return ResponseEntity.status(HttpStatus.CREATED).body("댓글이 추가되었습니다.");
    }

    // 댓글 수정
    @PutMapping("/{commentId}/edit")
    public ResponseEntity<String> editComment(@PathVariable("commentId") int commentId, @RequestBody TravelCommentVO comment) {
        travelCommentService.updateTravelComment(commentId, comment.getCommentContent());
        return ResponseEntity.ok("댓글이 수정되었습니다.");
    }

    // 댓글 삭제
    @DeleteMapping("/{commentId}/delete")
    public ResponseEntity<String> deleteComment(@PathVariable("commentId") int commentId) {
        travelCommentService.deleteTravelComment(commentId);
        return ResponseEntity.ok("댓글이 삭제되었습니다.");
    }
}
