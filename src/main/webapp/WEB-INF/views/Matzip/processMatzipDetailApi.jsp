<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URL, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ page import="java.io.IOException, java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>



<%
String apiKey = "H3jsa9rm1ozEAimhfIyY4KIYCVOrIyBCMQfu53d0onrMzu4frWlL4EnQz77x9ccS";
String apiUrl = "https://seoul.openapi.redtable.global/api/rstr";
String imgApiUrl = "https://seoul.openapi.redtable.global/api/rstr/img";
String params = "?serviceKey=" + apiKey + "&pageNo=1&numOfRows=30";

List<Map<String, Object>> restaurantList = new ArrayList<>();
Map<String, List<String>> imgUrlsMap = new HashMap<>(); // 각 ID에 대한 이미지 URL 리스트를 저장할 맵

try {
    // 음식점 기본 정보 조회
    URL url = new URL(apiUrl + params);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");

    BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = rd.readLine()) != null) sb.append(line);
    rd.close();

    JSONObject jsonObject = new JSONObject(sb.toString());
    if (jsonObject.has("body")) {
        JSONArray bodyArray = jsonObject.getJSONArray("body");
        for (int i = 0; i < Math.min(30, bodyArray.length()); i++) {
            JSONObject item = bodyArray.getJSONObject(i);
            String restaurantId = item.optString("RSTR_ID", "정보 없음");
            String title = item.optString("RSTR_NM", "정보 없음");

            // 각 식당의 ID에 대한 이미지 리스트 초기화
            imgUrlsMap.put(restaurantId, new ArrayList<>());  // 초기화가 필요함

            Map<String, Object> restaurant = new HashMap<>();
            restaurant.put("title", title);
            restaurant.put("addr1", item.optString("RSTR_RDNMADR", "정보 없음"));
            restaurant.put("id", restaurantId);
            restaurant.put("overview", item.optString("RSTR_INTRCN_CONT", "정보 없음"));
            restaurant.put("mapx", item.optString("RSTR_LO", "정보 없음"));
            restaurant.put("mapy", item.optString("RSTR_LA", "정보 없음"));
            restaurant.put("tel", item.optString("RSTR_TELNO", "정보 없음"));
            restaurantList.add(restaurant);  // restaurantList에 음식점 데이터 추가
        }
    }

    // 선택한 음식점 ID에 따라 이미지 조회
    String selectedIds = request.getParameter("contentIds");

    if (selectedIds != null) {
        String[] idsArray = selectedIds.split(",");
        for (String id : idsArray) {
            // restaurantList에서 id에 해당하는 title 찾기
            String title = "";
            for (Map<String, Object> restaurant : restaurantList) {
                if (restaurant.get("id").equals(id)) {
                    title = (String) restaurant.get("title");
                    break;
                }
            }

            URL imgUrl = new URL(imgApiUrl + "?serviceKey=" + apiKey + "&RSTR_ID=" + id + "&RSTR_NM=" + URLEncoder.encode(title, "UTF-8") + "&pageNo=1&numOfRows=30&totalCount=12352&resultCode=00&resultMsg=NORMAL_SERVICE");
            HttpURLConnection imgConn = (HttpURLConnection) imgUrl.openConnection();
            imgConn.setRequestMethod("GET");

            BufferedReader imgRd = new BufferedReader(new InputStreamReader(imgConn.getInputStream(), "UTF-8"));
            StringBuilder imgSb = new StringBuilder();
            while ((line = imgRd.readLine()) != null) imgSb.append(line);
            imgRd.close();

            JSONObject imgJson = new JSONObject(imgSb.toString());

            if (imgJson.has("body")) {
                JSONArray imgBodyArray = imgJson.getJSONArray("body");
                List<String> imageUrls = new ArrayList<>(); // 새로 이미지 리스트 생성
                for (int j = 0; j < Math.min(30, imgBodyArray.length()); j++) { // 최대 30개로 제한
                    JSONObject imgItem = imgBodyArray.getJSONObject(j);
                    String imageUrl = imgItem.optString("RSTR_IMG_URL", "이미지 없음");
                    imageUrls.add(imageUrl); // 현재 id에 맞는 이미지 URL 추가
                }
                imgUrlsMap.put(id, imageUrls); // imgUrlsMap에 현재 id의 이미지 리스트 설정
            }
        }
    }

    // imgUrlsMap에서 각 식당의 이미지 리스트를 restaurantList에 추가
    for (Map<String, Object> restaurant : restaurantList) {
        String restaurantId = (String) restaurant.get("id");
        restaurant.put("images", imgUrlsMap.getOrDefault(restaurantId, new ArrayList<>()));
    }

    request.setAttribute("restaurants", restaurantList);

} catch (Exception e) {
    e.printStackTrace();
    request.setAttribute("errorMessage", "API 호출 오류: " + e.getMessage());
}
%>








<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상세 정보 조회 결과</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/processDetailApi.css">
</head>
<body>
    <div class="container">
        <h1>상세 정보 조회 결과</h1>
        <button class="back-button" onclick="goBack()">뒤로가기</button>

        <div class="search-detail-container">
            <h2>DB에 저장하기</h2>
            <form action="${pageContext.request.contextPath}/HotPlace/inputDB" method="post">
                <label class="searchContentId" for="selectedContentIds">음식점 ID:</label>
                <input type="text" id="selectedContentIds" name="selectedContentIds" placeholder="체크된 음식점 ID가 여기에 표시됩니다." required>
                <button type="submit">DB에 저장</button>
                <label>
                    <input type="checkbox" id="selectAllCheckbox" onclick="toggleSelectAll(this)"> 전체 선택
                </label>
            </form>
        </div>

 <c:if test="${not empty restaurants}">
    <form id="detailForm">
        <ul>
            <c:forEach var="restaurant" items="${restaurants}">
                <li>
                    <label class="check">
                        DB에 저장: 
                        <input type="checkbox" class="detail-checkbox" value="${restaurant.id}" onclick="updateSelectedDetails()">
                    </label>
                    <p><strong>제목:</strong> ${restaurant.title}</p>
                    <p><strong>주소:</strong> ${restaurant.addr1}</p>
                    <p><strong>음식점 ID:</strong> ${restaurant.id}</p>
                    <p class="overview"><strong>설명</strong>: ${restaurant.overview}</p>
                    <p><strong>위도:</strong> ${restaurant.mapy}</p>
                    <p><strong>경도:</strong> ${restaurant.mapx}</p>
                    <p><strong>전화번호:</strong> ${restaurant.tel}</p>
                    <!-- 이미지 출력 부분 수정 -->
                        <div class="additional-images">
                            <c:forEach var="imgUrl" items="${restaurant.images}">
                                <span>
                                    <p>이미지:</p><img src="${imgUrl}" alt="음식점 이미지">
                                </span>
                            </c:forEach>
                        </div>
                	</li>
            </c:forEach>
        </ul>
    </form>
</c:if>

        <c:if test="${not empty errorMessage}">
            <p>${errorMessage}</p>
        </c:if>
    </div>
    
    
        <script>
            function goBack() {
                window.history.back();
            }

            function toggleSelectAll(source) {
                const checkboxes = document.querySelectorAll('.detail-checkbox');
                checkboxes.forEach(checkbox => checkbox.checked = source.checked);
                updateSelectedDetails();
            }

            function updateSelectedDetails() {
                const checkboxes = document.querySelectorAll('.detail-checkbox:checked');
                const contentIds = Array.from(checkboxes).map(cb => cb.value);
                document.getElementById('selectedContentIds').value = contentIds.join(',');
            }
        </script>
    
</body>
</html>
