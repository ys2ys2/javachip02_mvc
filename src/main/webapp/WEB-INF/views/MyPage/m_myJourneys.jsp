<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_myJourneys.css"> 
<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">  
<title>내 게시글</title>
</head>
<body>
 <!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />
  <!-- 상단 네비게이션 -->
  <div class="navigation">
   	<a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지 홈</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myTrips">내 여행</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myJourneys">내 게시글</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_savedList">저장목록</a>
</div>


     <!-- 왼쪽 프로필 영역 -->
    <div class="profile-section">
    <h4>My BBOL BBOL BBOL</h4>
        <div class="profile-card">
               <img src="${pageContext.request.contextPath}${member.m_profile}" alt="프로필 사진" class="profile-image">
        
        <h3 class="nickname-header">${member.m_nickname}</h3>
        
       <div class="profile-edit-container">  
<a href="${pageContext.request.contextPath}/Member/m_updateProfile"class="profile-edit-link" >
    <i class="fas fa-pencil-alt"></i> 프로필 편집
</a>
</div>
</div>
</div>
  <!-- 게시글 리스트를 포함 -->
<div class="content-section">
    <h3>내 게시글</h3>

    <div class="saved-post-list">
        <!-- savedPostList가 비어 있지 않은 경우 게시글을 표시 -->
        <c:if test="${not empty savedPostList}">
            <c:forEach var="post" items="${savedPostList}">
                <div class="post-item">
                    <!-- 게시글 상단: 작성자와 작성 날짜 -->
                    <div class="post-header">
                        <div class="post-writer">${post.postWriter}</div>
                        <div class="post-date">${post.formattedPostDate}</div>
                    </div>

                    <!-- 게시글 내용 -->
                    <div class="post-content">
                        ${post.postContent}
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <!-- savedPostList가 비어 있는 경우 표시 -->
        <c:if test="${empty savedPostList}">
            <p>저장된 게시글이 없습니다.</p>
        </c:if>
    </div>
</div>

      <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />

</body>
</html>