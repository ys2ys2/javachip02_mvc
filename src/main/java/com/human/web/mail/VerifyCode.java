package com.human.web.mail;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/verifyCode")
public class VerifyCode extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputCode = request.getParameter("authCode"); // 사용자가 입력한 인증번호
        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("authCode"); // 세션에 저장된 인증번호

        if (inputCode != null && inputCode.equals(sessionCode)) {
            response.getWriter().write("success"); // 인증번호 일치
        } else {
            response.getWriter().write("fail"); // 인증번호 불일치
        }
    }
}
