<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>

<html lang="ko">
<head>

	<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
  	<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/resources/css/introduce.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BBOL BBOL BBOL 회사소개</title>

</head>
<body>

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
            <div class="welcome">${sessionScope.member.m_nickname}님 환영합니다!</div>
            <span><a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지</a></span>
            <form action="${pageContext.request.contextPath}/Member/logout" method="post" style="display:inline;">
              <button type="submit">로그아웃</button>
            </form>
          </c:when>
          <c:otherwise>
            <!-- 로그인 실패 시, 로그인과 회원가입 표시 -->
            <span><a href="${pageContext.request.contextPath}/Member/login">로그인</a></span>
            <span><a href="${pageContext.request.contextPath}/Member/join">회원가입</a></span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>
  
<div class="introduce">

	<div class="introimg"
		style="background-image: url('${pageContext.request.contextPath}/resources/images/introimg.png');">
		<h2>회사 소개</h2>
		<h1>뽈뽈뽈 소개</h1>
	</div>
	
	<!-- 네비바 부분 -->
    <div class="i_section-container">
      <ul class="i_navbar">
        <li class="i_nav-item"><a href="${pageContext.request.contextPath}/FooterPage/introduce">회사소개</a></li>
        <li class="i_nav-item"><a href="${pageContext.request.contextPath}/HotPlace/inputApi" target="_blank" >공공데이터 API</a></li>
        <li class="i_nav-item"><a href="#">공지사항</a></li>
        <li class="i_nav-item"><a href="mailto:support@BBOL3.com">제휴문의</a></li>
      </ul>
  </div>
  

  <div class="introduce-main">
    <div class="introduce-mainintro">
      <img src="${pageContext.request.contextPath}/resources/images/intromain.jpg" alt="소개 이미지"> <!-- 추가한 이미지 -->
    </div>
    <div class="introduce-text">
      <h2>세상의 모든 여행</h2>
      <p>뽈뽈뽈은 전세계 여행자들이 우리의 플랫폼을 통해<br>
      	 콘텐츠와 여행 기록을 공유하고, 서로의 정보를 나누는 생태계를 만들어 갑니다.</p>
      <p>사용자가 만들어가는 사용자를 위한 콘텐츠 플랫폼,<br>
      	 뽈뽈뽈이 만드는 또다른 세상입니다.</p>
    </div>
  </div>
  
  <div class="centertext">
  	<h1>뽈뽈뽈</h1>
  	<h3>세상 모든 여행자를 위한 여행 플랫폼</h3>
  </div>
  
  <div class="introduce-content">
    <div class="introduce-text">
      <h2>공공데이터를 활용한<br>
      	  여행지 추천</h2>
      <p>당신이 찾는 모든 여행 정보!<br>
      	 공공데이터로 여행지를 추천받고<br>
      	 직접 여행 일정까지 만들 수 있는 플랫폼!</p>
    </div>
    <div class="introduce-company">
      <img src="${pageContext.request.contextPath}/resources/images/intro01.jpg" alt="소개 이미지"> <!-- 추가한 이미지 -->
    </div>
  </div>
  
  <div class="introduce-content">
    <div class="introduce-company">
      <img src="${pageContext.request.contextPath}/resources/images/intro02.jpg" alt="소개 이미지"> <!-- 추가한 이미지 -->
    </div>
    <div class="introduce-text">
      <h2>내가 만드는 여행일정</h2>
      <p>언제, 어디를, 누구와, 어떻게<br>
      	 쉽고 빠르게 만드는 여행 일정</p>
    </div>
  </div>
  
  <div class="introduce-content">
    <div class="introduce-text">
      <h2>우리들이 쓰는 여행기</h2>
      <p>소소한 일상부터 여행지에서의 추억을<br>
      	 기록하고 공유하는 여행기</p>
    </div>
    <div class="introduce-company">
      <img src="${pageContext.request.contextPath}/resources/images/intro03.jpg" alt="소개 이미지"> <!-- 추가한 이미지 -->
    </div>
  </div>
  
   <div class="introduce-content">
   	<div class="introduce-company">
      <img src="${pageContext.request.contextPath}/resources/images/intro04.jpg" alt="소개 이미지"> <!-- 추가한 이미지 -->
   	</div>
    <div class="introduce-text">
      <h2>모두의 커뮤니티</h2>
      <p>여행을 사랑하는 사람들과 나누는<br>
      	 생생한 여행 공유 공간</p>
    </div>
  </div>
  
  
  


	
  
</div>






<!-- 푸터 부분 -->
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h4>회사소개</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/introduce" target="_blank">회사소개</a></li>
        <li><a href="${pageContext.request.contextPath}/HotPlace/inputApi"target="_blank">공공데이터 API</a></li>
        <li><a href="#">채용공고</a></li>
      </ul>
    </div>

    <!-- 고객지원 -->
    <div class="footer-section">
      <h4>고객지원</h4>
      <ul>
        <li><a href="#">공지사항</a></li>
        <li><a href="#">자주묻는 질문</a></li>
        <li><a href="#">문의하기</a></li>
      </ul>
    </div>

    <!-- 이용약관 -->
    <div class="footer-section">
      <h4>이용약관</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/clause" target="_blank">이용약관</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank">개인정보처리방침</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/marketing" target="_blank">광고성 정보 수신동의</a></li>
      </ul>
    </div>

    <!-- 회사 정보 -->
    <div class="footer-company-info">
      <p>상호: (주)BBOL | 대표: 박예슬 | 사업자등록번호: 123-45-67890 | 통신판매업 신고번호: 2024-충남천안-00000 | 개인정보관리 책임자: 수수옥</p>
      <p>주소: 충청남도 천안시 동남구 123 | 이메일: support@BBOL3.com | 대표전화: 02-1234-5678</p>
      <p>© 2024 BBOLBBOLBBOL. All Rights Reserved.</p>
    </div>

    <!-- 소셜 미디어 -->
    <div class="footer-social">
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-facebook-f"></i></a>
      <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
    
  </div>
</footer>




</body>
</html>