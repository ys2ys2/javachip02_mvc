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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />


<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBGXfM-W2P67M4VmuJdGHedKT73_rMEWQ&libraries=places&callback=initMap" async defer></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

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


<!-- 메인 시작 -->
	<form action="${pageContext.request.contextPath}/saveTripSchedule" method="post">
	<div class="t_mainratio">
		<div class="t_titlesection">
			<div class="t_title">
				<input type="text" class="title-input" name="title" id="titleInput" placeholder="제목을 입력해 주세요">
			</div>
			<div class="t_date">
				<input type="text" class="date-picker" name="t_dbdate" id="dateInput" value="" readonly>
				<button type="button" class="t_calendar">
					<img src="${pageContext.request.contextPath}/resources/images/t_date.png">
				</button>
			</div>
		</div>

		<div id="map"></div>

		<!-- 수정 일정 리스트 -->
		<div class="schedule-container">
			<button class="scroll-btn left" type="button" onclick="scrollLeftContent()">&#8249;</button>

			<div class="day-cards" id="dayCardsContainer">
				<!-- 기본 카드들 -->
				<div class="day-card" id="day1">
					<div class="day-header">
						<h3>DAY 1</h3>
						<button class="delete-btn" type="button" onclick="deleteDayCard(this)">🗑</button> <!-- 삭제 버튼 -->
					</div>
					<div class="day-content">
						<button class="add-schedule-btn" type="button" onclick="openPlaceSearch('day1')">📅 일정 추가</button>
					</div>
				</div>
				<div class="day-card" id="day2">
					<div class="day-header">
						<h3>DAY 2</h3>
						<button class="delete-btn" type="button" onclick="deleteDayCard(this)">🗑</button> <!-- 삭제 버튼 -->
					</div>
					<div class="day-content">
						<button class="add-schedule-btn" type="button" onclick="openPlaceSearch('day2')">📅 일정 추가</button>
					</div>
				</div>
				<button id="addDayBtn" class="add-day-btn" type="button">일정 추가</button> <!-- 일정 추가 버튼 -->
			</div>
			<button class="scroll-btn right" type="button" onclick="scrollRightContent()">&#8250;</button>

			<!-- 로그인 상태 확인 후 저장 -->
			<c:choose>
				<c:when test="${empty sessionScope.member.m_email}">
					<!-- 로그인되지 않은 경우 -->
					<a href="${pageContext.request.contextPath}/Member/login" class="schedule_save" onclick="alert('로그인 해 주시길 바랍니다!');">저장하기</a>
				</c:when>
				<c:otherwise>
					<!-- 로그인된 경우 -->
					<button type="submit" class="schedule_save" onclick="prepareScheduleData()">저장하기</button>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- Hidden input fields for server submission -->
		<div id="hiddenFieldsContainer"></div>
	</div>
	</form>
	
	

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
	    <div id="placeResults" class="t_place-results" style="display: none;">
		    <ul id="placeResultsList"></ul>
		</div>
	    
	    <!-- 더보기 버튼 -->
    	<button class="t_moreinfo" id="loadMoreBtn" style="display: none;" onclick="loadMorePlaces()">더보기</button>
	    <div class="t_csbutton">
		    <!-- 닫기 버튼 -->
		    <button class="t_close-btn" onclick="closePlaceSearch()">닫기</button>
		    <!-- 저장 버튼 -->
	    	<button class="t_save-btn" id="savePlacesBtn" class="t_save-btn" onclick="saveSelectedPlaces()">저장</button>
    	</div>
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
var selectedPlacesCoordinates = []; // 선택된 장소들의 좌표를 저장하는 배열
var placeResults = [];
var currentIndex = 0;
const pageSize = 10;  // 한 번에 보여줄 장소 개수
var selectedPlaces = []; // 선택된 장소들을 저장할 배열
var placeAutocomplete;  // 장소 자동완성 객체
var polyline;  // Polyline 객체
var selectedPlacesPerDay = {}; // 각 DAY별로 선택된 장소들을 저장하는 객체
var currentDay = null; // 현재 선택된 DAY를 추적하는 변수
var paginationObject = null;  // pagination을 저장하는 변수
var currentCityName = '';

