<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행 일정 리스트</title>
    
    <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/TripList.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
    <style>
        /* "작성하기" 버튼 스타일 */
        .create-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            margin-left: 8px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }
        .create-button:hover {
            background-color: #45a049;
        }
        .search-container {
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
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
                <span class="userprofile"><img src="${pageContext.request.contextPath}${member.m_profile}" alt="user-profile"></span>
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

<div class="trip-list-container">
    <!-- 검색창과 버튼들 -->
    <div class="search-container">
        <input type="text" id="search" placeholder="검색어를 입력하세요" oninput="filterTrips()">
        <button class="search-button" onclick="filterTrips()">
            <span class="material-icons">search</span>
        </button>
        <!-- 깔끔하게 디자인된 "작성하기" 버튼 -->
        <a href="http://localhost:9090/BBOL/TripSchedule/TripSchedule" class="create-button">작성하기</a>
    </div>
    
    <!-- 필터 부분 -->
    <div class="filter-container">
        <select id="travel-period" onchange="filterTrips()">
            <option value="all">여행기간</option>
            <option value="1">1월</option>
            <option value="2">2월</option>
            <option value="3">3월</option>
            <option value="4">4월</option>
            <option value="5">5월</option>
            <option value="6">6월</option>
            <option value="7">7월</option>
            <option value="8">8월</option>
            <option value="9">9월</option>
            <option value="10">10월</option>
            <option value="11">11월</option>
            <option value="12">12월</option>
        </select>
        <select id="duration" onchange="filterTrips()">
            <option value="all">1일 이상 전체</option>
            <option value="5">5일 이하</option>
            <option value="6">6일 이상</option>
        </select>
        <select id="sort" onchange="filterTrips()">
            <option value="latest">최신순</option>
            <option value="popular">인기순</option>
        </select>
    </div>
    
    <!-- 여행 일정 리스트 -->
    <div id="tripList">
        <c:forEach var="trip" items="${tripList}" varStatus="status">
            <c:if test="${status.first || tripList[status.index - 1].post_id != trip.post_id}">
                <div class="trip-item" data-post-id="${trip.post_id}" data-period-start="${trip.period_start}" data-period-end="${trip.period_end}" data-title="${trip.title.toLowerCase()}" data-duration="${fn:length(trip.dayNumbers)}">
                    <div class="trip-info">
                        <a href="${pageContext.request.contextPath}/TripSchedule/TripPage?post_id=${trip.post_id}">
                            <p class="plan-text">PLAN · ${trip.period_start} ~ ${trip.period_end}</p>
                            <h2>${trip.title}</h2>
                        </a>
                        <p class="location"><span class="location-icon">📍</span>${trip.city_name}</p>
                        <p class="nickname">by ${trip.m_nickname}</p>
                    </div>
                    <div class="map-thumbnail">
                        <c:choose>
                            <c:when test="${trip.thumbnail != null}">
                                <a href="${pageContext.request.contextPath}/TripSchedule/TripPage?post_id=${trip.post_id}">
                                    <img src="${trip.thumbnail}" alt="Map Thumbnail" />
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/TripSchedule/TripPage?post_id=${trip.post_id}">
                                    <img src="${pageContext.request.contextPath}/resources/images/default-thumbnail.png" alt="Default Thumbnail" />
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

<script>
    function filterTrips() {
        const searchKeyword = document.getElementById("search").value.toLowerCase();
        const travelPeriod = document.getElementById("travel-period").value;
        const duration = document.getElementById("duration").value;
        const sortOption = document.getElementById("sort").value;

        const tripItems = document.querySelectorAll(".trip-item");

        tripItems.forEach(item => {
            const title = item.getAttribute("data-title");
            const periodStart = new Date(item.getAttribute("data-period-start"));
            const periodEnd = new Date(item.getAttribute("data-period-end"));
            const tripDuration = parseInt(item.getAttribute("data-duration"));

            let matchesSearch = title.includes(searchKeyword);
            let matchesPeriod = travelPeriod === "all" || (periodStart.getMonth() + 1 === parseInt(travelPeriod));
            let matchesDuration = duration === "all" ||
                (duration === "5" && tripDuration <= 5) ||
                (duration === "6" && tripDuration > 5);

            item.style.display = (matchesSearch && matchesPeriod && matchesDuration) ? "flex" : "none";
        });

        sortTrips(sortOption);
    }

    function sortTrips(sortOption) {
        const tripList = document.getElementById("tripList");
        const tripItems = Array.from(document.querySelectorAll(".trip-item"));

        if (sortOption === "latest") {
            tripItems.sort((a, b) => new Date(b.getAttribute("data-period-start")) - new Date(a.getAttribute("data-period-start")));
        } else if (sortOption === "popular") {
            // 인기순 정렬 로직이 필요한 경우 추가 가능
        }

        tripItems.forEach(item => tripList.appendChild(item));
    }
</script>

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
        <li><a href="${pageContext.request.contextPath}/MyPage/FAQ" target="_blank">자주묻는 질문</a></li>
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
