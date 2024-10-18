<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_commentManagement.css"> 
<title>마이페이지 메인</title>
</head>
<body>
 <div class="overlay"></div> 

  <header>
    <div class="header-container">
      <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
      <nav>
        <ul>
          <li><a href="#" data-ko="홈" data-en="Home">홈홈</a></li>
          <li><a href="#" data-ko="커뮤니티" data-en="Community">커뮤니티</a></li>
          <li><a href="#" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
          <li><a href="#" data-ko="여행뽈뽈" data-en="BBOL BBOL BBOL">여행뽈뽈</a></li>
          <button class="search-btn">
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
          <button class="user-btn">
            <i class="fa-solid fa-user"></i>
          </button>
          <button class="earth-btn">
            <i class="fa-solid fa-earth-americas"></i>
          </button>
          <button class="korean" id="lang-btn" data-lang="ko">English</button>
        </ul>
      </nav>
    </div>
   
  </header>
  <!-- 상단 네비게이션 -->
  <div class="navigation">
   	<a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지 홈</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myTrips">내 여행</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myJourneys">내 여행기</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_savedList">저장목록</a>
   	
</div>

<div class="container">
    <!-- 왼쪽 프로필 영역 -->
    <div class="profile-section">
    <h4>My BBOL BBOL BBOL</h4>
        <div class="profile-card">
            <img src="${pageContext.request.contextPath}/resources/images/profile.jpg" alt="프로필 사진" class="profile-image">
            <h3>박옥수수</h3>
            <p>팔로워: 0 | 팔로잉: 0</p>
            <button onclick="location.href='editProfile.jsp'">프로필 편집</button>
        </div>
    </div>
    
  <!-- 오른쪽 댓글 관리 섹션 -->
    <div class="comment-section">
        <!-- 댓글 관리 헤더 -->
        <div class="comment-header">
            <h2>댓글 관리</h2>
        </div>

        <!-- 댓글 항목 -->
        <div class="comment-item">
            <h4>강남이 님</h4>
            <p class="comment-meta">2024-09-18 19:22</p>
            <p class="comment-body">[단골]감사합니다. 알프스 다녀왔어요.</p>
            <div class="comment-actions">
                <button class="btn">답글</button>
                <button class="btn">삭제</button>
            </div>
        </div>

        <!-- 두 번째 댓글 -->
        <div class="comment-item">
            <h4>예술이 님</h4>
            <p class="comment-meta">2024-09-13 11:42</p>
            <p class="comment-body">예술스러운 하루 보내세요 😎</p>
            <div class="comment-actions">
                <button class="btn">답글</button>
                <button class="btn">삭제</button>
            </div>
        </div>

        <!-- 세 번째 댓글 -->
        <div class="comment-item">
            <h4>박옥수수 님</h4>
            <p class="comment-meta">2024-09-13 11:42</p>
            <p class="comment-body">유쾌한 하루 보내세요 😊</p>
            <div class="comment-actions">
                <button class="btn">답글</button>
                <button class="btn">삭제</button>
            </div>
        </div>

    </div>

</div>
</body>
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>

</html>

