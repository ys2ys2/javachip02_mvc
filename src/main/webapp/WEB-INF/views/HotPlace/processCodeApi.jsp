<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URL, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ page import="java.io.IOException, java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import="java.util.Random" %>

<%
            // 사용자 입력값 가져오기
            String regionCode = request.getParameter("regionCode");
			

            // 공공데이터 API 호출 설정
            String apiKey = "rBOARBGR6WewzR%2BzYF%2BkQmTdL%2FuXaOHo8Xi8oSkMFzA%2F7fiYa80eViuXxb9mLDalaBCEyQPIIt3abBnIMVwU0Q%3D%3D";
            String apiUrl = "http://apis.data.go.kr/B551011/KorService1/areaBasedList1";
            
            // 랜덤 페이지 번호 생성 (1부터 10까지 숫자)
            Random random = new Random();
            int randomPage = random.nextInt(20) + 5;
            
            
            String params = "?serviceKey=" + apiKey
                          + "&MobileOS=ETC"
                          + "&MobileApp=APP"
                          + "&_type=json" // json 타입으로 받기
                          + "&arrange=O" // 정렬구분 (A=제목순, C=수정일순, D=생성일순) 대표이미지가 반드시 있는 정렬 (O=제목순, Q=수정일순, R=생성일순)
                          + "&contentTypeId=12" // 조회 타입 (관광지)
                          + "&numOfRows=10" // 한 번에 조회할 개수
                          + "&numOfRows=10" // 한 번에 조회할 개수
                          + "&areaCode=" + regionCode
                          + "&pageNo=" + randomPage; // 페이지 번호 랜덤

            try {
                StringBuilder urlBuilder = new StringBuilder(apiUrl);
                urlBuilder.append(params);

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
                // JSON 파싱 전에 응답이 유효한 JSON인지 확인
                if (jsonResponse.startsWith("{")) {
                    // JSON 파싱
                    JSONObject jsonObject = new JSONObject(jsonResponse);
                    if (jsonObject.has("response")) { // "response" 객체가 존재하는지 확인
                        JSONObject responseObj = jsonObject.getJSONObject("response");

                        if (responseObj.has("body")) { // "body" 객체가 존재하는지 확인
                            JSONObject responseBody = responseObj.getJSONObject("body");

                            if (responseBody.has("items") && !responseBody.isNull("items")) {
                                JSONArray itemsArray = responseBody.getJSONObject("items").optJSONArray("item");

                                if (itemsArray != null && itemsArray.length() > 0) {
                                    List<Map<String, String>> itemList = new ArrayList<>();

                                    for (int i = 0; i < itemsArray.length(); i++) {
                                        JSONObject item = itemsArray.getJSONObject(i);
                                        Map<String, String> itemData = new HashMap<>();
                                        itemData.put("title", item.optString("title", "정보 없음"));	// 제목
                                        itemData.put("addr1", item.optString("addr1", "정보 없음"));	// 주소
                                        itemData.put("areacode", item.optString("areacode", "정보 없음"));	// 지역 코드
                                        itemData.put("contentid", item.optString("contentid", "정보 없음"));	// 콘텐츠ID
                                        itemData.put("firstimage", item.optString("firstimage", "정보 없음")); // 이미지원본
                                        

                                        itemList.add(itemData);
                                    }

                                    // 데이터를 request에 저장하여 JSP에서 사용할 수 있게 함
                                    request.setAttribute("items", itemList);
                                }
                            }
                        }
                    }
                } else {
                    request.setAttribute("errorMessage", "API 응답이 유효한 JSON 형식이 아닙니다. API 키가 유효하지 않거나 요청에 문제가 있을 수 있습니다.");
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
    <title>공공데이터 API 결과</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/processCodeApi.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/processCodeApi.css">
    
</head>
<body>
    <div class="container">
    
        <h1>공공데이터 API 조회 결과</h1> 
    	<button class="back-button" onclick="goBack()">뒤로가기</button>
        <!-- 콘텐츠 ID로 상세정보 검색하기 입력 폼 추가 -->
        <div class="search-detail-container">
            <h2>콘텐츠 ID로 상세정보 검색하기</h2>
            <form action="${pageContext.request.contextPath}/HotPlace/processDetailApi" method="post">
                <label class="searchContentId" for="contentIds">콘텐츠 ID:</label>
                <input type="text" id="contentIds" name="contentIds" placeholder="체크된 컨텐츠 ID가 여기에 표시됩니다." required>
                <button type="submit">상세정보 검색</button>
                <label>
    				<input type="checkbox" id="selectAllCheckbox" onclick="selectAllContentIds()"> 전체 선택
				</label>
            </form>

        </div>

        

        <!-- JSTL을 사용하여 데이터를 출력 -->
        <c:if test="${not empty items}">
            <form id="contentForm">
            <ul>
                <c:forEach var="item" items="${items}">
                    <li>
                        <p><strong>제목:</strong> ${item.title}</p>
                        <p><strong>주소:</strong> ${item.addr1}</p>
                        <p><strong>지역 코드:</strong> ${item.areacode}</p>
                        <strong>콘텐츠 ID:</strong> 
                        <label class="check">
                        ${item.contentid}
                        <input type="checkbox" class="content-checkbox" value="${item.contentid}" onclick="updateContentIds()">
                        </label class="check">
                        <p>이미지:
                            <c:choose>
                                <c:when test="${item.firstimage != '정보 없음'}">
                                    <img src="${item.firstimage}" alt="이미지"; ">
                                </c:when>
                                <c:otherwise>
                                    ${item.firstimage}
                                </c:otherwise>
                            </c:choose>
                        </p>
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
            // 모든 체크된 체크박스들을 선택
            const checkboxes = document.querySelectorAll('.content-checkbox:checked');
            const contentIds = Array.from(checkboxes).map(cb => cb.value);
    
            // 쉼표로 구분된 콘텐츠 ID 문자열
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
