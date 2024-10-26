package com.human.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
//수정테스트
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.human.web.service.EventsService;
import com.human.web.service.M_MemberService;
import com.human.web.service.SeMatzipCommentsService;
import com.human.web.vo.EventsCommentsVO;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.SeoulMatzipCommentsVO;

import lombok.RequiredArgsConstructor;

@RestController // @Controller + @ResponseBody
@RequiredArgsConstructor
public class AjaxController {

    // 필드 정의
    private final M_MemberService m_memberServiceImpl;
    private final EventsService eventsServiceImpl; // 행사 댓글 관련 처리
    private final SeMatzipCommentsService seMatzipCommentsServiceImpl; // 맛집 댓글 관련 처리

    // 아이디 중복검사
    @PostMapping("/Member/checkId")
    public String checkId(@RequestParam("m_email") String m_email) {
        String result = "PASS"; // 중복된 아이디가 없는 경우 기본값

        try {
            if (m_memberServiceImpl.checkId(m_email) >= 1) {
                result = "FAIL";
            }
        } catch (Exception e) {
            System.out.println("아이디 중복 검사 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    // 닉네임 중복 체크
    @PostMapping("/Member/checkNickname")
    public String checkNickname(@RequestParam("m_nickname") String m_nickname) {
        String result = "PASS";

        try {
            if (m_memberServiceImpl.checkNickname(m_nickname) >= 1) {
                result = "FAIL";
            }
        } catch (Exception e) {
            System.out.println("닉네임 중복 검사 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    // 댓글 추가 메서드
    @PostMapping("/Festival/comments")
    public String addComment(int m_idx, String comment) {

        System.out.println("m_idx:" + m_idx + ", comment:" + comment);

        // 댓글 객체 생성 및 데이터 설정
        EventsCommentsVO commentVO = new EventsCommentsVO();
        commentVO.setT_comment_author_id(m_idx); // 작성자 ID 설정
        commentVO.setT_comment_content(comment); // 댓글 내용 설정

        String result = "FAIL"; // 댓글 추가 실패시 결과값
        try {
            // 서비스 메서드 호출
            if (eventsServiceImpl.insertComment(commentVO) == 1) {
                result = "SUCCESS";
            }
            ;
            System.out.println("댓글추가 결과: " + result); // Insert 결과 로그

        } catch (Exception e) {
            // 에러 발생 시 로그 출력
            e.printStackTrace();
            System.out.println("댓글 등록 중 오류 발생");
        }

        return result;
    }

    @GetMapping("/Festival/commentsList")
    public String getCommentsList(@RequestParam("eventId") int eventId, Model model) {
        // List<EventsCommentsVO> commentsList =
        // eventsServiceImpl.getAllCommentsByEventId(eventId);
        // model.addAttribute("commentsList", commentsList);
        return "fragments/commentsListFragment"; // JSP 파일 경로를 반환
    }

    // 댓글 삭제
    @PostMapping("/Festival/deleteComment")
    public String deleteComment(int t_ec_idx, int t_comment_author_id, HttpServletRequest request) {
        String result = "FAIL";// 댓글삭제 실패시 결과값

        // 세션에 저장된 회원정보 가져오기
        HttpSession session = request.getSession();
        M_MemberVO member = (M_MemberVO) session.getAttribute("member"); // 세션에서 로그인한 사용자 ID 가져오기

        // 댓글 작성자와 로그인한 사용자가 같은지 확인
        if (member.getM_idx() == t_comment_author_id) {
            // 작성자가 동일할 때만 삭제
            boolean isDeleted = eventsServiceImpl.deleteCommentById(t_ec_idx);
            result = isDeleted ? "SUCCESS" : "FAIL";
        }

        return result; // 작성자와 일치하지 않으면 실패
    }

    // 댓글 수정
    @PostMapping("/Festival/editComment")
    public String editComment(@RequestParam("commentId") int t_ec_idx,
            @RequestParam("newComment") String newComment,
            @RequestParam("authorId") int authorId,
            HttpServletRequest request) {
        String result = "FAIL"; // 기본적으로 실패로 설정

        // 세션에서 로그인된 사용자 정보를 가져옴
        HttpSession session = request.getSession();
        M_MemberVO member = (M_MemberVO) session.getAttribute("member"); // 로그인한 사용자 정보 가져오기

        if (member == null) {
            return "FAIL"; // 로그인 정보가 없으면 실패 처리
        }
        // 댓글이 존재하고, 댓글 작성자와 로그인한 사용자가 같은지 확인
        if (authorId == member.getM_idx()) {
            // 댓글 작성자가 일치하는 경우 댓글 수정 처리
            boolean isUpdated = eventsServiceImpl.updateCommentById(t_ec_idx, newComment);
            result = isUpdated ? "SUCCESS" : "FAIL";
        }

        return result; // 성공 여부 반환
    }

    // -------------------------------- 맛집 관련 -------------------------------------

    // 댓글 추가 메서드
    @PostMapping("/Matzip/comments")
    public String addComment2(int m_idx, int t_sm_idx, String comment) {

        System.out.println("m_idx: " + m_idx + ", t_sm_idx:" + t_sm_idx + ", comment:" + comment);

        // 댓글 객체 생성 및 데이터 설정
        SeoulMatzipCommentsVO commentVO = new SeoulMatzipCommentsVO();
        commentVO.setT_smc_author_id(m_idx); // 작성자 ID 설정
        commentVO.setT_sm_idx(t_sm_idx); // 맛집 ID
        commentVO.setT_smc_content(comment); // 댓글 내용 설정

        String result = "FAIL"; // 댓글 추가 실패시 결과값
        try {
            // 서비스 메서드 호출
            // 서비스 메서드 호출

            if (seMatzipCommentsServiceImpl.insertComment(commentVO) == 1) {
                result = "SUCCESS";
            }
            ;
            System.out.println("댓글추가 결과: " + result); // Insert 결과 로그

        } catch (Exception e) {
            // 에러 발생 시 로그 출력
            e.printStackTrace();
            System.out.println("댓글 등록 중 오류 발생");
        }

        return result;
    }

    @GetMapping("/Matzip/commentsList")
    public String getCommentsList2(@RequestParam("eventId") int eventId, Model model) {
        // List<EventsCommentsVO> commentsList =
        // eventsServiceImpl.getAllCommentsByEventId(eventId);
        // model.addAttribute("commentsList", commentsList);
        return "fragments/commentsListFragment"; // JSP 파일 경로를 반환
    }

    // 댓글 삭제
    @PostMapping("/Matzip/deleteComment")
    public String deleteComment2(int t_smc_idx, int t_smc_author_id, HttpServletRequest request) {
        String result = "FAIL";// 댓글삭제 실패시 결과값

        // 세션에 저장된 회원정보 가져오기
        HttpSession session = request.getSession();
        M_MemberVO member = (M_MemberVO) session.getAttribute("member"); // 세션에서 로그인한 사용자 ID 가져오기

        // 댓글 작성자와 로그인한 사용자가 같은지 확인
        if (member.getM_idx() == t_smc_author_id) {
            // 작성자가 동일할 때만 삭제
            boolean isDeleted = seMatzipCommentsServiceImpl.deleteCommentById(t_smc_idx);
            result = isDeleted ? "SUCCESS" : "FAIL";
        }

        return result; // 작성자와 일치하지 않으면 실패
    }

    // 댓글 수정
    @PostMapping("/Matzip/editComment")
    public String editComment2(@RequestParam("commentId") int t_smc_idx,
            @RequestParam("newComment") String newComment,
            @RequestParam("authorId") int authorId,
            HttpServletRequest request) {
        String result = "FAIL"; // 기본적으로 실패로 설정

        // 세션에서 로그인된 사용자 정보를 가져옴
        HttpSession session = request.getSession();
        M_MemberVO member = (M_MemberVO) session.getAttribute("member"); // 로그인한 사용자 정보 가져오기

        if (member == null) {
            return "FAIL"; // 로그인 정보가 없으면 실패 처리
        }
        // 댓글이 존재하고, 댓글 작성자와 로그인한 사용자가 같은지 확인
        if (authorId == member.getM_idx()) {
            // 댓글 작성자가 일치하는 경우 댓글 수정 처리
            boolean isUpdated = seMatzipCommentsServiceImpl.updateCommentById(t_smc_idx, newComment);
            result = isUpdated ? "SUCCESS" : "FAIL";
        }

        return result; // 성공 여부 반환
    }

}
