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
	<!-- header -->
	<jsp:include page="/WEB-INF/views/Components/header.jsp" />
  
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
	<jsp:include page="/WEB-INF/views/Components/footer.jsp" />
</footer>




</body>
</html>