// 지도 및 Autocomplete 초기화
function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: { lat: 37.5665, lng: 126.9780 },  // 서울 좌표
        zoom: 13
    });
    
    // 선을 그릴 Polyline 객체 초기화
    polyline = new google.maps.Polyline({
        path: selectedPlacesCoordinates,  // 선택된 좌표로 선을 그림
        geodesic: true,
        strokeColor: '#FF0000',  // 선 색상 (빨간색)
        strokeOpacity: 1.0,      // 선 투명도
        strokeWeight: 2          // 선 두께
    });
    polyline.setMap(map);  // 지도에 선을 추가

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
        map.setZoom(11);
        
        // 도시 이름을 currentCityName에 저장
        currentCityName = place.formatted_address; // 도시 이름
        console.log("선택된 도시:", currentCityName); // 콘솔에 도시 이름 출력
        
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

//장소를 지도에 마커로 표시하고 선택된 장소를 저장하는 함수
function selectPlaceOnMap(place, index = null) {
    var location;
    if (place.geometry && place.geometry.location) {
        // 새로 선택된 장소인 경우
        location = place.geometry.location;
    } else if (place.lat && place.lng) {
        // 이미 저장된 장소를 복원하는 경우
        location = new google.maps.LatLng(place.lat, place.lng);
    } else {
        alert("해당 장소에 대한 위치 정보를 찾을 수 없습니다.");
        return;
    }

    // currentDay에 해당하는 장소 배열이 없으면 초기화
    if (!selectedPlacesPerDay[currentDay]) {
        selectedPlacesPerDay[currentDay] = [];  // currentDay에 대한 배열 초기화
        console.log("새로운 Day 배열을 초기화했습니다: ", currentDay);
    }

    // 마커 번호 설정: 복원된 경우에는 index 값 사용, 새로운 경우에는 배열 길이 사용
    var markerNumber = index !== null ? (index + 1) : (selectedPlacesPerDay[currentDay].length + 1);
    
    // 선택된 장소에 마커 추가 + 순서 라벨까지
    var marker = new google.maps.Marker({
        position: location, 
        map: map,
        label: {
            text: markerNumber.toString(), // 마커에 붙일 번호
            color: "white",
            fontSize: "14px",
            fontWeight: "bold"
        },
        title: place.name
    });
    
    // 마커 배열에 저장
    markers.push(marker);  
    // 선택된 장소의 좌표를 배열에 추가
    selectedPlacesCoordinates.push(location); // 경로 좌표 추가
    // Polyline에 새 좌표 추가 후 업데이트
    polyline.setPath(selectedPlacesCoordinates);  // 선 업데이트

    // 지도 중심을 선택된 장소로 이동
    map.setCenter(location);
    map.setZoom(16);

    // 선택한 여행지 태그 추가
    addSelectedPlaceTag(place, marker);
    
    // currentDay에 선택된 장소 추가 (새로 선택된 경우에만 lat, lng 저장)
    if (!place.lat && !place.lng) {
        selectedPlacesPerDay[currentDay].push({
            name: place.name,
            vicinity: place.vicinity,
            lat: location.lat(),  // 위도 저장
            lng: location.lng()   // 경도 저장
        });
    }
    
    console.log("Selected places for " + currentDay + ":", selectedPlacesPerDay[currentDay]);  // 선택된 장소들 콘솔 출력
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

     	// Polyline 경로에서 해당 장소 좌표 제거
        var index = selectedPlacesCoordinates.indexOf(place.geometry.location);
        if (index !== -1) {
            selectedPlacesCoordinates.splice(index, 1);  // 경로에서 제거
            polyline.setPath(selectedPlacesCoordinates);  // 경로 업데이트
        }
        
        // 선택된 장소 배열에서 해당 장소 제거 (currentDay에 해당하는 배열에서 제거)
        selectedPlacesPerDay[currentDay] = selectedPlacesPerDay[currentDay].filter(function(p) {
            return p.name !== place.name && p.vicinity !== place.vicinity;
        });
        
     	// 저장할 장소가 남아 있는지 확인
        if (selectedPlacesPerDay[currentDay].length === 0) {
            console.log('모든 장소가 삭제되었습니다.');
        }
        
    });

    placeTag.appendChild(closeButton);
    selectedPlaceContainer.appendChild(placeTag);
    selectedPlaces.push(place); // 선택된 장소 배열에 추가
}

