package com.human.web.mail;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.human.web.util.CodeGenerator;

@WebServlet("/mailSend")
public class MailSend extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        System.out.println("MailSend 서블릿 요청 수신");

        // 이메일 파라미터를 받아옴
        String email = request.getParameter("receiver");
        System.out.println("받은 이메일: " + email);  // 이메일 값을 서버 로그에 출력
        
        // 이메일 값이 null이거나 비어있는지 확인
        if (email == null || email.isEmpty()) {
            System.out.println("이메일 파라미터가 비어있습니다.");
            response.getWriter().write("이메일 파라미터가 비어있습니다.");
            return;
        }

        
        

        // SMTP 서버 설정
        Properties props = new Properties();
        props.put("mail.smtp.user", "parkyeseul.developer@gmail.com"); // 서버 아이디
        props.put("mail.smtp.host", "smtp.gmail.com"); // 구글 smtp 서버
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");

        // 구글 SMTP 서버 인증
        Authenticator auth = new GoogleAuthentication();

        // 세션 생성
        Session session = Session.getDefaultInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);

        try {
            // 메일 발송 정보 설정
            msg.setSentDate(new Date());

            // 발신자 정보 설정
            InternetAddress from = new InternetAddress("parkyeseul.developer@gmail.com", "BBOL BBOL BBOL");
            msg.setFrom(from);

            // 수신자 정보 설정
            InternetAddress to = new InternetAddress(email);  // 파라미터로 받은 이메일
            msg.setRecipient(Message.RecipientType.TO, to);

            // 인증번호 생성
            String code = CodeGenerator.generateCode();  // 6자리 랜덤 숫자 생성
            HttpSession httpSession = request.getSession(); // 세션에 인증번호 저장
            httpSession.setAttribute("authCode", code);  // 세션에 인증번호 저장

            // 메일 제목 설정
            msg.setSubject("이메일 인증번호", "UTF-8");

            // 이메일 본문 설정 (생성된 인증번호 포함)
            msg.setText("인증번호: " + code, "UTF-8");

            // 메일 헤더 설정
            msg.setHeader("Content-Type", "text/html");

            // 메일 전송
            Transport.send(msg);
            System.out.println("이메일 전송 성공");
            response.getWriter().write("이메일 전송 성공");
            
        } catch (AddressException addr_e) {
            addr_e.printStackTrace();
            response.getWriter().write("fail");
        } catch (MessagingException msg_e) {
            msg_e.printStackTrace();
            response.getWriter().write("fail");
        }

    }
}
