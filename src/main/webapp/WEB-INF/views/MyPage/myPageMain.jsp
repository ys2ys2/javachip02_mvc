<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPageMain.css"> 
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
               <img src="${member.m_profile}" alt="프로필 사진" class="profile-image">
        
        <h3>${member.m_nickname}</h3>
            <p>팔로워: 0 | 팔로잉: 0</p>
            <!-- 프로필 편집 버튼 (JavaScript로 페이지 이동) -->
<a href="${pageContext.request.contextPath}/Member/m_updateProfile">
    <button>프로필 편집</button>
</a>
        </div>
    </div>

    <!-- 오른쪽 콘텐츠 영역 -->
    <div class="content-section">

        <!-- 다가오는 여행과 내 여행기 (두 개가 나란히 위치) -->
        <div class="top-content">
            <!-- 다가오는 여행 -->
            <div id="my-trips" class="upcoming-trips">
                <h2>다가오는 여행</h2>
               <button class="black-button">일정 추가</button>
                <div class="content-box"></div>
            </div>

            <!-- 내 여행기 -->
            <div id="my-journeys" class="my-journeys">
                <h2>내 여행기</h2>
                <button class="black-button">글쓰기</button>
                <div class="content-box"></div>
            </div>
        </div>

        <!-- 지난 여행과 나의 저장목록 (두 개가 나란히 위치) -->
        <div class="middle-content">
            <!-- 지난 여행 -->
            <div id="my-past-trips" class="past-trips">
                <h2>지난 여행</h2>
                <div class="content-box"></div>
            </div>

            <!-- 나의 저장목록 -->
            <div id="my-saved-list" class="my-saved-list">
                <h2>나의 저장목록</h2>
                <div class="content-box"></div>
            </div>
        </div>

      	<!-- 추천 핫플레이스 섹션 -->
			<div class="m_hotplaces">
		    <h2>BBOL BBOL BBOL 추천 핫플레이스</h2>
		
		    <!-- 콘텐츠를 보여줄 content-box -->
		    <div class="m_content-box">
		        <!-- c:forEach를 사용하여 m_mypageList를 반복 처리 -->
		        <c:forEach var="mypage" items="${m_mypageList}">
		            <div class="m_hotplace-item">
		                <!-- 이미지 출력 (firstimage) -->
		                <img src="${mypage.firstimage}" alt="${mypage.title}">
		
		                <!-- 제목 출력 (title) -->
		                <h3>${mypage.title}</h3>
		            </div>
		        </c:forEach>
		        
		    </div>
		</div>
</div>
</div>
</body>

   <script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
</html>