<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_myJourneys.css"> 
<title>마이페이지 메인</title>
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
            <div class="welcome">${sessionScope.member.m_nickname}님 환영합니다!</div>
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

   <!-- 오른쪽 콘텐츠 영역 (나의 여행기) -->
    <div class="content-section">

        <!-- 나의 여행기 섹션 -->
        <div class="j_section">
            <div class="j_section-header">
                <h3>나의 여행기</h3>
            </div>
            <div class="j_section-content">
                <!-- 리스트 형식의 여행기 콘텐츠가 나열될 영역 -->
                <div class="journey-list">
                    <!-- 데이터가 없으므로 기본 텍스트로 설정 -->
                    <div class="journey-item">
                        <img src="${pageContext.request.contextPath}/resources/images/journey_image1.jpg" alt="여행 이미지">
                        <div class="journey-info">
                            <h4>여행 제목</h4>
                            <p>여행 설명 텍스트가 여기에 표시됩니다.</p>
                            <span>TRAVEL: 2024.09.03 ~ 2024.09.13</span>
                        </div>
                    </div>
                    <!-- 더 많은 여행 항목을 여기에 추가 가능 -->
                </div>
            </div>
        </div>
    </div>
</div>
</body>
   <script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
</html>