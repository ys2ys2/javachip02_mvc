<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>뽈뽈뽈 / 여행 일정 만들기</title>

<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/tripSched.css" rel="stylesheet" type="text/css">

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBGXfM-W2P67M4VmuJdGHedKT73_rMEWQ&libraries=places&callback=initMap" async defer></script>



</head>
<body>

 <!-- 어두운 배경 -->
 <div class="overlay"></div>
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

<!-- 메인 시작 -->

<div class="t_mainratio">
	<div class="t_titlesection">
		<div class="t_title">
			<input type="text" class="title-input" placeholder="제목을 입력해 주세요">
		</div>
		<div class="t_date">
			<input type="text" class="date-picker" value="">
			<button type="submit" class="t_calendar">
				<img src="${pageContext.request.contextPath}/resources/images/t_date.png"></button>
			<div class="date_btnsection">
			    <button class="date_btn">메모/가계부 보기</button>
			    <button class="date_btn">항공 일정 등록</button>
		    </div>
	    </div>
    </div>
    
    <div id="map"></div>
    
    <!-- 수정 일정 리스트 -->
	<div class="schedule-container">
	    <div class="day-cards" id="dayCardsContainer">
	        <!-- 기본 카드들 -->
	        <div class="day-card" id="day1">
	            <div class="day-header">
	                <h3>DAY 1</h3>
	                <button class="delete-btn" onclick="deleteDayCard(this)">🗑</button> <!-- 삭제 버튼 -->
	            </div>
	            <div class="day-content">
	                <button class="add-schedule-btn" onclick="openPlaceSearch('day1')">📅 일정 추가</button>
	            </div>
	        </div>
	        <div class="day-card" id="day2">
	            <div class="day-header">
	                <h3>DAY 2</h3>
	                <button class="delete-btn" onclick="deleteDayCard(this)">🗑</button> <!-- 삭제 버튼 -->
	            </div>
	            <div class="day-content">
	                <button class="add-schedule-btn" onclick="openPlaceSearch('day2')">📅 일정 추가</button>
	            </div>
	        </div>
	        <button id="addDayBtn" class="add-day-btn">일정 추가</button> <!-- 일정 추가 버튼 -->
	    </div>
	</div>

	<!-- 장소 검색 팝업 -->
	<div id="placeSearchPanel" class="t_place-search-panel">
	    <div class="t_search-container-horizontal">
	        <!-- 도시 검색 -->
	        <div class="search-itemC">
	            <img src="https://www.wishbeen.co.kr/geo.922951f5cf1908d9.svg" alt="도시 검색 아이콘" class="search-icon" />
	            <input id="citySearch" placeholder="전체도시" type="text" />
	        </div>
	
	        <!-- 여행지 자동 완성 -->
	        <div class="search-item">
	            <input id="autocomplete" placeholder="가고 싶은 장소를 검색해 보세요." type="text" />
	            <img src="https://www.wishbeen.co.kr/assets/images/svg/search.svg" alt="검색 아이콘" />
	        </div>
	    </div>
		
		<!-- 선택한 여행지 -->
		<div id="selectedPlaces" class="selected-places-container">
	    <h4>선택한 여행지</h4>
	    <!-- 선택된 장소들이 태그 형식으로 여기에 추가됩니다 -->
		</div>
	    
	    <!-- 장소 검색 결과 리스트 -->
	    <div id="placeResults" class="t_place-results">
		    <ul id="placeResultsList"></ul>
		</div>
	    
	    <!-- 더보기 버튼 -->
    	<button id="loadMoreBtn" style="display: none;" onclick="loadMorePlaces()">더보기</button>
	    
	    <button class="t_close-btn" onclick="closePlaceSearch()">닫기</button>
	</div>

	
    
	
	

</div><!-- end of t_mainratio -->






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




<script>

var map, service;
var city, cityLocation; // 도시 이름과 위치를 저장하는 변수
var markers = [];  // 여러 마커를 저장하는 배열
var placeResults = [];
var currentIndex = 0;
const pageSize = 10;  // 한 번에 보여줄 장소 개수
var selectedPlaces = []; // 선택된 장소들을 저장할 배열
var placeAutocomplete;  // 장소 자동완성 객체

