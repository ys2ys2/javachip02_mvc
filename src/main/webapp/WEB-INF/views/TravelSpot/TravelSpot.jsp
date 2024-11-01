<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URL, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ page import="java.io.IOException, java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>

<%
    // 전달받은 contentTypeId 값이 있으면 사용, 없으면 기본값으로 설정
    String contentTypeId = request.getParameter("contentTypeId") != null ? request.getParameter("contentTypeId") : "12";
    String apiKey = "rBOARBGR6WewzR+zYF+kQmTdL/uXaOHo8Xi8oSkMFzA/7fiYa80eViuXxb9mLDalaBCEyQPIIt3abBnIMVwU0Q==";
    String apiUrl = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1";
    String regionCode = request.getParameter("regionCode") != null ? request.getParameter("regionCode") : "1";
    
    int randomPageNo = (int)(Math.random() * 20) + 1;

    
    String params = "?serviceKey=" + java.net.URLEncoder.encode(apiKey, "UTF-8")
                  + "&MobileOS=ETC"
                  + "&MobileApp=APP"
                  + "&_type=json"
                  + "&arrange=O"
                  + "&contentTypeId=" + contentTypeId
                  + "&areaCode=" + regionCode
                  + "&numOfRows=10"
                  + "&pageNo=" + randomPageNo; // 랜덤 페이지 번호 적용
    
    List<Map<String, String>> places = new ArrayList<>();
    
    try {
        // API 요청 보내기
        URL url = new URL(apiUrl + params);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");

        int responseCode = conn.getResponseCode();
        BufferedReader rd;

        if (responseCode >= 200 && responseCode <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();

        // JSON 파싱 및 리스트에 추가
        String jsonResponse = sb.toString();
        if (jsonResponse.startsWith("{")) {
            JSONObject jsonObject = new JSONObject(jsonResponse);
            JSONArray items = jsonObject.getJSONObject("response").getJSONObject("body")
                                        .getJSONObject("items").getJSONArray("item");

            for (int i = 0; i < items.length(); i++) {
                JSONObject item = items.getJSONObject(i);
                Map<String, String> place = new HashMap<>();
                place.put("title", item.optString("title", "정보 없음"));
                place.put("addr1", item.optString("addr1", "정보 없음"));
                place.put("firstimage", item.optString("firstimage", ""));
                place.put("mapx", item.optString("mapx", "0"));
                place.put("mapy", item.optString("mapy", "0"));
                places.add(place);
            }
        }
    } catch (IOException e) {
        e.printStackTrace();
    }

    request.setAttribute("places", places);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여 행 뽈 뽈</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="${pageContext.request.contextPath}/resources/css/TravelSpot.css" rel="stylesheet" type="text/css">

    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAiIs-_C5RuOG0OQB9PNf2bTZPXgb4MMeo&callback=initMap"></script>
</head>

<body>
<jsp:include page="/WEB-INF/views/Components/header.jsp" />

<main>
    <div class="content-container">
        <section class="map-and-places">
            <div class="map-container">
                <div id="map"></div>
            </div>
            <div class="places-list">
			<h3>
			    <!-- 각 링크 클릭 시 contentTypeId를 전달하여 새 페이지를 요청 -->
			    <a href="javascript:void(0);" onclick="setCategory('nature')">#자연 관광지</a>
			    <a href="javascript:void(0);" onclick="setCategory('culture')">#문화탐방</a>
			    <a href="javascript:void(0);" onclick="setCategory('activity')">#액티비티</a>
			</h3>
                <ul id="places-list">
                    <c:forEach var="place" items="${places}">
                        <li>
                            <img src="${place.firstimage}" alt="${place.title}">
                            <p>${place.title}</p>
                            <p>${place.addr1}</p>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </section>
    </div>
</main>

<!-- footer -->
<jsp:include page="/WEB-INF/views/Components/footer.jsp" />

  <!-- Google Maps 및 JavaScript -->
<script>
    let map;
    let markers = [];

    function initMap() {
        const mapOptions = {
            center: new google.maps.LatLng(37.6, 127.2),
            zoom: 8
        };
        map = new google.maps.Map(document.getElementById("map"), mapOptions);

        // JSP에서 생성한 JSON 데이터를 JavaScript 객체로 변환
        const places = JSON.parse('<%= new org.json.JSONArray(places).toString() %>');
        displayPlacesOnMap(places);
    }

    function setCategory(category) {
        // 각 카테고리에 대한 고정된 contentTypeId 값 지정
        let contentTypeId;
        if (category === 'nature') {
            contentTypeId = 12; // 자연 관광지
        } else if (category === 'culture') {
            contentTypeId = 14; // 문화탐방
        } else if (category === 'activity') {
            contentTypeId = 28; // 액티비티
        }
        console.log("Selected contentTypeId:", contentTypeId);
        
        // 1부터 10 사이의 랜덤 페이지 번호 생성
        const randomPageNo = Math.floor(Math.random() * 10) + 1;

        const apiUrl = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1"
	        + "?serviceKey=rBOARBGR6WewzR%2BzYF%2BkQmTdL%2FuXaOHo8Xi8oSkMFzA%2F7fiYa80eViuXxb9mLDalaBCEyQPIIt3abBnIMVwU0Q%3D%3D"
	        + "&MobileOS=ETC"
	        + "&MobileApp=APP"
	        + "&_type=json"
	        + "&arrange=O"
	        + "&contentTypeId=" + contentTypeId
	        + "&areaCode=1"
	        + "&numOfRows=10"
	        + "&pageNo=" + randomPageNo;
        
	    console.log("Requesting URL:", apiUrl);

        // Fetch를 사용하여 API 호출
        fetch(apiUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Network response was not ok " + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                const places = data.response.body.items.item || [];
                displayPlacesOnMap(places);
                displayPlacesList(places);
            })
            .catch(error => console.error('Error fetching data:', error));
    }

    function displayPlacesOnMap(places) {
        markers.forEach(marker => marker.setMap(null));
        markers = [];

        places.forEach(place => {
            if (place.mapy && place.mapx) {
                const marker = new google.maps.Marker({
                    position: new google.maps.LatLng(parseFloat(place.mapy), parseFloat(place.mapx)),
                    map: map,
                    title: place.title
                });

                markers.push(marker);
            }
        });
    }

    function displayPlacesList(places) {
        const placesList = document.getElementById("places-list");
        placesList.innerHTML = '';

        places.forEach(place => {
            const listItem = document.createElement('li');
            listItem.innerHTML = 
                '<img src="' + (place.firstimage || '/path/to/default/image.jpg') + '" alt="' + place.title + '">' +
                '<p>' + place.title + '</p>' +
                '<p>' + place.addr1 + '</p>';
                
            placesList.appendChild(listItem);
        });
    }
    
    
</script>
</body>
</html>