//장소 목록 출력 함수
function displayPlaces() {
    const resultContainer = document.getElementById('placeResultsList');
    const placeResultsBox = document.getElementById('placeResults');
    
    // 기존 장소 목록을 초기화 (페이지네이션처럼 새 장소로 대체)
    resultContainer.innerHTML = '';  

    const placesToShow = placeResults.slice(currentIndex, currentIndex + pageSize);

    if (placeResults.length > 0) {
        // 장소가 검색되었을 때만 결과 박스를 표시
        placeResultsBox.style.display = 'block';
    } else {
        // 검색 결과가 없으면 박스를 숨김
        placeResultsBox.style.display = 'none';
    }

    placesToShow.forEach(function(place) {
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

        // selectPlaceOnMap에 현재 장소 정보를 전달하는 부분
        (function(place) {
            selectButton.addEventListener('click', function() {
                selectPlaceOnMap(place);  // 선택한 장소에 맞게 마커 추가
            });
        })(place);  // 즉시 실행 함수로 place 값을 고정

        placeDetails.appendChild(strong);
        placeDetails.appendChild(document.createElement('br'));  // 줄바꿈
        placeDetails.appendChild(span);

        li.appendChild(iconDiv);
        li.appendChild(placeDetails);
        li.appendChild(selectButton);  // 선택 버튼 추가

        resultContainer.appendChild(li);  // 리스트에 추가
    });

    currentIndex += pageSize;  // 다음 페이지로 넘어가기 위해 인덱스 증가

    // 장소가 남아 있을 때는 버튼이 계속 표시되도록 변경
    if (currentIndex < placeResults.length || (paginationObject && paginationObject.hasNextPage)) {
        document.getElementById('loadMoreBtn').style.display = 'block';
    } else {
        // 장소를 모두 표시했을 때만 버튼을 숨김
        document.getElementById('loadMoreBtn').style.display = 'none';
    }

    console.log("표시된 장소:", placeResults);
}

// 더보기 버튼 클릭 시 실행되는 함수
function loadMorePlaces() {
    if (paginationObject && paginationObject.hasNextPage) {
        // pagination이 있는 경우 다음 페이지 로드
        paginationObject.nextPage();  // 구글 맵스에서 제공하는 함수로 다음 페이지 데이터를 가져옴
    } else {
        displayPlaces();  // 다음 페이지의 장소 불러오기
    }
}



// 선택된 도시 근처 장소를 검색하는 함수
function searchPlacesInCity() {
    if (!cityLocation) {
        alert("먼저 도시를 선택해주세요.");
        return;
    }

    var request = {
        location: cityLocation,
        radius: '50000',  // 반경 50km
        type: ['establishment']  // 일반 장소 검색
    };

    console.log("검색 요청:", request);

    service.nearbySearch(request, function(results, status, pagination) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
            placeResults = results.sort((a, b) => a.name.localeCompare(b.name));  // 가나다순 정렬
            currentIndex = 0;  // 검색 시 인덱스 초기화
            document.getElementById('placeResultsList').innerHTML = '';  // 검색 시 기존 결과 초기화
            document.querySelector('.t_place-results').style.display = 'block'; //장소 검색 완료
            paginationObject = pagination;  // pagination 객체 저장
            displayPlaces();  // 첫 번째 페이지의 장소 표시
        } else {
            console.log("검색 실패:", status);
            alert("장소 검색에 실패했습니다. 다시 시도해주세요.");
        }
    });
}


document.querySelectorAll('.add-schedule-btn').forEach(function(button) {
    button.addEventListener('click', function(event) {
        event.preventDefault();  // 폼 전송 방지
        openPlaceSearch();  // 장소 검색 열기 등의 기능 실행
    });
});




