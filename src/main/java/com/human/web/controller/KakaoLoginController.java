package com.human.web.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.human.web.service.KakaoService;

@WebServlet("/login/kakao")
public class KakaoLoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accessToken = req.getParameter("accessToken");
        if (accessToken == null || accessToken.isEmpty()) {
            System.out.println("액세스 토큰이 전달되지 않았습니다.");
            resp.getWriter().write("액세스 토큰이 전달되지 않았습니다.");
            return;
        }
        System.out.println("액세스 토큰: " + accessToken);

        try {
            // 사용자 정보를 데이터베이스에 저장
            KakaoService kakaoService = new KakaoService();
            kakaoService.saveUserInfo(accessToken);
            resp.sendRedirect(req.getContextPath() + "/index.jsp"); // 로그인 후 메인 페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("카카오 로그인 중 오류가 발생했습니다.");
        }
    }
}
