<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     

<c:set var="m_email" value="${param.m_email}" />
<c:set var="m_password" value="${param.m_password}" />
<!-- JSP useBean 액션태그를 이용해서 MemberDAO 객체 생성 -->
<jsp:useBean id="dao" class="com.human.web.repository.M_MemberDAO" />


<!-- 로그인 결과 확인 -->
<c:set var="result" value="${dao.login(m_email, m_password)}" />


<!-- // 사용자가 입력한 이메일과 비밀번호를 request 객체에서 가져옴
    String m_email = request.getParameter("m_email"); // 입력한 이메일을 가져옴
    String m_password = request.getParameter("m_password"); // 입력한 비밀번호를 가져옴

    // DAO 객체를 생성하여 데이터베이스와 상호작용3
    M_MemberDAO dao = new M_MemberDAO(); -->
    
    <c:choose>
<c:when test="${result eq 1}">
<!-- 로그인 성공 시 이메일로 회원 정보 조회 -->
	<jsp:useBean id="member" class="com.human.web.vo.M_MemberVO" />
    <c:set var="member" value="${dao.getM_Member(m_email)}" />



    <!-- 세션에 이메일과 닉네임 저장 -->
    <c:set var="memberEmail" value="${member.m_email}" scope="session" />
    <c:set var="memberNickname" value="${member.m_nickname}" scope="session" />
    
    
    <!-- 메인 페이지로 리다이렉트 -->
<c:redirect url="${pageContext.request.contextPath}/HomePage/mainpage" />

</c:when>

<c:otherwise>
<jsp:forward page="${pageContext.request.contextPath}/Login/login">
<jsp:param name="msg" value="아이디나 비밀번호가 일치하지 않습니다" />
</jsp:forward>
</c:otherwise>
</c:choose>