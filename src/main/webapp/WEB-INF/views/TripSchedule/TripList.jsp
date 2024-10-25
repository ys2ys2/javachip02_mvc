<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/TripList.css">
	<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
  	<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet">
    
    <!-- Google Material Icons 추가 -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
    <title>여행 일정 리스트</title>
</head>
<body>

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
         <li><a href="#">여행일정</a></li>
         
       </ul>
     </nav>
     <div class="member">
       <c:choose>
         <c:when test="${not empty sessionScope.member}">
           <!-- 로그인 성공 시, 마이페이지와 로그아웃 표시 -->
           <div class="welcome">
           	<span class="userprofile"><img src="${sessionScope.member.m_profile}" alt="user-profile"></span>
           	${sessionScope.member.m_nickname}님 환영합니다!
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

    <div class="trip-list-container">
        <!-- 검색창과 돋보기 아이콘 -->
        <div class="search-container">
            <input type="text" id="search" placeholder="검색어를 입력하세요">
            <button class="search-button">
                <!-- Google Material Icons에서 제공하는 돋보기 아이콘 사용 -->
                <span class="material-icons">search</span>
            </button>
        </div>
        
        <!-- 필터 부분 -->
        <div class="filter-container">
            <select>
                <option>여행기간</option>
            </select>
            <select>
                <option>1일 이상 전체</option>
            </select>
            <select>
                <option>최신순</option>
            </select>
        </div>
        
        <!-- 여행 일정 리스트 -->
        <c:forEach var="trip" items="${tripList}">
            <div class="trip-item">
                <div class="trip-info">
                    <!-- 여행 상세 페이지로 이동할 수 있는 링크 추가 -->
                    <a href="${pageContext.request.contextPath}/TripSchedule/TripPage?post_id=${trip.post_id}">
                        <p class="plan-text">PLAN · ${trip.period_start} ~ ${trip.period_end}</p>
                        <h2>${trip.title}</h2>
                    </a>
                    <!-- scheduleList에서 첫 번째 city_name 출력 -->
                    <c:forEach var="schedule" items="${trip.scheduleList}" varStatus="status">
                        <!-- 첫 번째 장소(city_name)만 출력 -->
                        <c:if test="${status.index == 0}">
                            <p class="location"><span class="location-icon">📍</span>${schedule.city_name}</p>
                        </c:if>
                    </c:forEach>
                    <p class="nickname">by ${trip.m_nickname}</p>
                </div>
                <div class="map-thumbnail">
                    <!-- 썸네일 이미지에 링크 추가 -->
                    <a href="${pageContext.request.contextPath}/TripSchedule/TripPage?post_id=${trip.post_id}">
                        <!-- 썸네일이 없는 경우 대체 이미지 사용 -->
                        <c:choose>
                            <c:when test="${trip.thumbnailUrl != null}">
                                <img src="${trip.thumbnailUrl}" alt="Map Thumbnail">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/resources/images/default-thumbnail.png" alt="Default Thumbnail">
                            </c:otherwise>
                        </c:choose>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
    
<!-- 푸터 부분 -->
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h4>회사소개</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/introduce" target="_blank">회사소개</a></li>
        <li><a href="${pageContext.request.contextPath}/HotPlace/inputApi"target="_blank">공공데이터 API</a></li>
      </ul>
    </div>

    <!-- 고객지원 -->
    <div class="footer-section">
      <h4>고객지원</h4>
      <ul>
        <li><a href="#">공지사항</a></li>
        <li><a href="#">자주묻는 질문</a></li>
        <li><a href="#">문의하기</a></li>
      </ul>
    </div>

    <!-- 이용약관 -->
    <div class="footer-section">
      <h4>이용약관</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/clause" target="_blank">이용약관</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank">개인정보처리방침</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/marketing" target="_blank">광고성 정보 수신동의</a></li>
      </ul>
    </div>

    <!-- 회사 정보 -->
    <div class="footer-company-info">
      <p>상호: (주)BBOL | 대표: 박예슬 | 사업자등록번호: 123-45-67890 | 통신판매업 신고번호: 2024-충남천안-00000 | 개인정보관리 책임자: 수수옥</p>
      <p>주소: 충청남도 천안시 동남구 123 | 이메일: support@BBOL3.com | 대표전화: 02-1234-5678</p>
      <p>© 2024 BBOLBBOLBBOL. All Rights Reserved.</p>
    </div>

    <!-- 소셜 미디어 -->
    <div class="footer-social">
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-facebook-f"></i></a>
      <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
    
  </div>
</footer>
</body>
</html>
