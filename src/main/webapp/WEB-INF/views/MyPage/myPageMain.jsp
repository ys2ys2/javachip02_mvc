<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/header.css"> <!-- mainpage.css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" type="text/css" href="myPageMain.css">
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
    <!-- 검색 바 -->
    <div class="search-bar-container">
      <div class="search-bar-content">
        <input type="text" placeholder="도시나 키워드를 검색해보세요..." data-ko="도시나 키워드를 검색해보세요..."
          data-en="Search cities or keywords...">
        <button class="close-btn"><i class="fa-solid fa-times"></i></button>
      </div>
    </div>
  </header>
  <!-- 상단 네비게이션 -->
  <div class="navigation">
    <a href="#my-trips">내 여행</a>
    <a href="#my-journeys">내 여행기</a>
    <a href="#my-saved-list">저장 목록</a>
    <a href="#comment-management">댓글관리</a>
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

        <!-- 추천 핫플레이스 -->
        <div class="hotplaces">
            <h2>BBOL BBOL BBOL 추천 핫플레이스</h2>
            <div class="content-box"></div>
        </div>

    </div>

</div>

</body>
<script src="../components/header.js"></script>
<script src="../components/lang-toggle.js"></script>
<script src="../user.js"></script>
</html>