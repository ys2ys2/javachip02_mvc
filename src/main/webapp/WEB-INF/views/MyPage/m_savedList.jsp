<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_savedList.css"> 
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
   	<a href="${pageContext.request.contextPath}/MyPage/m_myTrips">내 여행</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myJourneys">내 여행기</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_savedList">저장목록</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_commentManagement">댓글관리</a>
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

   <!-- 오른쪽 콘텐츠 영역 (저장 목록) -->
    <div class="s_content-section">
    
 	  <!-- 섹션 헤더 추가 -->
        <div class="s_content-section-header">
            <h2>저장 목록</h2>
        </div>
        
        <div class="s_saved-list">
            <!-- 예시 데이터 -->
            <div class="s_saved-item">
                <img src="${pageContext.request.contextPath}/resources/images/saved_image1.jpg" alt="저장된 장소" class="s_saved-image">
                
                <div class="s_saved-info">
                    <h4>중화일상</h4>
                    <p>"평양의 맛있는 숨겨진 맛집"</p>
                    <div class="s_saved-meta">
                        <span>❤ 59</span>
                        <span>서울시 중구</span>
                    </div>
                </div>

                <div class="s_icons">
                    <button class="s_share-btn">🔗</button>
                </div>
            </div>
            <hr> <!-- 구분선 -->
            
            <!-- 추가 저장된 항목들 -->
            <div class="s_saved-item">
                <img src="${pageContext.request.contextPath}/resources/images/saved_image2.jpg" alt="저장된 장소" class="s_saved-image">
                
                <div class="s_saved-info">
                    <h4>예술일상</h4>
                    <p>"평양의 숨겨진 골목길 예술 공간"</p>
                    <div class="s_saved-meta">
                        <span>❤ 600</span>
                        <span>경기도 용인시</span>
                    </div>
                </div>

                <div class="s_icons">
                    <button class="s_share-btn">🔗</button>
                </div>
            </div>
            <hr> <!-- 구분선 -->
        </div>
    </div>
</div>
</body>
   <script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>

</html>