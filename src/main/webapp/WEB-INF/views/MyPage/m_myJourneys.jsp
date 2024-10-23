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
<title>게시글</title>
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
     <a href="${pageContext.request.contextPath}/MyPage/m_myJourneys">내 게시글</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_savedList">저장목록</a>
   	
</div>

<div class="container">
    <!-- 왼쪽 프로필 영역 -->
       <div class="profile-section">
    <h4>My BBOL BBOL BBOL</h4>
        <div class="profile-card">
               <img src="${pageContext.request.contextPath}${member.m_profile}" alt="프로필 사진" class="profile-image">
        
        <h3>${member.m_nickname}</h3>
         
<a href="${pageContext.request.contextPath}/Member/m_updateProfile">
    <button>프로필 편집</button>
</a>

    <!-- 게시글 리스트를 포함 -->
    <div class="content-section">
        <h3>내 게시글</h3>

        <div class="saved-post-list">
            <c:if test="${not empty savedPostList}">
                <c:forEach var="post" items="${savedPostList}">
                    <div class="post-item">
                        <!-- 게시글 상단: 작성자와 작성 날짜 -->
                        <div class="post-header">
                            <div class="post-writer">${post.postWriter}</div>
                            <div class="post-date">${post.postDate}</div>
                        </div>
                        
                        <!-- 게시글 내용 -->
                        <div class="post-content">
                            ${post.postContent}
                        </div>
                        
                        <!-- 게시글 하단: 좋아요 수와 댓글 수 -->
                        <div class="post-footer">
                            <span><i class="fa fa-heart"></i> ${post.likeCount}</span>
                            <span><i class="fa fa-comment"></i> ${post.commentCount}</span>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>

        <!-- savedList가 비어있는 경우 표시 -->
        <c:if test="${empty savedPostList}">
            <p>저장된 게시글이 없습니다.</p>
        </c:if>
    </div>
</div>

    <!-- savedList가 비어있는 경우 표시 -->
    <c:if test="${empty savedPostList}">
        <p>저장된 게시글이 없습니다.</p>
    </c:if>
</body>
</html>