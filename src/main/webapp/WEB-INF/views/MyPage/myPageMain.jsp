<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <fmt:setTimeZone value="UTC" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPageMain.css"> 
<title>마이페이지 메인</title>
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

  <!-- 오른쪽 콘텐츠 영역 -->
<div class="content-section-custom">

    <!-- 여행 섹션: 다가오는 여행과 지난 여행 -->
    <div class="travel-section">
        <!-- 다가오는 여행 -->
        <div class="section-upcoming-trips">
            <h3 class="upcoming-trips-title">다가오는 여행</h3>
            <button class="add-trip-btn" onclick="location.href='${pageContext.request.contextPath}/TripSched/tripSched'">일정 추가</button>
            <c:if test="${not empty latestUpcomingTrip}">
                <div class="upcoming-trip-item">
                    <p class="upcoming-trip-item-title">${latestUpcomingTrip.t_title}</p>
                    <p class="upcoming-trip-item-date"> 
                        <fmt:formatDate value="${latestUpcomingTrip.period_start}" pattern="yyyy-MM-dd" /> - 
                        <fmt:formatDate value="${latestUpcomingTrip.period_end}" pattern="yyyy-MM-dd" />
                   		    <span class="days-remaining">
						        ${latestUpcomingTrip.daysRemaining}
						    </span>
                   			</p>
                </div>
            </c:if>
            <c:if test="${empty latestUpcomingTrip}">
                <p class="no-upcoming-trip-message">다가오는 여행이 없습니다.</p>
            </c:if>
        </div>
        <!-- 지난 여행 -->
        <div class="section-past-trips">
            <h3 class="past-trips-title">지난 여행</h3>
            <button class="add-trip-btn" onclick="location.href='${pageContext.request.contextPath}/MyPage/m_myTrips'">더보기</button>
            <c:if test="${not empty latestPastTrip}">
                <div class="latest-past-trip">
                    <p class="latest-past-trip-title">${latestPastTrip.t_title}</p>
                    <p class="latest-past-trip-date"> 
                        <fmt:formatDate value="${latestPastTrip.period_start}" pattern="yyyy-MM-dd" /> - 
                        <fmt:formatDate value="${latestPastTrip.period_end}" pattern="yyyy-MM-dd" />
                    </p>
                </div>
            </c:if>
            <c:if test="${empty latestPastTrip}">
                <p class="no-past-trip-message">지난 여행 기록이 없습니다.</p>
            </c:if>
        </div>
    </div>

   <!-- 내 게시물과 나의 저장목록을 감싸는 컨테이너 -->
<div class="post-and-saved-container">
    <!-- 내 게시물 섹션 -->
    <div class="my-journeys-custom">
        <h3 class="my-journeys-title">내 게시글</h3>
        <button class="my-journeys-btn" onclick="location.href='${pageContext.request.contextPath}/Community/c_main'">글쓰기</button>
        <div class="my-journeys-list">
            <c:if test="${not empty savedPostList}">
                <c:forEach var="post" items="${savedPostList}">
                    <div class="post-item-custom">
                        <div class="post-header-custom">
                            <div class="post-writer-custom">${post.postWriter}</div>
                            <div class="post-date-custom">${post.formattedPostDate}</div>
                        </div>
                        <div class="post-content-custom">${post.postContent}</div>
                        <div class="post-footer-custom">
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>

    <!-- 나의 저장목록 섹션 -->
    <div class="m_content-section-header-custom">
     			<h3>나의 저장목록</h3>
        <c:if test="${not empty savedList}">
            <div class="m_saved-list-custom">
                <c:forEach var="item" items="${savedList}">
                    <div class="m_saved-item-custom">
                        <img src="${item.firstimage}" alt="${item.title}" class="m_saved-image-custom">
                        <div class="m_saved-info-custom">
                            <h4 class="saved-title-custom">${item.title}</h4>
                            <p class="saved-addr-custom">${item.addr1}</p>
                        </div>
                    </div>
                    <hr>
                </c:forEach>
            </div>
        </c:if>
    </div>
</div>

    <!-- 추천 핫플레이스 섹션 -->
    <div class="m_hotplaces-custom">
        <h2 class="hotplaces-title-custom">
    <span class="highlight-font">BBOL BBOL BBOL</span> 추천 핫플레이스
		</h2>

        <div class="m_content-box-custom">
            <c:forEach var="hotplace" items="${hotplaceList}">
                <div class="m_hotplace-item-custom">
                    <img src="${hotplace.firstimage}" alt="${hotplace.title}" class="hotplace-image-custom">
                    <h3 class="hotplace-title-custom">${hotplace.title}</h3>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- 오른쪽 하단에 고정된 이미지 버튼 -->
<div class="floating-button">
    <a href="${pageContext.request.contextPath}/HomePage/FAQ">
        <img src="${pageContext.request.contextPath}/resources/images/chatbot.png" alt="챗봇 이미지">
    </a>
</div>

  <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />

</body>
</html>