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
    const dayCardsContainer = document.getElementById('dayCardsContainer');
    
    // 새로운 카드 div 생성
    const newDayCard = document.createElement('div');
    newDayCard.classList.add('day-card');
    
   // 새로운 카드의 내부 HTML 설정
   newDayCard.innerHTML = '<div class="day-header">' +
    '<h3></h3>' +  // DAY 번호는 나중에 업데이트
    '<button class="delete-btn" onclick="deleteDayCard(this)">🗑</button>' +
    '</div>' + 
    '<div class="day-content">' + 
    '<button class="add-schedule-btn" onclick="openPlaceSearch(\'day\')">📅 일정 추가</button>' +
    '</div>';

    // 컨테이너에 새로운 카드 추가 (추가 버튼 위에)
    dayCardsContainer.insertBefore(newDayCard, document.getElementById('addDayBtn'));

    // 카드 추가 후 DAY 번호 업데이트
    updateDayHeaders();
});

// 카드 삭제 함수
function deleteDayCard(button) {
    const card = button.closest('.day-card');
    card.remove(); // 선택한 카드 삭제
    
    // 삭제 후 DAY 번호 재조정
    updateDayHeaders();
}



function scrollLeftContent() {
    const container = document.getElementById('dayCardsContainer');
    console.log("Current scrollLeft:", container.scrollLeft);

    if (container.scrollLeft > 0) {
        container.scrollBy({
            left: -300, // 왼쪽으로 300px 만큼 이동
            behavior: 'smooth' // 부드럽게 스크롤
        });
        console.log("After scrollLeft:", container.scrollLeft);
    } else {
        console.log("No space to scroll left.");
    }
}

function scrollRightContent() {
    const container = document.getElementById('dayCardsContainer');
    console.log("Current scrollLeft:", container.scrollLeft);

    container.scrollBy({
        left: 300, // 오른쪽으로 300px 만큼 이동
        behavior: 'smooth' // 부드럽게 스크롤
    });
    console.log("After scrollRight:", container.scrollLeft);
}