//저장 버튼 누르면 day에 저장
function saveSelectedPlaces() {
    if (!currentDay) {
        alert('먼저 DAY를 선택해 주세요.');
        return;
    }
    
    var dayContent = document.querySelector('#' + currentDay + ' .day-content'); // 현재 선택된 DAY의 일정 리스트 부분

    if (!selectedPlacesPerDay[currentDay] || selectedPlacesPerDay[currentDay].length === 0) {
        alert('저장할 장소가 없습니다.');
        return;
    }

    // 기존 장소 목록 초기화 (기존 저장된 장소만 초기화, "일정 추가" 버튼은 유지)
    var addScheduleBtn = dayContent.querySelector('.add-schedule-btn'); // 일정 추가 버튼 찾기
    dayContent.innerHTML = ''; // 기존 내용 초기화
    
    // 일정 추가 버튼 다시 추가
    dayContent.appendChild(addScheduleBtn);

    // 선택된 장소들을 DAY에 표시
    selectedPlacesPerDay[currentDay].forEach(function(place, index) {
        var listItem = document.createElement('div');
        listItem.className = 'saved-place-item';

        listItem.innerHTML = '<span>' + (index + 1) + '.</span> ' + // 순서 번호 추가
                             '<strong><span>' + place.name + '</span></strong><br>' + // 장소 이름
                             '<div class="p_name">' + place.vicinity; + '</div>'	// 장소 주소

        dayContent.appendChild(listItem); // DAY의 리스트에 추가
    });

    // 패널 닫기
    closePlaceSearch();
}


//페이지 로드 시 day1, day2에 대한 이벤트 리스너를 수동으로 추가
document.addEventListener('DOMContentLoaded', function() {
    // day1에 대한 일정 추가 버튼에 이벤트 리스너 추가
    document.querySelector('#day1 .add-schedule-btn').addEventListener('click', function() {
        openPlaceSearch('day1'); // day1에 대한 장소 검색 열기
    });

    // day2에 대한 일정 추가 버튼에 이벤트 리스너 추가
    document.querySelector('#day2 .add-schedule-btn').addEventListener('click', function() {
        openPlaceSearch('day2'); // day2에 대한 장소 검색 열기
    });
});



//장소 검색 패널 열기 (DAY 진입 시)
function openPlaceSearch(dayId) {
    currentDay = dayId; // 선택된 DAY 기록 (예: 'day1', 'day2' 등)
    console.log("Current day:", currentDay); // dayId가 올바르게 전달되었는지 확인
    event.preventDefault();

    // 선택된 태그들 및 장소들 초기화 (새로운 DAY로 진입 시)
    clearSelectedPlaces();
    // 새로운 DAY로 들어갈 때, t_place-results를 다시 숨김
    document.querySelector('.t_place-results').style.display = 'none';


    // currentDay에 맞는 장소 표시 (이미 선택된 장소가 있는 경우)
    if (selectedPlacesPerDay[currentDay] && selectedPlacesPerDay[currentDay].length > 0) {
        selectedPlacesPerDay[currentDay].forEach(function(place, index) {
            // 이미 선택된 장소들을 다시 태그로 추가
            selectPlaceOnMap(place, index);
        });
    } else {
        // 선택된 장소가 없는 경우, 검색 결과와 태그를 모두 초기화
        document.getElementById('placeResultsList').innerHTML = '';  // 기존 검색 결과 초기화
    }

    document.getElementById('placeSearchPanel').style.display = 'block';
    document.querySelector('.overlay').style.display = 'block'; // 오버레이 보이기
}


//선택된 장소 초기화 함수 (태그, 마커, 선 모두 초기화)
function clearSelectedPlaces() {
    var selectedPlaceContainer = document.getElementById('selectedPlaces');
    selectedPlaceContainer.innerHTML = ''; // 선택된 장소 태그 초기화

    // 지도에서 마커 모두 제거
    markers.forEach(function(marker) {
        marker.setMap(null);
    });
    markers = [];  // 마커 배열 초기화

    // Polyline 좌표 초기화
    selectedPlacesCoordinates = [];
    polyline.setPath(selectedPlacesCoordinates);  // 선 초기화

    // 선택된 장소 배열 초기화
    selectedPlaceInfo = [];
}

