<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tripSchedule.title}</title>
    <link href="${pageContext.request.contextPath}/resources/css/TripPage.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet">
    
    <!-- 구글 맵 API 호출 시 initMap 함수를 콜백으로 설정 -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAiIs-_C5RuOG0OQB9PNf2bTZPXgb4MMeo&callback=initMap" async defer></script>
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
           <span><a href="${pageContext.request.contextPath}/Member/login">로그인</a></span>
           <span><a href="${pageContext.request.contextPath}/Member/joinmain">회원가입</a></span>
         </c:otherwise>
       </c:choose>
     </div>
   </div>
</header>

<!-- 메인 콘텐츠 시작 -->
<div class="content">
    <div class="t_mainratio">
        <div class="t_titlesection">
            <div class="t_title">
                <h1>${tripSchedule.title}</h1>
                <p><strong>PLAN</strong>: ${tripSchedule.period_start} - ${tripSchedule.period_end}</p>
            </div>
            <div class="t_date">
                <c:if test="${not empty tripSchedule.scheduleList}">
                    <p>${tripSchedule.scheduleList[0].city_name}</p>
                </c:if>
            </div>
        </div>

        <!-- 지도 영역 -->
		<div id="map-container">
		    <div id="map"></div>
		</div>


        <!-- 일정 카드 섹션 -->
        <div class="schedule-container">
            <button class="scroll-btn left" type="button" onclick="scrollLeft()">&#8249;</button>
            <div class="day-cards">
                <c:if test="${not empty tripSchedule.scheduleList}">
                    <c:set var="currentDay" value="-1" />
                    <c:forEach var="schedule" items="${tripSchedule.scheduleList}" varStatus="status">
                        <c:if test="${schedule.day_number != currentDay}">
                            <c:if test="${currentDay != -1}">
                                </ul>
                                </div>
                                </div>
                            </c:if>
                            <c:set var="currentDay" value="${schedule.day_number}" />
                            <!-- 새로운 Day 카드 시작 -->
                            <div class="day-card" onclick="showDayMarkers(${schedule.day_number})">
                                <div class="day-header">
                                    <h3>DAY ${schedule.day_number}</h3>
                                    <p>${tripSchedule.period_start} - ${tripSchedule.period_end}</p>
                                </div>
                                <div class="day-content">
                                    <ul>
                        </c:if>

                        <li>${schedule.city_name} - ${schedule.place_name} (${schedule.place_address})</li>

                        <c:if test="${status.last}">
                            </ul>
                            </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:if>
            </div>
            <button class="scroll-btn right" type="button" onclick="scrollRight()">&#8250;</button>
        </div>
    </div>
</div>

<!-- 지도 및 스크롤 기능 스크립트 -->
<script>
var map;
var markers = [];
var polylines = [];
var schedules = ${scheduleListJson};  // JSON 데이터를 JavaScript 변수로 초기화

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: { lat: 37.5665, lng: 126.9780 },
        zoom: 12
    });
    showDayMarkers(1);
}


    function showDayMarkers(dayNumber) {
        clearMarkersAndPolylines();
        var geocoder = new google.maps.Geocoder();
        var bounds = new google.maps.LatLngBounds();
        var daySchedules = schedules.filter(schedule => schedule.day_number === dayNumber);
        var pathCoordinates = [];

        for (let i = 0; i < daySchedules.length; i++) {
            geocodeAddress(geocoder, map, daySchedules[i].place_name, daySchedules[i].place_address, i + 1, bounds, pathCoordinates);
        }
    }

    function clearMarkersAndPolylines() {
        for (let i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];

        for (let i = 0; i < polylines.length; i++) {
            polylines[i].setMap(null);
        }
        polylines = [];
    }

    function geocodeAddress(geocoder, map, placeName, address, label, bounds, pathCoordinates) {
        geocoder.geocode({ 'address': address }, function(results, status) {
            if (status === 'OK') {
                var location = results[0].geometry.location;

                var marker = new google.maps.Marker({
                    map: map,
                    position: location,
                    label: label.toString(),
                    title: placeName
                });

                markers.push(marker);
                bounds.extend(location);
                map.fitBounds(bounds);

                pathCoordinates.push(location);

                if (pathCoordinates.length > 1) {
                    var polyline = new google.maps.Polyline({
                        path: pathCoordinates,
                        geodesic: true,
                        strokeColor: '#FF0000',
                        strokeOpacity: 1.0,
                        strokeWeight: 2
                    });
                    polyline.setMap(map);
                    polylines.push(polyline);
                }
            } else {
                console.error(`Geocode failed for address "${address}" with status: ${status}`);
            }
        });
    }

    function scrollLeft() {
        document.querySelector('.day-cards').scrollBy({ left: -300, behavior: 'smooth' });
    }

    function scrollRight() {
        document.querySelector('.day-cards').scrollBy({ left: 300, behavior: 'smooth' });
    }
</script>

<!-- 푸터 부분 -->
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h4>회사소개</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/introduce" target="_blank">회사소개</a></li>
        <li><a href="${pageContext.request.contextPath}/HotPlace/inputApi" target="_blank">공공데이터 API</a></li>
      </ul>
    </div>

    <div class="footer-section">
      <h4>고객지원</h4>
      <ul>
        <li><a href="#">공지사항</a></li>
        <li><a href="#">자주묻는 질문</a></li>
        <li><a href="#">문의하기</a></li>
      </ul>
    </div>

    <div class="footer-section">
      <h4>이용약관</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/clause" target="_blank">이용약관</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank">개인정보처리방침</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/marketing" target="_blank">광고성 정보 수신동의</a></li>
      </ul>
    </div>

    <div class="footer-company-info">
      <p>상호: (주)BBOL | 대표: 박예슬 | 사업자등록번호: 123-45-67890 | 통신판매업 신고번호: 2024-충남천안-00000 | 개인정보관리 책임자: 수수옥</p>
      <p>주소: 충청남도 천안시 동남구 123 | 이메일: support@BBOL3.com | 대표전화: 02-1234-5678</p>
      <p>© 2024 BBOLBBOLBBOL. All Rights Reserved.</p>
    </div>

    <div class="footer-social">
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-facebook-f"></i></a>
      <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
  </div>
</footer>

</body>
</html>
