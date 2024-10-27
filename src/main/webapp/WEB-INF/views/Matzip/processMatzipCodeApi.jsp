<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URL, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ page import="java.io.IOException, java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>

<%
    String apiKey = "H3jsa9rm1ozEAimhfIyY4KIYCVOrIyBCMQfu53d0onrMzu4frWlL4EnQz77x9ccS";
    String apiUrl = "https://seoul.openapi.redtable.global/api/rstr";
    String restaurantIdsParam = request.getParameter("restaurantIds"); // 사용자가 입력한 음식점 ID
    String restaurantNamesParam = request.getParameter("restaurantNames"); // 사용자가 입력한 음식점 이름


    List<Map<String, String>> restaurantList = new ArrayList<>();

    if (restaurantIdsParam != null && !restaurantIdsParam.isEmpty() && restaurantNamesParam != null && !restaurantNamesParam.isEmpty()) {
        String[] restaurantIds = restaurantIdsParam.split(",");
        String[] restaurantNames = restaurantNamesParam.split(",");

        for (int j = 0; j < restaurantIds.length; j++) { // 각 ID와 이름 쌍에 대해 반복
            String id = restaurantIds[j].trim();
            String name = restaurantNames[j].trim();
            boolean found = false;
            int pageNo = 1;

            while (!found) { // 원하는 데이터를 찾을 때까지 반복
                try {
                    URL url = new URL(apiUrl + "?serviceKey=" + apiKey + "&pageNo=" + pageNo + "&numOfRows=1000");
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("GET");

                    int responseCode = conn.getResponseCode();
                    BufferedReader rd = new BufferedReader(new InputStreamReader(
                        (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"
                    ));
                    
                    StringBuilder sb = new StringBuilder();
                    String line;
                    while ((line = rd.readLine()) != null) sb.append(line);
                    rd.close();

                    JSONObject jsonObject = new JSONObject(sb.toString());
                    if (jsonObject.has("body")) {
                        JSONArray bodyArray = jsonObject.getJSONArray("body");

                        // 각 항목을 확인하며 원하는 데이터가 있는지 필터링
                        for (int i = 0; i < bodyArray.length(); i++) {
                            JSONObject item = bodyArray.getJSONObject(i);
                            String rstrId = item.optString("RSTR_ID");
                            String rstrNm = item.optString("RSTR_NM");

                            // 입력받은 ID와 이름이 일치하는지 확인
                            if (rstrId.equals(id) && rstrNm.equals(name)) {
                                Map<String, String> restaurant = new HashMap<>();
                                restaurant.put("title", rstrNm);
                                restaurant.put("addr1", item.optString("RSTR_RDNMADR", "정보 없음"));
                                restaurant.put("id", rstrId);
                                restaurant.put("overview", item.optString("RSTR_INTRCN_CONT", "정보 없음"));
                                restaurant.put("mapx", item.optString("RSTR_LO", "정보 없음"));
                                restaurant.put("mapy", item.optString("RSTR_LA", "정보 없음"));
                                restaurant.put("tel", item.optString("RSTR_TELNO", "정보 없음"));
                                restaurantList.add(restaurant);
                                found = true; // 원하는 데이터를 찾으면 현재 while 반복 종료
                                break;
                            }
                        }
                    }
                    
                    if (!found) {
                        pageNo++; // 다음 페이지로 이동
                        if (pageNo > 1000) break; // 최대 페이지 수를 제한하여 무한 반복 방지
                    }
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "API 호출 오류: " + e.getMessage());
                    break;
                }
            }
        }
    }

    request.setAttribute("restaurants", restaurantList);
%>




<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공공데이터 API 결과</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/processCodeApi.css">
    
</head>
<body>
    <div class="container">
    
        <h1>공공데이터 API 조회 결과</h1> 
    	<button class="back-button" onclick="goBack()">뒤로가기</button>
        <!-- 콘텐츠 ID로 상세정보 검색하기 입력 폼 추가 -->
        <div class="search-detail-container">
            <h2>음식점 ID로 상세정보 검색하기</h2>
            <form action="${pageContext.request.contextPath}/Matzip/processMatzipDetailApi" method="post">
                <label class="searchContentId" for="contentIds">음식점 ID:</label>
                <input type="text" id="contentIds" name="contentIds" placeholder="체크된 음식점 ID가 여기에 표시됩니다." required>
                <button type="submit">상세정보 검색</button>
                <label>
    				<input type="checkbox" id="selectAllCheckbox" onclick="selectAllContentIds()"> 전체 선택
				</label>
            </form>

        </div>

        

        <!-- JSTL을 사용하여 데이터를 출력 -->
        <c:if test="${not empty restaurants}">
            <form id="contentForm">
            <ul>
                <c:forEach var="restaurant" items="${restaurants}">
                    <li>
                        <label class="check">
                        <p>음식점ID: ${restaurant.id}
                        <input type="checkbox" class="content-checkbox" value="${restaurant.id}" onclick="updateContentIds()">
                        </p></label class="check">
                        <p>이름: ${restaurant.title}</p>
                        <p>주소: ${restaurant.addr1}</p>
					    <p>소개: ${restaurant.overview}</p>
					    <p>경도: ${restaurant.mapx}</p>
					    <p>위도: ${restaurant.mapy}</p>
					    <p>전화번호: ${restaurant.tel}</p>
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
    function updateContentIds() {
        // 체크된 모든 체크박스들을 선택
        const checkboxes = document.querySelectorAll('.content-checkbox:checked');
        const contentIds = Array.from(checkboxes).map(cb => cb.value);
        
        console.log("Selected IDs:", contentIds.join(','));
        
        // 체크된 ID들만 쉼표로 구분하여 contentIds에 추가
        document.getElementById('contentIds').value = contentIds.join(',');
    }

    function selectAllContentIds() {
        const selectAll = document.getElementById('selectAllCheckbox');
        const checkboxes = document.querySelectorAll('.content-checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAll.checked;
        });
        updateContentIds();
    }

    function goBack() {
        window.history.back();
    }
</script>
    

</body>
</html>