//팝업을 열지 않고 저장된 장소와 마커만 복원하는 함수
function loadDayPlaces(dayId) {
    currentDay = dayId;  // 현재 선택된 DAY 설정
    // 기존 선택된 장소 초기화
    clearSelectedPlaces();

    // 해당 DAY에 저장된 장소를 복원
    if (selectedPlacesPerDay[dayId] && selectedPlacesPerDay[dayId].length > 0) {
        // 첫 번째 장소로 지도 중심 이동
        const firstPlace = selectedPlacesPerDay[dayId][0];
        const firstLocation = new google.maps.LatLng(firstPlace.lat, firstPlace.lng);
        map.setCenter(firstLocation);  // 첫 번째 장소로 지도 중심 이동
        map.setZoom(16);  // 줌 설정

        //저장된 장소들 마커와 함께 복원
        selectedPlacesPerDay[dayId].forEach((place, index) => {
            selectPlaceOnMap(place, index);
        });
    }
}


// 장소 검색 패널 닫기
function closePlaceSearch() {
    document.getElementById('placeSearchPanel').style.display = 'none';
    document.querySelector('.overlay').style.display = 'none';  // 오버레이 숨기기

}

var selectedPlaceInfo = []; // 선택된 장소 정보를 저장하는 배열



</script>


<script>
//카드 순서를 다시 계산하는 함수
function updateDayHeaders() {
    const dayCards = document.querySelectorAll('.day-card');
    dayCards.forEach((card, index) => {
        const dayHeader = card.querySelector('.day-header h3');
        dayHeader.textContent = 'DAY ' + (index + 1);  // 인덱스를 기반으로 DAY 숫자 업데이트
    });
}

// 일정 추가 버튼을 클릭했을 때 새로운 카드를 추가하는 함수
document.getElementById('addDayBtn').addEventListener('click', function() {
    event.preventDefault(); // 폼 제출 방지
    const dayCardsContainer = document.getElementById('dayCardsContainer');
    
    // 현재 존재하는 day-card의 개수를 기반으로 새로운 ID 생성
    const dayCount = document.querySelectorAll('.day-card').length + 1; 
    const newDayId = 'day' + dayCount; // 새로운 day ID 생성

    // 새로운 카드 div 생성
    const newDayCard = document.createElement('div');
    newDayCard.classList.add('day-card');
    newDayCard.id = newDayId; // 고유한 ID 설정

	 // 새로운 카드의 내부 HTML 설정 (백틱으로 감싸서 처리)
    newDayCard.innerHTML = `
   	<div class="day-header">
       	<h3>${newDayId.toUpperCase()}</h3>
       	<button class="delete-btn" onclick="deleteDayCard(this)">🗑</button>
   	</div>
   	<div class="day-content">
       	<button class="add-schedule-btn" id="add-schedule-${newDayId}">📅 일정 추가</button>
   	</div>
   	`;
	    

    // 컨테이너에 새로운 카드 추가 (추가 버튼 위에)
    dayCardsContainer.insertBefore(newDayCard, document.getElementById('addDayBtn'));

    // 새로 추가된 day에 이벤트 리스너 추가** (우측에 검색 창 안나타나게)
    const newDayHeader = newDayCard.querySelector('.day-header h3');
    
    newDayHeader.addEventListener('click', () => {
        loadDayPlaces(newDayId);  // 검색 창을 띄우지 않고 해당 DAY의 장소만 불러오기
        console.log("Loaded places for:", newDayId);  // dayId가 올바르게 설정되었는지 확인
    });
    
    // **새로 추가된 일정 추가 버튼에 이벤트 리스너 추가**
    const addScheduleBtn = newDayCard.querySelector(`#add-schedule-${newDayId}`);
    addScheduleBtn.addEventListener('click', () => {
        openPlaceSearch(newDayId);  // 해당 dayId에 맞춰 장소 검색 창 열기
    });
    
    // 카드 추가 후 DAY 번호 업데이트
    updateDayHeaders();
    
    // 새로 생성된 카드가 보이도록 스크롤 이동
    dayCardsContainer.scrollLeft = dayCardsContainer.scrollWidth;

});

// 카드 삭제 함수
function deleteDayCard(button) {
    const card = button.closest('.day-card');
    card.remove(); // 선택한 카드 삭제
    
    // 삭제 후 DAY 번호 재조정
    updateDayHeaders();
}

</script>

