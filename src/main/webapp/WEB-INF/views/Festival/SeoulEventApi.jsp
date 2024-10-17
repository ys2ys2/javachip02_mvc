<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URL, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ page import="java.io.IOException, java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>

<%
    // 사용자 입력값 가져오기
    String codeName = request.getParameter("codeName");
    String title = request.getParameter("title");
    String date = request.getParameter("date");

    // 공공데이터 API 호출 설정
    String apiKey = "796275674f676d6c383351444e4c70";
    String apiUrl = "http://openapi.seoul.go.kr:8088/" + apiKey + "/json/culturalEventInfo";
    String startIndex = "1";  // 데이터의 시작 위치
    String endIndex = "30";   // 데이터의 종료 위치 (한 페이지의 데이터 개수)

    // URL에 요청 파라미터 추가
    StringBuilder urlBuilder = new StringBuilder();
    urlBuilder.append(apiUrl)
              .append("/").append(startIndex)
              .append("/").append(endIndex)
              .append("?TYPE=json");

    // 선택적 파라미터 추가
    if (codeName != null && !codeName.isEmpty()) {
        urlBuilder.append("&CODENAME=").append(codeName);
    }
    if (title != null && !title.isEmpty()) {
        urlBuilder.append("&TITLE=").append(title);
    }
    if (date != null && !date.isEmpty()) {
        urlBuilder.append("&DATE=").append(date);
    }

    try {
        // API 요청 보내기
        URL url = new URL(urlBuilder.toString());
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

        // JSON 응답 출력 (디버깅용)
        String jsonResponse = sb.toString();

        if (jsonResponse.startsWith("{")) {
            JSONObject jsonObject = new JSONObject(jsonResponse);
            if (jsonObject.has("culturalEventInfo")) {
                JSONObject responseBody = jsonObject.getJSONObject("culturalEventInfo");

                if (responseBody.has("row") && !responseBody.isNull("row")) {
                    JSONArray itemsArray = responseBody.optJSONArray("row");

                    if (itemsArray != null && itemsArray.length() > 0) {
                        List<Map<String, String>> itemList = new ArrayList<>();

                        for (int i = 0; i < itemsArray.length(); i++) {
                            JSONObject item = itemsArray.getJSONObject(i);
                            Map<String, String> itemData = new HashMap<>();
                            itemData.put("title", item.optString("TITLE", "정보 없음"));       // 제목
                            itemData.put("codename", item.optString("CODENAME", "정보 없음")); // 분류
                            itemData.put("date", item.optString("DATE", "정보 없음"));         // 날짜/시간
                            itemData.put("place", item.optString("PLACE", "정보 없음"));       // 장소
                            itemData.put("orgname", item.optString("ORG_NAME", "정보 없음"));  // 주최 기관

                            itemList.add(itemData);
                        }

                        // 데이터를 request에 저장하여 JSP에서 사용할 수 있게 함
                        request.setAttribute("items", itemList);
                    }
                }
            }
        } else {
            request.setAttribute("errorMessage", "API 응답이 JSON 형식이 아닙니다.");
        }
    } catch (IOException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "API 호출 중 오류가 발생했습니다: " + e.getMessage());
    }
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서울 문화 행사 정보</title>

    <link rel="stylesheet" href="processCodeApi.css">
    
</head>
<body>
    <div class="container">
    
        <h1>서울 문화 행사 정보</h1>
    	<button class="back-button" onclick="goBack()">뒤로가기</button>
        
        <!-- 콘텐츠 ID로 상세정보 검색하기 입력 폼 -->
        <div class="search-detail-container">
            <h2>콘텐츠 ID로 상세정보 검색하기</h2>
            <form action="processDetailApi.jsp" method="post">
                <label for="contentIds">콘텐츠 ID:</label>
                <input type="text" id="contentIds" name="contentIds" placeholder="체크된 콘텐츠 ID가 여기에 표시됩니다." required>
                <button type="submit">상세정보 검색</button>
                <label>
                    <input type="checkbox" id="selectAllCheckbox" onclick="selectAllContentIds()"> 전체 선택
                </label>
            </form>
        </div>

        <!-- JSTL을 사용하여 API 데이터를 출력 -->
        <c:if test="${not empty items}">
            <form id="contentForm">
            <ul>
                <c:forEach var="item" items="${items}">
                    <li>
                        <p><strong>제목:</strong> ${item.atTitle}</p>
                        <p><strong>날짜/시간:</strong> ${item.atDateTime}</p>
                        <p><strong>장소:</strong> ${item.atPlace}</p>
                        <p><strong>기관명:</strong> ${item.atOrgName}</p>
                        <p><strong>이용 대상:</strong> ${item.atUseTrgt}</p>
                        <p><strong>이용 요금:</strong> ${item.atUseFee}</p>
                        <p><strong>출연자 정보:</strong> ${item.atPlayer}</p>
                        <p><strong>프로그램 소개:</strong> ${item.atProgram}</p>
                        <p><strong>홈페이지:</strong> <a href="${item.atOrgLink}" target="_blank">${item.atOrgLink}</a></p>
                        <p><strong>시작일:</strong> ${item.atStartDate}</p>
                        <p><strong>종료일:</strong> ${item.atEndDate}</p>
                        
                        <!-- 콘텐츠 ID 체크박스 -->
                        <label class="check">
                            콘텐츠 ID: ${item.id}
                            <input type="checkbox" class="content-checkbox" value="${item.id}" onclick="updateContentIds()">
                        </label>
                        
                        <!-- 이미지 출력 -->
                        <p>이미지:
                            <c:choose>
                                <c:when test="${item.atMainImg != null && item.atMainImg != ''}">
                                    <img src="${item.atMainImg}" alt="이미지" style="width: 100px; height: auto;">
                                </c:when>
                                <c:otherwise>
                                    이미지 없음
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </li>
                </c:forEach>
            </ul>
            </form>
        </c:if>

        <!-- 오류 메시지 출력 -->
        <c:if test="${not empty errorMessage}">
            <p>${errorMessage}</p>
        </c:if>

    </div>

    <script>
        function updateContentIds() {
            const checkboxes = document.querySelectorAll('.content-checkbox:checked');
            const contentIds = Array.from(checkboxes).map(cb => cb.value);
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
