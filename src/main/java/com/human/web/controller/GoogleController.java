package com.human.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.human.web.service.GoogleService;
import com.human.web.vo.M_MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/auth/google")
public class GoogleController {

    private final GoogleService googleService;
    // 구글 인증 완료 후 리다이렉트 URL (회원가입 및 로그인 처리)
    @GetMapping("/callback")
    public String googleCallback(@RequestParam("code") String code, HttpSession session, Model model) {
        try {
            M_MemberVO memberVO = googleService.handleGoogleCallback(code); // 회원가입 또는 로그인 처리

            if (memberVO != null) {
                // 세션에 M_MemberVO 객체 저장
                session.setAttribute("member", memberVO); 
                return "redirect:/index.do"; // 메인 페이지로 리다이렉트
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Google 회원가입/로그인 처리 중 오류가 발생했습니다.");
        }
        return "redirect:/Member/joinmain"; // 회원가입 페이지로 리다이렉트
    }
 // 구글 로그인 처리
    @GetMapping("/login")
    public String googleLoginCallback(@RequestParam("code") String code, HttpSession session, Model model) {
        try {
            M_MemberVO memberVO = googleService.handleGoogleLoginCallback(code); // 로그인 처리

            if (memberVO != null) {
                session.setAttribute("member", memberVO); // 로그인 정보 세션에 저장
                return "redirect:/index.do"; // 로그인 성공 시 메인 페이지로 이동
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Google 로그인 처리 중 오류가 발생했습니다.");
        }
        return "redirect:/Member/login"; // 로그인 실패 시 다시 로그인 페이지로 리디렉트
    }
}