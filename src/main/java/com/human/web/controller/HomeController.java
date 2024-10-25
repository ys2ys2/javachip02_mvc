package com.human.web.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {
	
	//기타 요청URL에 대한 처리 메소드
	@GetMapping("/")
	public String home() {
		return "HomePage/mainpage";
	}
	
	@GetMapping("/index.do")
	public String index() {
		return "HomePage/mainpage";
	}
	
	@GetMapping("/error/error403.do")
	public String error403() {
		return "error/error403";
	}
	
	@GetMapping("/error/error404.do")
	public String error404() {
		return "error/error404";
	}
	
	@GetMapping("/error/error405.do")
	public String error405() {
		return "error/error405";
	}
	
	@GetMapping("/error/error500.do")
	public String error500() {
		return "error/error500";
	}
	
	//영신 핫플1(api호출만 있는 페이지)
	@GetMapping("/HotPlace/hotplace")
	public String hotplace() {
	    return "HotPlace/hotplace";
	}
	
	//영신 핫플2(DB 저장되어있는 페이지)
	@GetMapping("/HotPlace/hotplace2")
	public String hotplace2() {
	    return "HotPlace/hotplace2";
	}
	
	//예슬 로그인 페이지
	@GetMapping("/Login/login")
	public String login() {
	    return "Login/login";
	}
	
	//예슬 로그인Process = PostMapping → login.jsp에서 <form method="post">로 쓰고 있음
	@PostMapping("/Login/loginProcess")
	public String loginProcess() {
	    return "Login/loginProcess"; 
	}


	//예슬 회원가입 페이지
	@GetMapping("/SignUp/join")
	public String join() {
		return "SignUp/join";
	}

	//예슬 회원가입 process = PostMapping
	@PostMapping("/SignUp/joinProcess")
	public String joinProcess() {
		return "SignUp/joinProcess";
	}
	
	//영준 여행기 작성 페이지
    @GetMapping("/Community/c_board/travelWrite")
    public String showTravelWritePage() {
        return "Community/c_board/travelWrite";
    }

    
    
	//영준 커뮤니티 메인
    @GetMapping("/Community/c_main")
    public String c_main() {
        return "/Community/c_main";
    }
    

}
