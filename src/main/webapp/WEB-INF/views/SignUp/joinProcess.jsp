<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.human.web.vo.M_MemberVO" %>
<%@ page import="com.human.web.repository.M_MemberDAO" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 프로세스</title>
</head>
<body>
<%
    // 클라이언트가 전송한 회원가입 폼 데이터를 가져옴
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String nickname = request.getParameter("nickname");
    String inputAuthCode = request.getParameter("authCode");

    // 세션에서 인증 코드 가져오기
    String sessionAuthCode = (String) session.getAttribute("authCode");

    System.out.println("세션 인증 코드: " + sessionAuthCode);
    System.out.println("사용자가 입력한 인증 코드: " + inputAuthCode);

    // 인증 코드가 일치하지 않을 경우 회원가입을 차단
    if (inputAuthCode == null || !inputAuthCode.equals(sessionAuthCode)) {
        request.setAttribute("msg", "인증 코드가 올바르지 않습니다.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("../SignUp/join.jsp");
        dispatcher.forward(request, response);
        return; // 중단
    }

    // 입력값 검증
    if (email == null || email.isEmpty() || password == null || password.isEmpty() || nickname == null || nickname.isEmpty()) {
        request.setAttribute("msg", "모든 필드를 입력해야 합니다.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("../SignUp/join.jsp");
        dispatcher.forward(request, response);
        return; // 중단
    }

    // 이메일 형식 검증 (간단한 이메일 패턴을 사용한 검증)
    String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
    if (!email.matches(emailPattern)) {
        request.setAttribute("msg", "올바른 이메일 형식을 입력해주세요.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("../SignUp/join.jsp");
        dispatcher.forward(request, response);
        return; // 중단
    }

    // DTO 객체를 생성하여 입력받은 데이터를 저장
    M_MemberVO vo = new M_MemberVO();
    vo.setMEmail(email);  // DTO에 이메일 값 설정
    vo.setMPassword(password);  // DTO에 평문 비밀번호 설정
    vo.setMNickname(nickname);  // DTO에 닉네임 값 설정

    // DAO 객체를 생성하여 데이터베이스에 회원 정보를 삽입하는 작업 처리
    M_MemberDAO dao = new M_MemberDAO();
    int result = dao.insertM_Member(vo);  // 데이터베이스에 회원 정보 삽입
    System.out.println("DAO 메소드 호출 결과: " + result);

    // 삽입 성공 여부에 따라 다른 페이지로 리다이렉트 또는 포워딩 처리
    if (result == 1) {  // 회원가입 성공 시
        session.removeAttribute("authCode");  // 인증 코드 제거
        response.sendRedirect("${pageContext.request.contextPath}/HomePage/mainpage");  // 메인 페이지로 리다이렉트
    } else {  // 회원가입 실패 시
        request.setAttribute("msg", "회원가입이 정상적으로 이루어지지 않았습니다.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("../SignUp/join.jsp");
        dispatcher.forward(request, response);
    }
%>
</body>
</html>