<script>
function scrollLeftContent() {
    const container = document.getElementById('dayCardsContainer');
    const cardWidth = container.querySelector('.day-card').offsetWidth; // 카드 하나의 너비 계산

    if (container.scrollLeft > 0) {
        container.scrollBy({
            left: -cardWidth, // 왼쪽으로 카드 하나만큼 이동
            behavior: 'smooth' // 부드러운 스크롤
        });
    }
}

function scrollRightContent() {
    const container = document.getElementById('dayCardsContainer');
    const cardWidth = container.querySelector('.day-card').offsetWidth; // 카드 하나의 너비 계산
    const maxScrollLeft = container.scrollWidth - container.clientWidth; // 최대 스크롤 범위

    if (container.scrollLeft < maxScrollLeft) {
        container.scrollBy({
            left: cardWidth, // 오른쪽으로 카드 하나만큼 이동
            behavior: 'smooth' // 부드러운 스크롤
        });
    }
}
</script>

<script>

const dayCardsContainer = document.querySelector('#dayCardsContainer');
let isDown = false; // 마우스가 눌린 상태인지 확인하는 변수
let startX; // 마우스가 눌린 시작 위치
let scrollLeft; // 기존의 스크롤 위치

dayCardsContainer.addEventListener('mousedown', (e) => {
    isDown = true;
    startX = e.pageX - dayCardsContainer.offsetLeft; // 마우스 시작 좌표
    scrollLeft = dayCardsContainer.scrollLeft; // 스크롤 시작 위치 저장
});

dayCardsContainer.addEventListener('mouseleave', () => {
    isDown = false; // 마우스가 영역을 벗어나면 드래그 중지
});

dayCardsContainer.addEventListener('mouseup', () => {
    isDown = false; // 마우스를 떼면 드래그 중지
});

dayCardsContainer.addEventListener('mousemove', (e) => {
    if (!isDown) return; // 마우스가 눌린 상태가 아니면 함수 종료
    e.preventDefault(); // 기본 동작 방지
    const x = e.pageX - dayCardsContainer.offsetLeft; // 현재 마우스 좌표
    const walk = x - startX; // 마우스 시작 좌표와 현재 좌표의 차이만큼 스크롤 이동
    dayCardsContainer.scrollLeft = scrollLeft - walk; // 스크롤 이동
});


</script>

<script>

