<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- 로그인 페이지: 메인 페이지에서 로그인 버튼이 클릭되면 이 로그인 화면으로 이동함 -->
<!-- 사용자가 로그인 정보를 입력하고, 로그인 버튼을 클릭하면 loginProcess.jsp로 데이터를 전송하는 형태로 작성할 수 있음 -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> <!-- header.css -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css"> <!-- login.css -->
    <title>로그인</title>
</head>
<body>
  <!-- 어두운 배경 -->
  <div class="overlay"></div>
  <header>
    <div class="header-container">
      <div class="logo">
        <a href="${pageContext.request.contextPath}/HomePage/mainpage">BBOL BBOL BBOL</a>
      </div>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/HomePage/mainpage">홈</a></li>
          <li><a href="#">커뮤니티</a></li>
          <li><a href="${pageContext.request.contextPath}/HotPlace/hotplace2">여행지</a></li>
          <li><a href="#">여행뽈뽈</a></li>
        </ul>
      </nav>
      <div class="member">
        <c:choose>
          <c:when test="${not empty sessionScope.member}">
            <!-- 로그인 성공 시, 마이페이지와 로그아웃 표시 -->
            <span>${sessionScope.member.m_nickname}님 환영합니다!</span>
            <span><a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지</a></span>
            <form action="${pageContext.request.contextPath}/Member/logout" method="post" style="display:inline;">
              <button type="submit">로그아웃</button>
            </form>
          </c:when>
          <c:otherwise>
            <!-- 로그인 실패 시, 로그인과 회원가입 표시 -->
            <span><a href="${pageContext.request.contextPath}/Member/login">로그인</a></span>
            <span><a href="${pageContext.request.contextPath}/Member/signup">회원가입</a></span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>

<div class="login-form-container">
   <h1 class="bbol-logo">BBOL BBOL BBOL</h1>
  <h1 class="bbol-login-title">로그인하고 여행을 시작해 보세요</h1>
		<form method="post" action="loginProcess" class="bbol-login-form">
        <!-- 이메일 입력 필드 -->
        <label for="email">이메일</label>
        <input type="text" id="email" name="m_email" placeholder="example@bbol.com" required>

        <!-- 비밀번호 입력 필드 -->
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="m_password" placeholder="........" required>

        <!-- 로그인 옵션 및 링크 -->
        <div class="bbol-login-options">
            <label><input type="checkbox"> 로그인 유지</label>
            <a href="#">아이디 · 비밀번호 찾기</a>
        </div>

        <!-- 로그인 버튼 -->
        <button type="submit" class="bbol-login-button">로그인</button>

        <!-- 중간의 "또는" 텍스트 -->
        <div class="bbol-divider">
            <span>또는</span>
        </div>

        <!-- SNS 로그인 버튼 -->
        <div class="bbol-sns-buttons">
            <img src="${pageContext.request.contextPath}/resources/images/kakaotalkicon.png" alt="Kakao" class="bbol-sns-icon">
            <img src="${pageContext.request.contextPath}/resources/images/navericon.png" alt="Naver" class="bbol-sns-icon">
            <img src="${pageContext.request.contextPath}/resources/images/googleicon.png" alt="Google" class="bbol-sns-icon">
        </div>

        <!-- 회원가입 유도 -->
        <div class="bbol-signup-prompt">
            아직 회원이 아니신가요? <span onclick="location.href='${pageContext.request.contextPath}/SignUp/join'">회원가입</span>
        </div>
    </form>
</div>

  
    <!-- 로그인 실패 시 오류 메시지 출력 -->
<!-- 로그인 실패 시 오류 메시지 출력 -->
<c:if test="${not empty msg}">
		<p> ${msg} </p>
	</c:if>

    

</body>
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
</html>
