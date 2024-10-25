<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행기 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/travelpostlist.css">
    <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
    <script>
        var contextPath = '${pageContext.request.contextPath}';
    </script>
</head>
<body>
<div class="overlay"></div>

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

<!-- 전체 레이아웃을 컨트롤하는 컨테이너 -->
<div class="container">
    <!-- 태그/토픽 섹션 -->
    <div class="tag-section">
        <h4>#태그/토픽 선택</h4>
        <div class="tags">
            <button class="filter-button" data-filter="전체">#전체</button>
            <button class="filter-button" data-filter="서울">#서울</button>
            <button class="filter-button" data-filter="부산">#부산</button>
            <button class="filter-button" data-filter="제주">#제주</button>
            <button class="filter-button" data-filter="인천">#인천</button>
            <button class="filter-button" data-filter="도시여행">#도시여행</button>
            <button class="filter-button" data-filter="자연여행">#자연여행</button>
            <button class="filter-button" data-filter="해외여행">#해외여행</button>
        </div>
    </div>

    <!-- 여행기 목록 및 페이지네이션을 묶음 -->
    <div class="post-list-container">
    	 <!-- 검색 입력 필드를 우측 상단으로 이동 -->
        <div class="search-section">
            <input type="text" id="search-query" placeholder="검색어를 입력하세요" />
            <button id="search-button">검색</button>
        </div>
        <div class="post-list">
            <!-- 필터링된 여행기들이 여기에 AJAX로 동적으로 추가됩니다 -->
        </div>
        
        <!-- 페이지네이션을 게시글 목록 바로 밑에 배치 -->
        <div class="pagination">
            <!-- 페이지네이션 버튼이 여기에 동적으로 추가됩니다 -->
        </div>
    </div>
</div>
    
<script src="${pageContext.request.contextPath}/resources/js/travelpostlist.js"></script>
</body>
</html>
