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

// 장소 목록 출력 함수
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

// 저장 버튼 누르면 day에 저장
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
                             '<div class="p_name">' + place.vicinity + '</div>';	// 장소 주소

        dayContent.appendChild(listItem); // DAY의 리스트에 추가
    });

    // 패널 닫기
    closePlaceSearch();
}

// 장소 검색 패널 열기 (DAY 진입 시)
function openPlaceSearch(dayId) {
    currentDay = dayId; // 선택된 DAY 기록 (예: 'day1', 'day2' 등)

    console.log("Current day:", currentDay); // dayId가 올바르게 전달되었는지 확인

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

// 선택된 장소 초기화 함수 (태그, 마커, 선 모두 초기화)
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

// 팝업을 열지 않고 저장된 장소와 마커만 복원하는 함수
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

        // 저장된 장소들 마커와 함께 복원
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
