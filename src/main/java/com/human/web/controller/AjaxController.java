package com.human.web.controller;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.human.web.service.EventsService;
import com.human.web.service.M_MemberService;
import com.human.web.vo.EventsCommetsVO;

import lombok.AllArgsConstructor;

@RestController //@Controller + @ResponseBody
@AllArgsConstructor
public class AjaxController {
	
	//필드 정의
	private M_MemberService m_memberServiceImpl;
	private EventsService eventsServiceImpl;
	
	// 아이디 중복검사
    @PostMapping("/Member/checkId")
    public String checkId(@RequestParam("m_email") String m_email) {
        String result = "PASS";  // 중복된 아이디가 없는 경우 기본값

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

    @PostMapping("/Member/checkNickname")
    public String checkNickname(@RequestParam("m_nickname") String m_nickname) {
    	String result = "PASS";
    	
    	try {
			if(m_memberServiceImpl.checkNickname(m_nickname) >= 1) {
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
    public ModelAndView addComment(int m_idx, String comment) {
    	
    	System.out.println("m_idx: "+m_idx);

        // 댓글 객체 생성 및 데이터 설정
        EventsCommetsVO commentVO = new EventsCommetsVO();
        commentVO.setT_comment_author_id(m_idx); // 작성자 ID 설정
        commentVO.setT_comment_content(comment); // 댓글 내용 설정

        int result = eventsServiceImpl.insertComment(commentVO); // 서비스 메서드 호출

        // 리다이렉트와 메시지 설정
        ModelAndView mav = new ModelAndView("redirect:/Festival/commentsList");
        if (result > 0) {
            mav.addObject("message", "댓글이 등록되었습니다.");
        } else {
            mav.addObject("message", "댓글 등록 실패.");
        }
        return mav;
    }

    // 댓글 목록 가져오기 메서드
    @GetMapping("/Festival/commentsList")
    public String getComments(Model model) {
        // 모든 댓글 가져오기
        List<EventsCommetsVO> comments = eventsServiceImpl.getAllComments();

        // Model에 데이터 추가
        model.addAttribute("comments", comments);

        return "Festival/commentsList"; // 뷰 반환
    }
    
    
	
}