// 지도 및 Autocomplete 초기화
function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: { lat: 37.5665, lng: 126.9780 },  // 서울 좌표
        zoom: 13
    });

    // Places 서비스 객체 초기화
    service = new google.maps.places.PlacesService(map);

    // 도시 검색 자동완성 초기화
    cityAutocomplete = new google.maps.places.Autocomplete(
        document.getElementById('citySearch'),
        { types: ['(cities)'] }  // 도시만 자동완성으로 제한
    );

    // 장소 검색 자동완성 초기화
    placeAutocomplete = new google.maps.places.Autocomplete(
        document.getElementById('autocomplete'),
        { types: ['establishment'] }  // 장소로 제한
    );

    // 도시 선택 시 실행되는 콜백
    cityAutocomplete.addListener('place_changed', function() {
        var place = cityAutocomplete.getPlace();
        if (!place.geometry) {
            alert("도시를 찾을 수 없습니다.");
            return;
        }
        // 선택된 도시의 위치 정보 저장
        cityLocation = place.geometry.location;
        map.setCenter(cityLocation);  // 선택된 도시로 지도 이동
        map.setZoom(15);
        
        // 장소 자동완성에서 검색하는 범위를 해당 도시로 한정
        placeAutocomplete.setBounds(new google.maps.LatLngBounds(cityLocation));
        console.log("선택된 도시:", place.formatted_address, cityLocation);
        searchPlacesInCity();  // 초기 장소 리스트 검색
    });

    // 장소 자동완성에서 장소가 선택될 때
    placeAutocomplete.addListener('place_changed', function() {
        var place = placeAutocomplete.getPlace();
        if (!place.geometry) {
            alert("장소를 찾을 수 없습니다.");
            return;
        }
        // 선택된 장소는 리스트에 추가됨
        placeResults = [place];
        currentIndex = 0;
        displayPlaces();  // 검색된 장소를 리스트에 표시
    });

    // 검색 버튼으로 직접 검색
    document.getElementById('searchBtn').addEventListener('click', function() {
        var searchQuery = document.getElementById('autocomplete').value;
        if (searchQuery) {
            var request = {
                query: searchQuery,
                location: cityLocation,
                radius: '5000'
            };

            service.textSearch(request, function(results, status) {
                if (status === google.maps.places.PlacesServiceStatus.OK) {
                    placeResults = results;  // 검색된 결과를 저장
                    currentIndex = 0;
                    displayPlaces();  // 검색된 결과를 리스트에 표시
                } else {
                    console.log("검색 실패:", status);
                    alert("검색에 실패했습니다.");
                }
            });
        }
    });
}

// 장소를 지도에 마커로 표시하고 선택된 장소를 저장하는 함수
function selectPlaceOnMap(place) {
    if (!place.geometry || !place.geometry.location) {
        alert("해당 장소에 대한 위치 정보를 찾을 수 없습니다.");
        return;
    }

    // 선택된 장소에 마커 추가
    var marker = new google.maps.Marker({
        position: place.geometry.location,
        map: map,
        title: place.name
    });
    markers.push(marker);  // 마커 배열에 저장

    // 지도 중심을 선택된 장소로 이동
    map.setCenter(place.geometry.location);
    map.setZoom(15);

    // 선택한 여행지 태그 추가
    addSelectedPlaceTag(place, marker);
}

// 선택된 여행지를 태그 형식으로 표시하는 함수
function addSelectedPlaceTag(place, marker) {
    var selectedPlaceContainer = document.getElementById('selectedPlaces');
    
    var placeTag = document.createElement('div');
    placeTag.className = 'selected-place-tag';
    placeTag.textContent = place.name + ' (' + place.vicinity + ')';

    var closeButton = document.createElement('button');
    closeButton.textContent = 'X';
    closeButton.className = 'close-btn';
    closeButton.addEventListener('click', function() {
        // 마커와 태그 삭제
        marker.setMap(null);  // 마커 제거
        placeTag.remove();    // 태그 제거

        // selectedPlaces 배열에서도 제거
        selectedPlaces = selectedPlaces.filter(function(p) {
            return p !== place;
        });
    });

    placeTag.appendChild(closeButton);
    selectedPlaceContainer.appendChild(placeTag);

    selectedPlaces.push(place);
}

