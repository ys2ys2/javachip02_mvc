package com.human.web.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.web.service.M_MemberService;
import com.human.web.vo.M_MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/Member") //공통으로 적용되는 URL 정의
//lombok을 적용해서 생성자를 이용한 의존 자동주입 
@RequiredArgsConstructor
public class M_MemberController {

	private final M_MemberService m_memberServiceImpl;

    // 회원가입 페이지
    @GetMapping("/joinmain")
    public String joinmain() {
        return "Member/joinmain"; // 회원가입 폼으로 이동
    }
    
    
    //이메일 회원가입 페이지
    @GetMapping("/join")
    public String join() {
        return "Member/join"; // 회원가입 폼으로 이동
    }
    
    
    //프로필 변경
    @GetMapping("/m_updateProfile")
    public String m_updateProfile() {
        return "Member/m_updateProfile"; // 프로필 변경
    }
    
    
 // 회원가입 처리 요청
    @PostMapping("/joinProcess")
    public String joinProcess(@ModelAttribute M_MemberVO memberVO, Model model) {
        // 회원가입 결과를 처리할 뷰 이름 초기화
        String viewName = "Member/join"; // 회원가입 실패 시 반환할 뷰

        // MemberServiceImpl 클래스를 통해 회원가입 요청 처리
        int result = m_memberServiceImpl.insertM_Member(memberVO);
        System.out.println("insertM_Member 반환값: " + result);  // 반환값 확인

        // 회원가입 성공 여부 확인 (m_idx가 0보다 크면 성공)
        if (result > 0) {
            viewName = "redirect:/index.do"; // 성공 시 메인 페이지로 리다이렉트
        } else {
            // 회원가입 실패 시 오류 메시지를 모델에 저장
            model.addAttribute("msg", "회원가입이 정상적으로 이루어지지 않았습니다.");
        }

        return viewName; // 처리된 뷰 이름 반환
    }

   
	
    //로그인 페이지 요청
  	@GetMapping("/login")
  	public String login() {
  		return "Member/login";
  	}
  	
  
  	//로그인 처리 요청
  	@PostMapping("/loginProcess")
  	public String loginProcess(String m_email, String m_password,
  			HttpServletRequest request, Model model) {
  		System.out.println("로그인 요청이 들어왔습니다: " + m_email);  // 로그 추가
  		
  		String viewName = "Member/login"; //로그인 실패시 뷰이름
  		
  		M_MemberVO vo = m_memberServiceImpl.login(m_email, m_password);
  		
  		//로그인 성공여부를 vo객체에 저장된 값으로 판단
  		if(vo != null) {//로그인 성공
  			//세션객체에 회원정보를 저장함(request객체의 getSession()메소드 이용)
  			HttpSession session = request.getSession();
  			session.setAttribute("member", vo);
  			
  			System.out.println("세션에 저장된 회원 정보: " + session.getAttribute("member"));  
  		    System.out.println("닉네임: " + vo.getM_nickname());  
  		    
  			viewName = "redirect:/HomePage/mainpage";//메인 페이지 재요청
  			
  		}else {//로그인 실패
  			model.addAttribute("msg", "아이디나 비밀번호가 일치하지 않습니다");
  		}
  		
  		return viewName;
  	}
  	
  	
	  	
		//로그아웃 요청
		@PostMapping("/logout")
		public String logout(HttpServletRequest request) {
			//세션객체를 초기화 시킴(request객체의 getSession()메소드 이용해서 세션객체 얻음)
			HttpSession session = request.getSession(false);
			if(session != null) {
				session.invalidate();
			}
			return "redirect:/index.do";				
		}
		
		

		//회원정보 변경 처리 요청
		@PostMapping("/updateProcess")
		public String updateProcess(M_MemberVO vo, HttpServletRequest request, Model model) {
		    
		    String viewName = "Member/m_updateProfile"; // 회원정보 변경 실패 시 반환할 뷰 이름

		    // 회원 정보 업데이트 요청
		    M_MemberVO newVo = m_memberServiceImpl.updateMember(vo);
		    
		    // 1. 회원 정보 변경 성공 여부 판단
		    if (newVo != null) {
		        // 회원정보 변경 성공
		        HttpSession session = request.getSession();
		        session.removeAttribute("member");
		        session.setAttribute("member", newVo);
		        viewName = "redirect:/MyPage/myPageMain"; // 성공 시 메인 페이지로 리다이렉트
		    } else {
		        // 회원 정보 변경 실패
		        int nicknameCount = m_memberServiceImpl.checkNickname(vo.getM_nickname());
		        if (nicknameCount > 0) {
		            model.addAttribute("msg", "닉네임이 중복되었습니다. 다른 닉네임을 사용해 주세요.");
		        } else {
		            model.addAttribute("msg", "회원정보 변경 중 오류가 발생했습니다. 변경 내용을 확인해 주세요.");
		        }
		    }

		    return viewName; // 실패 시 업데이트 페이지로 다시 이동
		}

		
		
		
		//회원탈퇴 요청
		@GetMapping("/cancelProcess")
		public String cancelProcess(HttpServletRequest request, Model model) {
			HttpSession session = request.getSession();
			M_MemberVO vo = (M_MemberVO)session.getAttribute("member");
			int m_idx = vo.getM_idx();
			
			int result = m_memberServiceImpl.cancel(m_idx);
			
			String viewName = "member/update";//회원탈퇴 실패시 뷰이름
			
			if(result == 1) {//회원탈퇴 성공
				session.invalidate();//세션 초기화
				viewName = "redirect:/index.do";
				
			}else {//회원탈퇴 실패
				String msg = "시스템에 오류가 발생했습니다. 빠른 시일 내에 시스템을 정상화하도록 하겠습니다.";
				model.addAttribute("msg", msg);
			}
			
			return viewName;
		}
		
		
		
}
		
  	
  

