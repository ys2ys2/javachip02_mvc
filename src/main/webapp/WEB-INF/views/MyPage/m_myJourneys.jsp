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
</div>

  <h1>저장된 게시글 목록</h1>

    <!-- savedList가 비어있지 않은 경우 리스트를 출력 -->
    <c:if test="${not empty savedPostList}">
        <table border="1">
            <thead>
                <tr>
                    <th>작성자</th>
                    <th>게시글 내용</th>
                    <th>작성 날짜</th>
                    <th>좋아요 수</th>
                    <th>댓글 수</th>
                </tr>
            </thead>
            <tbody>
                <!-- savedList의 각 항목을 반복하여 출력 -->
                <c:forEach var="post" items="${savedPostList}">
                    <tr>
                        <td>${post.postWriter}</td>      <!-- 게시글 작성자 출력 -->
                        <td>${post.postContent}</td>     <!-- 게시글 내용 출력 -->
                        <td>${post.postDate}</td>        <!-- 게시글 작성 날짜 출력 -->
                        <td>${post.likeCount}</td>       <!-- 좋아요 수 출력 -->
                        <%-- <td>${post.commentCount}</td>    <!-- 댓글 수 출력 --> --%>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- savedList가 비어있는 경우 표시 -->
    <c:if test="${empty savedPostList}">
        <p>저장된 게시글이 없습니다.</p>
    </c:if>
</body>
</html>