// 장소 목록 출력 함수
function displayPlaces() {
    var resultContainer = document.getElementById('placeResultsList');
    var placeResultsBox = document.getElementById('placeResults');
    resultContainer.innerHTML = '';  // 기존 결과 초기화

    if (placeResults.length > 0) {
        // 장소가 검색되었을 때만 결과 박스를 표시
        placeResultsBox.style.display = 'block';
    } else {
        // 검색 결과가 없으면 박스를 숨김
        placeResultsBox.style.display = 'none';
    }

    for (let i = currentIndex; i < Math.min(currentIndex + pageSize, placeResults.length); i++) {
        var place = placeResults[i];

        var placeName = place.name || '이름 정보 없음';
        var placeVicinity = place.vicinity || '근처 정보 없음';
        var placeIcon = place.icon || 'default_icon_path';  // 아이콘이 없을 경우 기본 아이콘 설정

        // 리스트 아이템을 생성
        var li = document.createElement('li');
        li.className = 'place-item';

        // 장소 아이콘을 포함한 div 생성
        var iconDiv = document.createElement('div');
        iconDiv.className = 'place-icon';
        var iconImg = document.createElement('img');
        iconImg.src = placeIcon;
        iconImg.alt = "아이콘";
        iconDiv.appendChild(iconImg);

        // 장소 이름과 근처 정보를 포함한 div 생성
        var placeDetails = document.createElement('div');
        placeDetails.className = 'place-details';
        var strong = document.createElement('strong');
        strong.textContent = placeName;
        var span = document.createElement('span');
        span.textContent = placeVicinity;

        // 선택 버튼 추가
        var selectButton = document.createElement('button');
        selectButton.textContent = '선택';
        selectButton.className = 'select-btn';
        selectButton.addEventListener('click', function() {
            selectPlaceOnMap(place);  // 선택한 장소에 마커 추가
        });

        placeDetails.appendChild(strong);
        placeDetails.appendChild(document.createElement('br'));  // 줄바꿈
        placeDetails.appendChild(span);

        li.appendChild(iconDiv);
        li.appendChild(placeDetails);
        li.appendChild(selectButton);  // 선택 버튼 추가

        resultContainer.appendChild(li);
    }

    currentIndex += pageSize;

    if (currentIndex < placeResults.length) {
        document.getElementById('loadMoreBtn').style.display = 'block';
    } else {
        document.getElementById('loadMoreBtn').style.display = 'none';
    }

    console.log("표시된 장소:", placeResults);
}

// 선택된 도시 근처 장소를 검색하는 함수
function searchPlacesInCity() {
    if (!cityLocation) {
        alert("먼저 도시를 선택해주세요.");
        return;
    }

    var request = {
        location: cityLocation,
        radius: '5000',  // 반경 5km
        type: ['establishment']  // 일반 장소 검색
    };

    console.log("검색 요청:", request);

    service.nearbySearch(request, function(results, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
            placeResults = results.sort((a, b) => a.name.localeCompare(b.name));  // 가나다순 정렬
            currentIndex = 0;
            displayPlaces();
        } else {
            console.log("검색 실패:", status);
            alert("장소 검색에 실패했습니다. 다시 시도해주세요.");
        }
    });
}

// 더보기 버튼 클릭 시 실행되는 함수
function loadMorePlaces() {
    displayPlaces();
}

// 장소 검색 패널 열기
function openPlaceSearch(dayId) {
    document.getElementById('placeSearchPanel').style.display = 'block';
    document.querySelector('.overlay').style.display = 'block';	// 오버레이 보이기
}

// 장소 검색 패널 닫기
function closePlaceSearch() {
    document.getElementById('placeSearchPanel').style.display = 'none';
    document.querySelector('.overlay').style.display = 'none';  // 오버레이 숨기기

}


</script>


<script>
    let dayCount = 3; // 기존 2개의 카드가 있으므로, 새로 추가할 카드는 DAY 3부터 시작

    // 일정 추가 버튼을 클릭했을 때 새로운 카드를 추가하는 함수
    document.getElementById('addDayBtn').addEventListener('click', function() {
        const dayCardsContainer = document.getElementById('dayCardsContainer');
        
        // 새로운 카드 div 생성
        const newDayCard = document.createElement('div');
        newDayCard.classList.add('day-card');
        newDayCard.id = `day${dayCount}`; // id는 day3, day4, ... 이렇게 생성
        
        // 새로운 카드의 내부 HTML 설정
        newDayCard.innerHTML = `
            <div class="day-header">
                <h3>DAY ${dayCount}</h3> <!-- DAY 번호 표시 -->
                <button class="delete-btn" onclick="deleteDayCard(this)">🗑</button> <!-- 삭제 버튼 -->
            </div>
            <div class="day-content">
                <button class="add-schedule-btn" onclick="openPlaceSearch('day${dayCount}')">📅 일정 추가</button>
            </div>
        `;

        // 컨테이너에 새로운 카드 추가 (추가 버튼 위에)
        dayCardsContainer.insertBefore(newDayCard, document.getElementById('addDayBtn'));

        // Day 번호 증가
        dayCount++;
    });

    // 카드 삭제 함수
    function deleteDayCard(button) {
        const card = button.closest('.day-card');
        card.remove(); // 선택한 카드 삭제
    }
</script>



</body>

</html>
