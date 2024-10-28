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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_savedList.css"> 
<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">  
<title>내 저장 목록</title>
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


 <!-- 오른쪽 콘텐츠 영역 (저장 목록) -->
<div class="s_content-section">
    <!-- 섹션 헤더와 저장 목록을 포함하는 전체 컨테이너 -->
    <div class="s_content-section-header">
        <h2>저장 목록</h2>
    </div>
    
    <!-- 저장 목록이 비어 있지 않은 경우 -->
    <c:if test="${not empty savedList}">
        <div class="s_saved-list">
            <!-- 저장 항목을 순회하며 출력 -->
            <c:forEach var="item" items="${savedList}">
                <div class="s_saved-item">
                    <img src="${item.firstimage}" alt="${item.title}" class="s_saved-image">
                    <div class="s_saved-info">
                        <h4>${item.title}</h4>
                        <p>${item.addr1}</p>
                    </div>
                </div>
                <hr>
            </c:forEach>
        </div>
    </c:if>
</div>
     <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />

</body>

</html>