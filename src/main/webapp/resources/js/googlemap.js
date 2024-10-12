// DB에 저장된 값으로 위경도 가져오기
// Google Maps API를 이용해 지도를 초기화하는 함수
window.initMap = function() {
        
        
    // mapx와 mapy 변수가 정의되어 있는지 확인
	    if (typeof mapx !== 'undefined' && typeof mapy !== 'undefined' && mapx && mapy) {
	        // 위도와 경도 설정
	        var latitude = parseFloat(mapy);
	        var longitude = parseFloat(mapx);

	        // 쉼표로 구분된 첫 번째 이미지 URL 가져오기
        	var firstImageUrl = firstimage.split(",")[0].trim();  // 첫 번째 이미지만 사용
	        

	        // 지도 초기화
	        var mapOptions = {
	            center: { lat: latitude, lng: longitude },
	            zoom: 16
	        };

	        var map = new google.maps.Map(document.getElementById('map'), mapOptions);

	        // 기본 빨간 마커 추가
	        var basicMarker = new google.maps.Marker({
	            position: { lat: latitude, lng: longitude },
	            map: map,
	            title: '선택된 장소'
	        });

	        // 커스텀 마커 추가
	        addCustomMarker(map, latitude, longitude, firstImageUrl);
	    } else {
	        console.error('위도와 경도 값이 없습니다. mapx, mapy값을 확인해주세요.');
	    }
	};

//위도,경도로 지도 표시 + imageUrl
function displayMap(latitude, longitude, imageUrl) {
    var mapOptions = {
        center: { lat: latitude, lng: longitude }, // 위도와 경도 값을 중심으로 설정
        zoom: 16 // 지도 확대 레벨 설정
    };

    // 'map' ID를 가진 요소에 지도를 삽입
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
	
	};
	
// 커스텀 마커를 추가하는 함수
function addCustomMarker(map, latitude, longitude, imageUrl) {
    // 커스텀 마커를 위한 HTML 엘리먼트 생성
    var markerDiv = document.createElement('div');
    markerDiv.className = 'custom-marker';

    // 마커 안에 들어갈 이미지 엘리먼트 생성
    var imgElement = document.createElement('img');
    imgElement.src = imageUrl;
    imgElement.className = 'marker-image';

    // 마커 이미지와 스타일링된 배경을 포함한 div에 추가
    markerDiv.appendChild(imgElement);

    // 지도에 커스텀 마커 오버레이 추가
    var customMarker = new google.maps.OverlayView();
    customMarker.onAdd = function() {
        var panes = this.getPanes();
        panes.overlayMouseTarget.appendChild(markerDiv);
    };
    customMarker.draw = function() {
        var position = this.getProjection().fromLatLngToDivPixel(new google.maps.LatLng(latitude, longitude));
        markerDiv.style.left = position.x + 'px';
        markerDiv.style.top = position.y + 'px';
    };
    customMarker.onRemove = function() {
        markerDiv.parentNode.removeChild(markerDiv);
    };
    customMarker.setMap(map);
}


