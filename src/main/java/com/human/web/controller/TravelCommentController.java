package com.human.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.human.web.service.TravelCommentService;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.TravelCommentVO;

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
    public ResponseEntity<String> addComment(@PathVariable("tp_idx") int tpIdx, @RequestBody TravelCommentVO comment, HttpServletRequest request) {
        HttpSession session = request.getSession();
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        if (member == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        // 댓글 작성자 정보 설정
        comment.setTpIdx(tpIdx);
        comment.setM_idx(member.getM_idx()); // 여기서 m_idx를 설정합니다.
        comment.setCommentWriter(member.getM_nickname());  // 로그인한 사용자의 닉네임 설정
        
        System.out.println("member 정보: " + member); // member 객체가 null인지 확인
        System.out.println("m_idx 값: " + member.getM_idx()); // m_idx 값이 올바르게 설정되는지 확인
        System.out.println("작성자 닉네임: " + member.getM_nickname());
        travelCommentService.addCommentToTravelPost(comment);

        return ResponseEntity.status(HttpStatus.CREATED).body("댓글이 추가되었습니다.");
    }



 // 댓글 수정
    @PutMapping("/{commentId}/edit")
    public ResponseEntity<String> editComment(@PathVariable("commentId") int commentId, 
                                              @RequestBody TravelCommentVO comment,
                                              HttpSession session) {
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");
        if (member == null || travelCommentService.getCommentAuthorId(commentId) != member.getM_idx()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("수정 권한이 없습니다.");
        }

        travelCommentService.updateTravelComment(commentId, comment.getCommentContent());
        return ResponseEntity.ok("댓글이 수정되었습니다.");
    }

    // 댓글 삭제
    @DeleteMapping("/{commentId}/delete")
    public ResponseEntity<String> deleteComment(@PathVariable("commentId") int commentId, HttpSession session) {
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");
        if (member == null || travelCommentService.getCommentAuthorId(commentId) != member.getM_idx()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("삭제 권한이 없습니다.");
        }

        travelCommentService.deleteTravelComment(commentId);
        return ResponseEntity.ok("댓글이 삭제되었습니다.");
    }


}
