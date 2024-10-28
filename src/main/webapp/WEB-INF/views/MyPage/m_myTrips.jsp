<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">  
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_myTrips.css"> 
<title>내 여행 일정</title>
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
<!-- 오른쪽 콘텐츠 영역 (내 여행) -->
<div class="content-section">
    <div class="trip-sections">

        <!-- 다가오는 여행 섹션 -->
        <div class="section">
            <div class="section-header">
                <h3>다가오는 여행</h3>
                <button class="add-trip-btn" onclick="location.href='${pageContext.request.contextPath}/TripSched/tripSched'">일정 추가</button>
            </div>
            <div class="section-content">
                <c:choose>
                    <c:when test="${not empty upcomingTrips}">
                        <div class="card-container">
                            <!-- 변수 초기화 -->
                            <c:set var="prevTitle" value="" />
                            <c:set var="prevPeriodStart" value="" />
                            <c:set var="prevPeriodEnd" value="" />
                            <c:set var="prevCity" value="" />

                            <!-- 여행 리스트 순회 -->
                            <c:forEach var="trip" items="${upcomingTrips}">
                                <!-- 새로운 여행 카드 생성 조건: 제목, 기간, 도시가 다를 때 -->
                                <c:if test="${trip.t_title != prevTitle || trip.period_start != prevPeriodStart || trip.period_end != prevPeriodEnd || trip.city_name != prevCity}">
                                    <!-- 이전 카드가 닫히지 않았으면 닫기 -->
                                    <c:if test="${prevTitle != ''}">
                                        </ul> <!-- 이전 리스트 닫기 -->
                                        </div> <!-- 이전 카드 닫기 -->
                                    </c:if>
                                    <!-- 새 카드 시작 -->
                                    <div class="trip-card">
                                        <h4>${trip.t_title}</h4>
                                        		  <span class="m_days-remaining">
								                  		  ${trip.daysRemaining}
								                	</span>
                                        <p><strong>여행 기간:</strong> 
                                            <fmt:formatDate value="${trip.period_start}" pattern="yyyy-MM-dd" /> - 
                                            <fmt:formatDate value="${trip.period_end}" pattern="yyyy-MM-dd" />
                                        </p>
                                        <p><strong>도시 이름:</strong> ${trip.city_name}</p>

                                        <!-- 여행 장소 리스트 시작 -->
                                        <ul class="place-list">
                                </c:if>

                                <!-- 여행 장소 추가 -->
                                <li>${trip.place_name}</li>

                                <!-- 이전 항목 업데이트 -->
                                <c:set var="prevTitle" value="${trip.t_title}" />
                                <c:set var="prevPeriodStart" value="${trip.period_start}" />
                                <c:set var="prevPeriodEnd" value="${trip.period_end}" />
                                <c:set var="prevCity" value="${trip.city_name}" />
                            </c:forEach>

                            <!-- 마지막 카드가 열려있으면 닫기 -->
                            <c:if test="${prevTitle != ''}">
                                </ul>
                                </div> <!-- 마지막 카드 닫기 -->
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p>다가오는 여행 일정이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- 지난 여행 섹션 -->
        <div class="section">
            <div class="section-header">
                <h3>지난 여행</h3>
            </div>
            <div class="section-content">
                <c:choose>
                    <c:when test="${not empty pastTrips}">
                        <div class="card-container">
                            <!-- 변수 초기화 -->
                            <c:set var="prevTitle" value="" />
                            <c:set var="prevPeriodStart" value="" />
                            <c:set var="prevPeriodEnd" value="" />
                            <c:set var="prevCity" value="" />

                            <!-- 여행 리스트 순회 -->
                            <c:forEach var="trip" items="${pastTrips}">
                                <!-- 새로운 여행 카드 생성 조건: 제목, 기간, 도시가 다를 때 -->
                                <c:if test="${trip.t_title != prevTitle || trip.period_start != prevPeriodStart || trip.period_end != prevPeriodEnd || trip.city_name != prevCity}">
                                    <!-- 이전 카드가 닫히지 않았으면 닫기 -->
                                    <c:if test="${prevTitle != ''}">
                                        </ul> <!-- 이전 리스트 닫기 -->
                                        </div> <!-- 이전 카드 닫기 -->
                                    </c:if>
                                    <!-- 새 카드 시작 -->
                                    <div class="trip-card">
                                        <h4>${trip.t_title}</h4>
                                        <p><strong>여행 기간:</strong> 
                                            <fmt:formatDate value="${trip.period_start}" pattern="yyyy-MM-dd" /> - 
                                            <fmt:formatDate value="${trip.period_end}" pattern="yyyy-MM-dd" />
                                        </p>
                                        <p><strong>도시 이름:</strong> ${trip.city_name}</p>

                                        <!-- 여행 장소 리스트 시작 -->
                                        <ul class="place-list"> <!-- 새로운 카드를 열 때 <ul>을 여는 것이 확실함 -->
                                </c:if>

                                <!-- 여행 장소 추가 -->
                                <li>${trip.place_name}</li>

                                <!-- 이전 항목 업데이트 -->
                                <c:set var="prevTitle" value="${trip.t_title}" />
                                <c:set var="prevPeriodStart" value="${trip.period_start}" />
                                <c:set var="prevPeriodEnd" value="${trip.period_end}" />
                                <c:set var="prevCity" value="${trip.city_name}" />
                            </c:forEach>

                            <!-- 마지막 카드가 열려있으면 닫기 -->
                            <c:if test="${prevTitle != ''}">
                                </ul> <!-- 마지막 리스트 닫기 -->
                                </div> <!-- 마지막 카드 닫기 -->
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p>지난 여행 기록이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

    <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />
 
</body>
</html>