$(document).ready(function() {
    $('.t_calendar').on('click', function() {
        // Date Range Picker가 연결된 input을 클릭
        $('.date-picker').click();
    });
    // Date Range Picker 초기화
    $('.date-picker').daterangepicker({
        locale: {
            format: 'YYYY-MM-DD',  // 날짜 형식
            separator: ' - ',      // 시작/종료 날짜 구분자
            applyLabel: '확인',     // 확인 버튼 텍스트
            cancelLabel: '취소',    // 취소 버튼 텍스트
            fromLabel: '시작',
            toLabel: '종료',
            daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            firstDay: 1  // 월요일 시작
        },
        startDate: moment().startOf('day'),  // 기본 시작 날짜
        endDate: moment().add(3, 'days')     // 기본 종료 날짜
    }, function(start, end, label) {
        // 선택한 날짜가 바뀔 때마다 input에 표시
        $('.date-picker').val(start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD'));
    });
});

//일정 저장하기 전에 각 day의 정보를 hidden input으로 추가
function prepareScheduleData() {
    const title = document.getElementById('titleInput').value;
    const dateRange = document.getElementById('dateInput').value.split(' - ');

    const period_start = dateRange[0];
    const period_end = dateRange[1];

    const hiddenFieldsContainer = document.getElementById('hiddenFieldsContainer');
    hiddenFieldsContainer.innerHTML = ''; // 이전 데이터를 초기화

    // period_start와 period_end를 hidden 필드로 추가
    const periodStartInput = document.createElement('input');
    periodStartInput.setAttribute('type', 'hidden');
    periodStartInput.setAttribute('name', 'period_start');
    periodStartInput.setAttribute('value', period_start);


    const periodEndInput = document.createElement('input');
    periodEndInput.setAttribute('type', 'hidden');
    periodEndInput.setAttribute('name', 'period_end');
    periodEndInput.setAttribute('value', period_end);

    // hiddenFieldsContainer에 추가
    hiddenFieldsContainer.appendChild(periodStartInput);
    hiddenFieldsContainer.appendChild(periodEndInput);


    // 도시 이름을 hidden 필드로 추가 (현재 선택된 도시 이름)
    if (currentCityName) {
        const cityNameInput = document.createElement('input');
        cityNameInput.setAttribute('type', 'hidden');
        cityNameInput.setAttribute('name', 'city_names');
        cityNameInput.setAttribute('value', currentCityName);

        hiddenFieldsContainer.appendChild(cityNameInput);
    }

    // selectedPlacesPerDay 객체에 있는 데이터를 hidden 필드로 추가
    Object.keys(selectedPlacesPerDay).forEach((day, index) => {
        const places = selectedPlacesPerDay[day];

        if (places && places.length > 0) {
            places.forEach((place, placeIndex) => {
                const dayNumber = day.replace('day', '');  // 'day1' -> '1'로 변환

            	
                // lat와 lng 좌표를 hidden 필드로 추가
                const latInput = document.createElement('input');
                latInput.setAttribute('type', 'hidden');
                latInput.setAttribute('name', 'place_latitudes[]');
                latInput.setAttribute('value', place.lat);

                const lngInput = document.createElement('input');
                lngInput.setAttribute('type', 'hidden');
                lngInput.setAttribute('name', 'place_longitudes[]');
                lngInput.setAttribute('value', place.lng);
                
                // day 입력 필드 생성
                const dayInput = document.createElement('input');
                dayInput.setAttribute('type', 'hidden');
                dayInput.setAttribute('name', 'days[]');
                dayInput.setAttribute('value', dayNumber);  // 변환된 숫자 값 사용

                // city_names 입력 필드 생성
                const cityInput = document.createElement('input');
                cityInput.setAttribute('type', 'hidden');
                cityInput.setAttribute('name', 'city_names[]');
                cityInput.setAttribute('value', currentCityName);

                // label_numbers 입력 필드 생성
                const labelInput = document.createElement('input');
                labelInput.setAttribute('type', 'hidden');
                labelInput.setAttribute('name', 'label_numbers[]');
                labelInput.setAttribute('value', placeIndex + 1);

                // place_names 입력 필드 생성
                const placeNameInput = document.createElement('input');
                placeNameInput.setAttribute('type', 'hidden');
                placeNameInput.setAttribute('name', 'place_names[]');
                placeNameInput.setAttribute('value', place.name);

                // place_addresses 입력 필드 생성
                const placeAddressInput = document.createElement('input');
                placeAddressInput.setAttribute('type', 'hidden');
                placeAddressInput.setAttribute('name', 'place_addresses[]');
                placeAddressInput.setAttribute('value', place.vicinity);
                


                // hiddenFieldsContainer에 추가
                hiddenFieldsContainer.appendChild(dayInput);
                hiddenFieldsContainer.appendChild(cityInput);
                hiddenFieldsContainer.appendChild(labelInput);
                hiddenFieldsContainer.appendChild(placeNameInput);
                hiddenFieldsContainer.appendChild(placeAddressInput);
                hiddenFieldsContainer.appendChild(latInput);
                hiddenFieldsContainer.appendChild(lngInput);
                
            });
        }
    });

}
</script>

<script>

$(document).ready(function() {
    // 각 day-header에 클릭 이벤트를 추가하여 해당 DAY의 장소 불러오기
    document.querySelectorAll('.day-header h3').forEach(header => {
        const dayId = header.parentElement.parentElement.id;  // 각 day-card의 ID가 dayId로 설정되어 있음
        header.addEventListener('click', () => {
            loadDayPlaces(dayId);  // 팝업 없이 장소만 불러오는 함수
        });
    });
});

// 팝업을 열지 않고 저장된 장소와 마커만 복원하는 함수
function loadDayPlaces(dayId) {
    currentDay = dayId;  // 현재 선택된 DAY 설정
    clearSelectedPlaces();  // 기존 선택된 장소 초기화

    // 해당 DAY에 저장된 장소를 복원
    if (selectedPlacesPerDay[dayId] && selectedPlacesPerDay[dayId].length > 0) {
        selectedPlacesPerDay[dayId].forEach((place, index) => {
            selectPlaceOnMap(place, index);  // 마커 복원 및 지도에 표시
        });
    }
}



</script>



</body>

</html>
