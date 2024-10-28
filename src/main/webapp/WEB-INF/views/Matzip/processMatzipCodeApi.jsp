<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URL, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ page import="java.io.IOException, java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import="com.human.web.vo.MatzipVO" %>


<%
    String apiKey = "H3jsa9rm1ozEAimhfIyY4KIYCVOrIyBCMQfu53d0onrMzu4frWlL4EnQz77x9ccS";
    String apiUrl = "https://seoul.openapi.redtable.global/api/rstr";
    String restaurantIdsParam = request.getParameter("restaurantIds");
    String restaurantNamesParam = request.getParameter("restaurantNames");

    List<MatzipVO> restaurantList = new ArrayList<>();

    if (restaurantIdsParam != null && !restaurantIdsParam.isEmpty() && restaurantNamesParam != null && !restaurantNamesParam.isEmpty()) {
        String[] restaurantIds = restaurantIdsParam.split(",");
        String[] restaurantNames = restaurantNamesParam.split(",");

        for (int j = 0; j < restaurantIds.length; j++) {
            String id = restaurantIds[j].trim();
            String name = restaurantNames[j].trim();
            boolean found = false;
            int pageNo = 1;

            while (!found) {
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

                        for (int i = 0; i < bodyArray.length(); i++) {
                            JSONObject item = bodyArray.getJSONObject(i);
                            String rstrId = item.optString("RSTR_ID");
                            String rstrNm = item.optString("RSTR_NM");

                            if (rstrId.equals(id) && rstrNm.equals(name)) {
                                MatzipVO restaurant = new MatzipVO();
                                restaurant.setId(rstrId);
                                restaurant.setTitle(rstrNm);
                                restaurant.setAddr1(item.optString("RSTR_RDNMADR", "정보 없음"));
                                restaurant.setOverview(item.optString("RSTR_INTRCN_CONT", "정보 없음"));
                                restaurant.setMapx(Double.parseDouble(item.optString("RSTR_LO", "0.0")));
                                restaurant.setMapy(Double.parseDouble(item.optString("RSTR_LA", "0.0")));
                                restaurant.setTel(item.optString("RSTR_TELNO", "정보 없음"));

                                restaurantList.add(restaurant);
                                found = true;
                                break;
                            }
                        }
                    }

                    if (!found) {
                        pageNo++;
                        if (pageNo > 1000) break;
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
    session.setAttribute("restaurantList", restaurantList);
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

        <!-- 폼 시작: 히든 필드로 선택된 ID를 전송 -->
         <div class="search-detail-container">
            <h2>음식점 정보 저장하기</h2>
            <form action="${pageContext.request.contextPath}/Matzip/inputMatzipDB" method="post">
                <input type="hidden" id="contentIds" name="selectedContentIds" placeholder="체크된 음식점 ID가 여기에 표시됩니다." required>
                <button type="submit">저장하기</button>
                <label>
                    <input type="checkbox" id="selectAllCheckbox" onclick="selectAllContentIds()"> 전체 선택
                </label>
            </form>
        </div>

        <!-- JSTL을 사용하여 데이터를 출력 -->
        <c:if test="${not empty restaurantList}">
            <form id="contentForm">
            <ul>
                <c:forEach var="restaurant" items="${restaurantList}">
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
        const checkboxes = document.querySelectorAll('.content-checkbox:checked');
        const contentIds = Array.from(checkboxes).map(cb => cb.value);
        
        // 체크된 ID들만 쉼표로 구분하여 히든 필드에 추가
        document.getElementById('contentIds').value = contentIds.join(',');
    }

    function selectAllContentIds() {
        const selectAll = document.getElementById('selectAllCheckbox');
        const checkboxes = document.querySelectorAll('.content-checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAll.checked;
        });
        updateContentIds();  // 전체 선택/해제 후 업데이트
    }

    function goBack() {
        window.history.back();
    }
    
</script>
</body>
</html>

