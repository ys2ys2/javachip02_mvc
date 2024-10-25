<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여 행 뽈 뽈</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- 공통 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/header.css' />">  <!-- 공통 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/footer.css' />">  <!-- 공통 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/TravelSpot.css?v=1.1' />"> <!-- CSS 파일 단일화 -->
</head>

<body>
  <header>
    <div class="header-container">
      <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
      <nav>
        <ul>
            <li><a href="#" data-ko="홈" data-en="Home">홈</a></li>
            <li><a href="#" data-ko="커뮤니티" data-en="Community">커뮤니티</a></li>
            <li><a href="#" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
            <li><a href="#" data-ko="여행뽈뽈" data-en="BBOL BBOL BBOL">여행뽈뽈</a></li>
            <li><button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button></li>
            <li><button class="user-btn"><i class="fa-solid fa-user"></i></button></li>
            <li><button class="earth-btn"><i class="fa-solid fa-earth-americas"></i></button></li>
            <li><button class="korean" id="lang-btn" data-lang="ko">English</button></li>
        </ul>
      </nav>
    </div>
</header>

<main>
    <section class="map-and-places">
        <div class="map-container">
            <div id="map"></div>
        </div>
        <div class="places-list">
            <h3>#테마 #공연 #축제가 있는 여행을 즐겨보세요!</h3>
            <ul id="places-list">
                <c:forEach var="place" items="${placesList}">
                    <li>
                        <img src="${place.c_firstImage}" alt="${place.c_title}">
                        <p>${place.c_title}</p>
                        <p>${place.c_addr1 != null ? place.c_addr1 : '주소 정보 없음'}</p>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </section>
</main>

<!-- 푸터 부분 -->
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h4>회사소개</h4>
      <ul>
        <li><a href="#">회사소개</a></li>
        <li><a href="#">브랜드 이야기</a></li>
        <li><a href="#">채용공고</a></li>
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
        <li><a href="#">이용약관</a></li>
        <li><a href="#">개인정보처리방침</a></li>
        <li><a href="#">저작권 보호정책</a></li>
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
</footer>

<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_kDjiknfR2lOvFC9TGAQknSJQ1fNFePg&callback=initMap"></script>
<script>
    // 지도 초기화
    function initMap() {
        var mapOptions = {
            center: new google.maps.LatLng(36.5, 127.5), // 대한민국 중앙 좌표
            zoom: 7
        };
        var map = new google.maps.Map(document.getElementById("map"), mapOptions);

        // API에서 관광지 데이터를 불러옵니다
        fetchTouristPlaces(map);
    }

    // 관광지 데이터를 불러오는 함수
    function fetchTouristPlaces(map) {
        const url = 'http://apis.data.go.kr/B551011/KorService1/areaBasedList1';
        const serviceKey = 'BRHEr4BE8os3yCBNEaw7CUD1eGB4KxtoM1uvJkHTZIBl1HPepXIX55ULa7HVIQ8zqt48NpO8Ut6eGxqgAr9E4g%3D%3D';
        const params = `?serviceKey=${serviceKey}&numOfRows=20&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json`;

        fetch(url + params)
            .then(response => response.json())
            .then(data => {
                const places = data.response.body.items.item;
                displayPlacesOnMap(places, map);
                displayPlacesList(places);
            })
            .catch(error => console.error('Error:', error));
    }

    // 지도에 관광지를 표시하는 함수 (이미지가 있는 경우 이미지 마커로 표시)
    function displayPlacesOnMap(places, map) {
        places.forEach(place => {
            if (!place.c_firstImage || place.c_firstImage.length === 0) {
                return;  // 이미지가 없는 항목은 스킵
            }

            // 마커를 위한 div 요소 생성
            const markerDiv = document.createElement('div');
            markerDiv.classList.add('map-marker');
            markerDiv.innerHTML = `
                <img src="${place.c_firstImage}" alt="${place.c_title}">
                <div class="map-marker-arrow"></div>
            `;

            const marker = new google.maps.Marker({
                position: new google.maps.LatLng(place.mapy, place.mapx),
                map: map,
                icon: {
                    url: '',  // 마커의 기본 아이콘을 빈 값으로 설정하여 숨김
                },
                title: place.c_title
            });

            const infoWindow = new google.maps.InfoWindow({
                content: `<div class="info-window-content"><h4>${place.c_title}</h4><p>${place.c_addr1}</p></div>`
            });

            marker.addListener('click', function() {
                infoWindow.open(map, marker);
            });

            // 커스텀 마커를 위한 오버레이 설정
            const overlay = new google.maps.OverlayView();
            overlay.onAdd = function () {
                const layer = this.getPanes().overlayLayer;
                layer.appendChild(markerDiv);
            };

            overlay.draw = function () {
                const projection = this.getProjection();
                const position = projection.fromLatLngToDivPixel(marker.getPosition());

                // 좌표가 정확히 계산되었는지 확인하고, 마커의 위치 보정
                if (position) {
                    markerDiv.style.left = (position.x - markerDiv.offsetWidth / 2) + 'px';
                    markerDiv.style.top = (position.y - markerDiv.offsetHeight + 25) + 'px';  // 위치 보정 값 25px로 변경
                }
            };

            overlay.setMap(map);
        });
    }

    // 관광지 리스트를 화면에 표시하는 함수 (이미지가 없는 데이터는 제외)
    function displayPlacesList(places) {
        const placesList = document.getElementById('places-list');
        placesList.innerHTML = ''; // 기존 내용을 지웁니다

        places.forEach(place => {
            // 이미지가 없는 데이터를 걸러냄
            if (!place.c_firstImage || place.c_firstImage.length === 0) {
                return;  // 이미지가 없는 항목은 스킵
            }

            const listItem = document.createElement('li');

            // 이미지 추가
            const img = document.createElement('img');
            img.src = place.c_firstImage; // 이미지가 있으면 사용
            img.alt = place.c_title;

            // 이름과 위치 추가
            const name = document.createElement('p');
            name.textContent = place.c_title;

            const location = document.createElement('p');
            location.textContent = place.c_addr1 || '주소 정보 없음';

            // 리스트 항목에 추가
            listItem.appendChild(img);
            listItem.appendChild(name);
            listItem.appendChild(location);
            placesList.appendChild(listItem);
        });
    }

    // 페이지가 로드되면 지도를 초기화
    window.onload = function() {
        initMap();
    };
</script>
</body>
</html>
