<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>

	<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
  	<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
  	<link href="${pageContext.request.contextPath}/resources/css/clause.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<title>개인정보 제3자 제공 동의</title>
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
          <li><a href="${pageContext.request.contextPath}/Community/c_main">커뮤니티</a></li>
          <li><a href="${pageContext.request.contextPath}/HotPlace/hotplace2">여행지</a></li>
          <li><a href="${pageCOntext.request.contextPath}/TravelSpot/TravelSpot">여행뽈뽈</a></li>
          <li><a href="${pageContext.request.contextPath}/TripSched/tripSched">여행일정</a></li>
        </ul>
      </nav>
      <div class="member">
        <c:choose>
          <c:when test="${not empty member}">
            <!-- 로그인 성공 시, 마이페이지와 로그아웃 표시 -->
            <div class="welcome">
            	<span class="userprofile"><img src="${member.m_profile}" alt="user-profile"></span>
            	${member.m_nickname}님 환영합니다!
            </div>
            <span><a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지</a></span>
            <form action="${pageContext.request.contextPath}/Member/logout" method="post" style="display:inline;">
              <button type="submit">로그아웃</button>
            </form>
          </c:when>
          <c:otherwise>
            <!-- 로그인 실패 시, 로그인과 회원가입 표시 -->
            <span><a href="${pageContext.request.contextPath}/Member/login">로그인</a></span>
            <span><a href="${pageContext.request.contextPath}/Member/joinmain">회원가입</a></span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>
  
  
  <div class="clause">
  
  	<div class="introimg"
		style="background-image:url('${pageContext.request.contextPath}/resources/images/clausemain.jpg');">
		<h2>뽈뽈뽈 약관</h2>
		<h1>개인정보 제3자 제공 동의</h1>
	</div>
	
	<!-- 네비바 부분 -->
    <div class="c_section-container">
      <ul class="c_navbar">
        <li class="c_nav-item"><a href="${pageContext.request.contextPath}/FooterPage/clause" target="_blank">이용약관</a></li>
        <li class="c_nav-item"><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank" >개인정보 수집 및 이용 동의</a></li>
        <li class="c_nav-item"><a href="${pageContext.request.contextPath}/FooterPage/thirdparty">개인정보 제3자 제공 동의</a></li>
        <li class="c_nav-item"><a href="${pageContext.request.contextPath}/FooterPage/marketing" target="_blank">광고성 정보 수신동의</a></li>
      </ul>
  	</div>
  
  <div class="third-party_text">
  1. 회사는 이용자의 개인정보를 본 처리방침 제2조에서 고지한 범위 내에서 사용하며, 이용자의 사전 동의 없이는 동 범위를 초과하여 이용하거나, 원칙적으로 이용자의 개인정보를 외부에 제공하지 않습니다. 단, 개인정보 보호법 제17조 및 제18조 등 법률의 특별한 규정에 해당하는 경우에만 개인정보를 제3자에게 제공합니다. 
  <br><br>
  2. 이용자는 개인정보의 제3자 제공에 대하여 동의하지 않을 수 있고, 언제든지 제3자 제공 동의를 철회할 수 있습니다. 동의를 거부하는 경우에도 일부 서비스는 이용할 수 있으나, 제3자 제공에 기반한 관련 서비스의 이용/제공이 제한될 수 있습니다.
  <br><br>
  
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