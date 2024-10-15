package com.human.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.human.web.service.KakaoService;
import com.human.web.vo.M_MemberVO;

@Controller
public class KakaoLoginController {

    @Autowired
    private KakaoService kakaoService;

    // 카카오 회원가입 처리
    @GetMapping("/signup/kakao")
    public ModelAndView kakaoSignup(@RequestParam("accessToken") String accessToken) {
        ModelAndView mav = new ModelAndView();
        try {
            kakaoService.saveUserInfo(accessToken);
            mav.setViewName("redirect:/index.do");  // 회원가입 후 메인 페이지로 이동
        } catch (Exception e) {
            mav.addObject("error", "카카오 회원가입 중 오류가 발생했습니다.");
            mav.setViewName("error");
        }
        return mav;
    }

    // 카카오 로그인 처리
    @GetMapping("/login/kakao")
    public String kakaoLogin(@RequestParam("accessToken") String accessToken, HttpSession session) {
        try {
            // 카카오 서비스에서 사용자 정보 가져오기
            M_MemberVO memberInfo = kakaoService.saveUserInfo(accessToken);  // 사용자 정보 처리 후 저장
            
            // 세션에 사용자 정보를 저장
            session.setAttribute("member", memberInfo);  // 세션에 사용자 정보 저장
            System.out.println("카카오 사용자 정보가 세션에 저장되었습니다: " + memberInfo);

            // 로그인 성공 후 메인 페이지로 리다이렉트
            return "redirect:/index.do";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/error/errorPage";  // 에러 발생 시 에러 페이지로 이동
        }
    }
}