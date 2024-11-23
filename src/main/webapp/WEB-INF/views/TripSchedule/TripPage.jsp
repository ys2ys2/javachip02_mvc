<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행 일정 상세</title>

    <!-- CSS 파일 -->
    <link href="${pageContext.request.contextPath}/resources/css/TripPage.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
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

<!-- Google Maps API -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAiIs-_C5RuOG0OQB9PNf2bTZPXgb4MMeo&libraries=places" async defer></script>

<script>
let map;
let markers = [];
let paths = [];

// JSON 데이터 가져오기 및 파싱
let tripSchedulesJson = '${tripSchedulesJson}';
let tripSchedules = [];

try {
    tripSchedules = tripSchedulesJson ? JSON.parse(tripSchedulesJson) : [];
    console.log("Loaded tripSchedules:", tripSchedules);
} catch (error) {
    console.error("Error parsing tripSchedulesJson:", error);
}

// 초기화 함수
function initMap() {
    if (!tripSchedules || tripSchedules.length === 0) {
        console.warn("No trip schedules available to display.");
        return;
    }

    const centerCoordinates = {
        lat: parseFloat(tripSchedules[0].place_latitude) || 37.5665,
        lng: parseFloat(tripSchedules[0].place_longitude) || 126.9780
    };

    const mapOptions = {
        center: centerCoordinates,
        zoom: 10
    };
    map = new google.maps.Map(document.getElementById('map'), mapOptions);

    if (map) {
        console.log("Map initialized successfully.");
        addMarkersForDay(1); // 첫 번째 DAY 마커 표시
    } else {
        console.error("Map failed to initialize.");
    }
}

function addMarkersForDay(dayNumber) {
    clearMarkersAndPaths();

    // day_number가 일치하는 스케줄 필터링 후 label_number 기준으로 정렬
    const daySchedules = tripSchedules
        .filter(schedule => schedule.day_number === dayNumber)
        .sort((a, b) => a.label_number - b.label_number);

    console.log(`Filtered and sorted daySchedules for day ${dayNumber}:`, daySchedules);
    const dayCoordinates = [];

    daySchedules.forEach((schedule, index) => {
        console.log(`Schedule ${index + 1}: Place Name - ${schedule.place_name}, Latitude - ${schedule.place_latitude}, Longitude - ${schedule.place_longitude}, Label Number - ${schedule.label_number}`);

        const latitude = parseFloat(schedule.place_latitude);
        const longitude = parseFloat(schedule.place_longitude);

        if (!isNaN(latitude) && !isNaN(longitude)) {
            const marker = new google.maps.Marker({
                position: { lat: latitude, lng: longitude },
                map: map,
                //label: `${index + 1}`  // 각 마커에 순서대로 번호 라벨 추가 -> 이게 잘못된 부분
                label: schedule.label_number.toString()  // 테이블에서 가져온 label_number 이거 쓰면 돼

            });
            markers.push(marker);
            dayCoordinates.push({ lat: latitude, lng: longitude });
            console.log(`Marker ${index + 1} added at (${latitude}, ${longitude}) with label ${index + 1}`);
        } else {
            console.error(`Invalid coordinates for marker ${index + 1}. Place Name: ${schedule.place_name}, Latitude: ${schedule.place_latitude}, Longitude: ${schedule.place_longitude}`);
        }
    });

    if (dayCoordinates.length > 1) {
        const pathLine = new google.maps.Polyline({
            path: dayCoordinates,
            geodesic: true,
            strokeColor: '#FF0000',
            strokeOpacity: 1.0,
            strokeWeight: 2
        });
        pathLine.setMap(map);
        paths.push(pathLine);
        console.log("Path line drawn successfully.");
    } else {
        console.warn("Insufficient coordinates to draw a path line.");
    }

    if (dayCoordinates.length > 0) {
        map.setCenter(dayCoordinates[0]);
        console.log("Map centered at first marker's coordinates.");
    } else {
        console.warn("No valid coordinates found to center the map.");
    }
}


function clearMarkersAndPaths() {
    markers.forEach(marker => marker.setMap(null));
    paths.forEach(path => path.setMap(null));
    markers = [];
    paths = [];
    console.log("Cleared previous markers and paths.");
}

window.onload = initMap;
</script>


<!-- 메인 컨텐츠 -->
<div class="t_mainratio">
    <div class="t_titlesection">
        <div class="t_title">
            <c:if test="${not empty tripSchedules}">
                <h1>${tripSchedules[0].title}</h1>
                <p><strong class="plan-text">PLAN</strong>: ${tripSchedules[0].period_start} - ${tripSchedules[0].period_end}</p>
            </c:if>
        </div>
    </div>

    <!-- 지도 -->
    <div id="map" style="height: 450px;"></div>

    <!-- 일정 정보 -->
    <div class="schedule-container">
        <div class="day-cards">
            <c:forEach var="schedule" items="${tripSchedules}" varStatus="status">
                <c:if test="${status.first || tripSchedules[status.index - 1].day_number != schedule.day_number}">
                    <div class="day-card" onclick="addMarkersForDay(${schedule.day_number})">
                        <div class="day-header">
                            <h3>DAY ${schedule.day_number}</h3>
                        </div>
                        <div class="day-content">
                            <ul>
                </c:if>

                                <li>
                                    <span class="place-name">${schedule.place_name}</span>
                                    <p class="place-address">${schedule.place_address}</p>
                                </li>

                <c:if test="${status.last || tripSchedules[status.index + 1].day_number != schedule.day_number}">
                            </ul>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
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
