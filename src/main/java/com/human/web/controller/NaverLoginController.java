package com.human.web.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.human.web.service.NaverLoginService;

@Controller
@RequestMapping("/naver")
public class NaverLoginController {

    @Autowired
    private NaverLoginService naverLoginService;

    // 네이버 회원가입/로그인 페이지로 리다이렉트
    @GetMapping("/login")
    public void naverLogin(HttpServletResponse response, HttpSession session) throws IOException {
        String clientId = "hNC1YTLpfwJa8Hc6uBaJ";
        String redirectURI = "http://localhost:9090/BBOL/naver/callback";
        String state = "RANDOM_STATE"; // CSRF 방지를 위한 상태값

        // 상태값을 세션에 저장 (CSRF 방지)
        session.setAttribute("state", state);

        String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=" + clientId +
                        "&redirect_uri=" + redirectURI + "&state=" + state;

        response.sendRedirect(apiURL);
    }

    // 네이버 회원가입/로그인 콜백 처리
    @GetMapping("/callback")
    public String naverCallback(@RequestParam("code") String code,
                                @RequestParam("state") String state, HttpSession session) {
        // 세션에 저장된 상태값 가져오기
        String sessionState = (String) session.getAttribute("state");

        // 상태값 검증
        if (sessionState == null || !sessionState.equals(state)) {
            System.out.println("CSRF 검증 실패: state 값 불일치");
            return "redirect:/Member/joinmain";
        }

        // 네이버 회원가입/로그인 처리
        try {
            boolean isLoginSuccessful = naverLoginService.processNaverLogin(code, state, session);
            return isLoginSuccessful ? "redirect:/index.do" : "redirect:/Member/joinmain";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/Member/join";
        }
    }
}
