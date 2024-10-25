<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URL, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ page import="java.io.IOException, java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>


<%
    String contentIds = request.getParameter("contentIds");
    List<Map<String, Object>> detailItemList = new ArrayList<>();

    if (contentIds == null || contentIds.isEmpty()) {
        request.setAttribute("errorMessage", "콘텐츠 ID를 입력해 주세요.");
    } else {
        String[] contentIdArray = contentIds.split(",");

        String apiKey = "rBOARBGR6WewzR%2BzYF%2BkQmTdL%2FuXaOHo8Xi8oSkMFzA%2F7fiYa80eViuXxb9mLDalaBCEyQPIIt3abBnIMVwU0Q%3D%3D";
        String apiUrl = "http://apis.data.go.kr/B551011/KorService1/detailCommon1";

        for (String contentId : contentIdArray) {
            contentId = contentId.trim();

            String params = "?serviceKey=" + apiKey
                            + "&MobileOS=ETC"
                            + "&MobileApp=APP"
                            + "&_type=json"
                            + "&contentId=" + contentId
                            + "&defaultYN=Y"
                            + "&firstImageYN=Y"
                            + "&addrinfoYN=Y"
                            + "&mapinfoYN=Y"
                            + "&areacodeYN=Y"
                            + "&overviewYN=Y";

            StringBuilder urlBuilder = new StringBuilder(apiUrl);
            urlBuilder.append(params);

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

                // JSON 파싱
                if (jsonResponse.startsWith("{")) {
                    JSONObject jsonObject = new JSONObject(jsonResponse);
                    if (jsonObject.has("response")) {
                        JSONObject responseObj = jsonObject.getJSONObject("response");

                        if (responseObj.has("body")) {
                            JSONObject responseBody = responseObj.getJSONObject("body");

                            if (responseBody.has("items") && !responseBody.isNull("items")) {
                                Object itemsObj = responseBody.get("items");

                                // items가 JSONObject일 때 처리
                                if (itemsObj instanceof JSONObject) {
                                    JSONObject itemsJSONObject = (JSONObject) itemsObj;
                                    JSONArray itemsArray = itemsJSONObject.optJSONArray("item");

                                    if (itemsArray != null && itemsArray.length() > 0) {
                                        for (int i = 0; i < itemsArray.length(); i++) {
                                            JSONObject item = itemsArray.getJSONObject(i);
                                            Map<String, Object> detailData = new HashMap<>();
                                            detailData.put("title", item.optString("title", "정보 없음"));
                                            detailData.put("overview", item.optString("overview", "정보 없음"));
                                            detailData.put("addr1", item.optString("addr1", "정보 없음"));
                                            detailData.put("mapx", item.optString("mapx", "정보 없음"));
                                            detailData.put("mapy", item.optString("mapy", "정보 없음"));
                                            detailData.put("firstimage", item.optString("firstimage", "정보 없음"));
                                            detailData.put("areacode", item.optString("areacode", "정보 없음"));
                                            detailData.put("contentid", item.optString("contentid", "정보 없음"));
                                            
                                            // 이미지 API 관련 데이터를 처리
                                            String imageApiUrl = "http://apis.data.go.kr/B551011/KorService1/detailImage1";
                                            String imageParams = "?serviceKey=" + apiKey
                                                                + "&MobileOS=ETC"
                                                                + "&MobileApp=APP"
                                                                + "&_type=json"
                                                                + "&contentId=" + contentId
                                                                + "&imageYN=Y"
                                                                + "&subImageYN=Y";

                                            StringBuilder imageUrlBuilder = new StringBuilder(imageApiUrl);
                                            imageUrlBuilder.append(imageParams);

                                            try {
                                                URL imageUrl = new URL(imageUrlBuilder.toString());
                                                HttpURLConnection imageConn = (HttpURLConnection) imageUrl.openConnection();
                                                imageConn.setRequestMethod("GET");
                                                imageConn.setRequestProperty("Content-type", "application/json");

                                                int imageResponseCode = imageConn.getResponseCode();
                                                BufferedReader imageRd;

                                                if (imageResponseCode >= 200 && imageResponseCode <= 300) {
                                                    imageRd = new BufferedReader(new InputStreamReader(imageConn.getInputStream(), "UTF-8"));
                                                } else {
                                                    imageRd = new BufferedReader(new InputStreamReader(imageConn.getErrorStream(), "UTF-8"));
                                                }

                                                StringBuilder imageSb = new StringBuilder();
                                                String imageLine;
                                                while ((imageLine = imageRd.readLine()) != null) {
                                                    imageSb.append(imageLine);
                                                }
                                                imageRd.close();
                                                imageConn.disconnect();

                                                // JSON 응답 출력 (디버깅용)
                                                String imageJsonResponse = imageSb.toString();

                                                // 이미지 JSON 파싱 (items가 JSONObject나 JSONArray 또는 String일 수 있음)
                                                if (imageJsonResponse.startsWith("{")) {
                                                    JSONObject imageJsonObject = new JSONObject(imageJsonResponse);
                                                    if (imageJsonObject.has("response")) {
                                                        JSONObject imageResponseObj = imageJsonObject.getJSONObject("response");
                                                        if (imageResponseObj.has("body")) {
                                                            JSONObject imageResponseBody = imageResponseObj.getJSONObject("body");
                                                            if (imageResponseBody.has("items") && !imageResponseBody.isNull("items")) {
                                                                Object imageItemsObj = imageResponseBody.get("items");
                                                                if (imageItemsObj instanceof JSONObject) {
                                                                    // items가 JSONObject일 경우 처리
                                                                    JSONObject imageItems = (JSONObject) imageItemsObj;
                                                                    JSONArray imageItemsArray = imageItems.optJSONArray("item");
                                                                    if (imageItemsArray != null) {
                                                                        List<Map<String, String>> images = new ArrayList<>();
                                                                        for (int j = 0; j < imageItemsArray.length(); j++) {
                                                                            JSONObject imageItem = imageItemsArray.getJSONObject(j);
                                                                            Map<String, String> imageData = new HashMap<>();
                                                                            imageData.put("originimgurl", imageItem.optString("originimgurl", "정보 없음"));
                                                                            imageData.put("smallimageurl", imageItem.optString("smallimageurl", "정보 없음"));
                                                                            images.add(imageData);
                                                                        }
                                                                        detailData.put("images", images);
                                                                    }
                                                                } else if (imageItemsObj instanceof JSONArray) {
                                                                    // items가 JSONArray일 경우 처리
                                                                    JSONArray imageItemsArray = (JSONArray) imageItemsObj;
                                                                    List<Map<String, String>> images = new ArrayList<>();
                                                                    for (int j = 0; j < imageItemsArray.length(); j++) {
                                                                        JSONObject imageItem = imageItemsArray.getJSONObject(j);
                                                                        Map<String, String> imageData = new HashMap<>();
                                                                        imageData.put("originimgurl", imageItem.optString("originimgurl", "정보 없음"));
                                                                        imageData.put("smallimageurl", imageItem.optString("smallimageurl", "정보 없음"));
                                                                        images.add(imageData);
                                                                    }
                                                                    detailData.put("images", images);
                                                                } else if (imageItemsObj instanceof String) {
                                                                    // items가 String일 경우 처리
                                                                    detailData.put("imagesString", (String) imageItemsObj);
                                                                }
                                                            }
                                                        }
                                                    }
                                                }

                                            } catch (IOException e) {
                                                e.printStackTrace();
                                                request.setAttribute("errorMessage", "이미지 API 호출 중 오류가 발생했습니다: " + e.getMessage());
                                            }

                                            detailItemList.add(detailData);
                                        }
                                    }
                                } else if (itemsObj instanceof JSONArray) {
                                    // items가 JSONArray일 경우 처리
                                    JSONArray itemsArray = (JSONArray) itemsObj;
                                    for (int i = 0; i < itemsArray.length(); i++) {
                                        JSONObject item = itemsArray.getJSONObject(i);
                                        Map<String, Object> detailData = new HashMap<>();
                                        detailData.put("title", item.optString("title", "정보 없음"));
                                        detailData.put("overview", item.optString("overview", "정보 없음"));
                                        detailData.put("addr1", item.optString("addr1", "정보 없음"));
                                        detailData.put("mapx", item.optString("mapx", "정보 없음"));
                                        detailData.put("mapy", item.optString("mapy", "정보 없음"));
                                        detailData.put("firstimage", item.optString("firstimage", "정보 없음"));
                                        detailData.put("areacode", item.optString("areacode", "정보 없음"));
                                        detailData.put("contentid", item.optString("contentid", "정보 없음"));

                                        detailItemList.add(detailData);
                                    }
                                } else if (itemsObj instanceof String) {
                                    // items가 String일 경우 처리
                                    Map<String, Object> detailData = new HashMap<>();
                                    detailData.put("itemsString", (String) itemsObj);
                                    detailItemList.add(detailData);
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
        }
    }

    // 데이터를 request에 저장하여 JSTL로 출력
    request.setAttribute("details", detailItemList);

    // 데이터를 세션에 저장하여 JSTL로 출력
    request.getSession().setAttribute("detailItemList", detailItemList);
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
        
        <!-- 콘텐츠 ID로 다른 상세정보 검색하기 입력 폼 추가 -->
        <div class="search-detail-container">
            <h2>DB에 저장하기</h2>
            <form action="${pageContext.request.contextPath}/HotPlace/inputDB" method="post">
                <label class="searchContentId" for="selectedContentIds">콘텐츠 ID:</label>
                <input type="text" id="selectedContentIds" name="selectedContentIds" placeholder="체크된 콘텐츠 ID가 여기에 표시됩니다." required>
                <button type="submit">DB에 저장</button>
                <label>
                    <input type="checkbox" id="selectAllCheckbox" onclick="toggleSelectAll(this)"> 전체 선택
                </label>
            </form>
        </div>

        <!-- JSTL을 사용하여 데이터를 출력 -->
        <c:if test="${not empty details}">
            <form id="detailForm">
                <ul>
                    <c:forEach var="detail" items="${details}">
                        <li>
                        	<label class="check">
                             	DB에 저장: 
                            <input type="checkbox" class="detail-checkbox" value="${detail.contentid}" onclick="updateSelectedDetails()">
                            </label>
                            <p><strong>제목:</strong> ${detail.title}</p>
                            <p><strong>주소:</strong> ${detail.addr1}</p>
							<p><strong>지역 코드:</strong> ${detail.areacode}</p>
                            <p><strong>콘텐츠 ID:</strong> ${detail.contentid}</p>
                            <p class="overview"><strong>설명</strong>: ${detail.overview}</p>
                            <p><strong>위도:</strong> ${detail.mapy}</p>
                            <p><strong>경도:</strong> ${detail.mapx}</p>
						<div class="additional-images">
                            <span>
                                <img src="${detail.firstimage}" alt="이미지">
                            </span>
							<!-- 추가 이미지들 출력 -->
							<c:forEach var="image" items="${detail.images}">
							    <span>
							        <img src="${image.originimgurl}" alt="추가 이미지">
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
            // 모든 체크된 체크박스들을 선택
            const checkboxes = document.querySelectorAll('.detail-checkbox:checked');
            const contentIds = Array.from(checkboxes).map(cb => cb.value);

            // 쉼표로 구분된 콘텐츠 ID 문자열
            document.getElementById('selectedContentIds').value = contentIds.join(',');
        }
    </script>
</body>
</html>
