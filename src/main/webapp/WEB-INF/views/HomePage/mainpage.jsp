<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import="java.net.URL, java.net.URLEncoder, java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 공공데이터 API URL 및 매개변수 설정
    String apiKey = "a471e760-6101-4c50-bb4c-560d6fb00f86";
    String numOfRows = "7"; // 요청할 레코드 수
    String pageNo = "2"; // 요청할 페이지 번호

    // API 요청 URL 빌드
    StringBuilder urlBuilder = new StringBuilder("http://api.kcisa.kr/openapi/API_CNV_061/request");
    urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + URLEncoder.encode(apiKey, "UTF-8"));
    urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8"));
    urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8"));

    // HTTP 연결 설정
    URL url = new URL(urlBuilder.toString());
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Content-type", "application/json");

    // API 응답 처리
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

    // XML 데이터를 문자열로 가져옴
    String xmlResponse = sb.toString();

    // 필요한 데이터 필터링 및 출력
    String[] items = xmlResponse.split("<item>");

    // 데이터를 저장할 리스트 생성
    List<Map<String, String>> itemList = new ArrayList<>();

    for (int i = 1; i < items.length; i++) {
        String item = items[i];
        
        // 각 항목의 필요한 필드 추출
        String title = item.split("<title>")[1].split("</title>")[0];
        String description = item.split("<description>")[1].split("</description>")[0];
        String urlStr = item.split("<url>")[1].split("</url>")[0];
        String viewCnt = item.split("<viewCnt>")[1].split("</viewCnt>")[0];
        String spatialCoverage = item.split("<spatialCoverage>")[1].split("</spatialCoverage>")[0];
        
        // HTML 엔티티를 디코딩
        description = StringEscapeUtils.unescapeHtml4(description);
        
        // 데이터를 Map에 저장
        Map<String, String> itemData = new HashMap<>();
        itemData.put("title", title);
        itemData.put("description", description);
        itemData.put("urlStr", urlStr);
        itemData.put("viewCnt", viewCnt);
        itemData.put("spatialCoverage", spatialCoverage);

        // 리스트에 추가
        itemList.add(itemData);
    }

    // 데이터를 request에 저장
    request.setAttribute("itemList", itemList);

    // 데이터를 JSON 형식으로 변환하여 JavaScript로 전달
    String jsonItemList = new org.json.JSONArray(itemList).toString();
    request.setAttribute("jsonItemList", jsonItemList);

%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>BBOL BBOL BBOL</title>
  <!-- 컨텍스트 루트를 사용한 CSS 링크 -->
  <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/resources/css/mainpage.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <!-- slick css -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
  
  <script>
    // JSP에서 전달한 공공데이터를 JavaScript로 전달
    const descriptions = ${jsonItemList};
  </script>

 
</head>

<body>


  <!-- 어두운 배경 -->
  <div class="overlay"></div>
  <header>
    <div class="header-container">
      <div class="logo">
        <a href="${pageContext.request.contextPath}/HomePage/mainpage">BBOL BBOL BBOL</a>
      </div>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/HomePage/mainpage">홈</a></li>
          <li><a href="#">커뮤니티</a></li>
   		<li><a href="RecoSpot/travel_Seoul" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
          <li><a href="#">여행뽈뽈</a></li>
        </ul>
      </nav>
      <div class="member">
        <c:choose>
          <c:when test="${not empty sessionScope.member}">
            <!-- 로그인 성공 시, 마이페이지와 로그아웃 표시 -->
            <div class="welcome">${sessionScope.member.m_nickname}님 환영합니다!</div>
            <span><a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지</a></span>
            <form action="${pageContext.request.contextPath}/Member/logout" method="post" style="display:inline;">
              <button type="submit">로그아웃</button>
            </form>
          </c:when>
          <c:otherwise>
            <!-- 로그인 실패 시, 로그인과 회원가입 표시 -->
            <span><a href="${pageContext.request.contextPath}/Member/login">로그인</a></span>
            <span><a href="${pageContext.request.contextPath}/Member/joinmain">회원가입</a></span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>
  <!-- 메인 시작 부분 -->
  
  <div class="main-container">
    <!-- 첫번째 큰 이미지 슬라이드 영역 -->
    <div class="main-banner">
      <!-- 이미지 슬라이드 컨테이너, 필수는 swiper-container, wrapper, slide -->
      <div class="swiper-container">
      
        <!-- 설명 박스 -->
        <div class="description-box">
          <h2 id="description-title"></h2>
          <p id="description-text"></p>
          <a href="#" class="detail-link" id="detail-link">자세히 보기</a>

            <!-- 슬라이드 컨트롤 -->
            <div class="custom-pagination">
              <span class="current-slide">?</span>/<span class="total-slides">?</span>
              <div class="controls">
              <button class="prev-btn">
                <img src="${pageContext.request.contextPath}/resources/images/btn_showcase_arw_left.png" alt="left_btn">
              </button>
              <button class="pause-btn">
                <img src="${pageContext.request.contextPath}/resources/images/btn_slidem_stop02.png" alt="pause_btn">
              </button>
              <button class="next-btn">
                <img src="${pageContext.request.contextPath}/resources/images/btn_showcase_arw_right.png" alt="right_btn">
              </button>
              </div>
            </div>
        </div>

        <!-- 슬라이드 이미지 -->
        <div class="swiper">
          <div class="swiper-wrapper">
            <div class="swiper-slide">
              <img src="${pageContext.request.contextPath}/resources/images/banner_01.jpg" alt="배너1">
            </div>
            <div class="swiper-slide">
              <img src="${pageContext.request.contextPath}/resources/images/banner_02.jpg" alt="배너2">
            </div>
            <div class="swiper-slide">
              <img src="${pageContext.request.contextPath}/resources/images/banner_03.jfif" alt="배너3">
            </div>
            <div class="swiper-slide">
              <img src="${pageContext.request.contextPath}/resources/images/banner_04.jpg" alt="배너4">
            </div>
            <div class="swiper-slide">
              <img src="${pageContext.request.contextPath}/resources/images/banner_05.jpg" alt="배너5">
            </div>
            <div class="swiper-slide">
              <img src="${pageContext.request.contextPath}/resources/images/banner_06.jpg" alt="배너6">
            </div>
            <div class="swiper-slide">
              <img src="${pageContext.request.contextPath}/resources/images/banner_07.jpg" alt="배너7">
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 인기 여행지 섹션 -->
    <div class="famous">
      <h2>인기 여행지</h2>
      <div class="famous-list">
        <div class="famous-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>도쿄</p>
        </div>
        <div class="famous-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>부산</p>
        </div>
        <div class="famous-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>서울</p>
        </div>
        <div class="famous-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>오사카</p>
        </div>
        <div class="famous-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>타이베이</p>
        </div>
        <div class="famous-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>강원도</p>
        </div>
        <div class="famous-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>제주도</p>
        </div>
        <div class="famous-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>태국</p>
        </div>
      </div>
    </div>

    <!-- 인기 커뮤니티 섹션 -->
    <div class="Community">
      <h2>인기 커뮤니티</h2>
      <div class="community-list">
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 1</p>
        </div>
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 2</p>
        </div>
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 3</p>
        </div>
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 4</p>
        </div>
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 5</p>
        </div>
      </div>
    </div>

    <!-- 핫플 섹션 -->
    <div class="hotplace-section">
      <h2>함께 떠나는 핫플 여행</h2>
    <div class="hotplace-list">
    <div class="hotplace-item">
      	<a href="${pageContext.request.contextPath}/HotPlace/hotplace.jsp" class="hotplace-item">
      	<img src="${pageContext.request.contextPath}/resources/images/firecastle01.jpg" alt="수원화성1">
      </a>
    </div>
    <div class="hotplace-item">
		<a href="${pageContext.request.contextPath}/HotPlace/hotplace2" class="hotplace-item">
        <img src="${pageContext.request.contextPath}/resources/images/firecastle02.jpg" alt="수원화성2">
      </a>
    </div>
    <div class="hotplace-item">
		<a href="${pageContext.request.contextPath}/Login/login" class="hotplace-item">
		<img src="${pageContext.request.contextPath}/resources/images/firecastle03.jpg" alt="수원화성3">
	  </a>
    </div>
    <div class="hotplace-item">
      <a href="${pageContext.request.contextPath}/Community/c_board/travelWrite" class="hotplace-item">
      <img src="${pageContext.request.contextPath}/resources/images/firecastle04.jpg" alt="수원화성4">
      </a>
    </div>
    <div class="hotplace-item">
      <a href="${pageContext.request.contextPath}/Community/c_main/c_main" class="hotplace-item">
      <img src="${pageContext.request.contextPath}/resources/images/firecastle05.jpg" alt="수원화성5">
      </a>
    </div>
  </div>
</div>
      
      
  <!-- 이벤트 섹션 -->
  <div class="event-section">
    <h2>이벤트</h2>
    <div class="event-list">
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>이벤트 1</p>
      </div>
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>이벤트 2</p>
      </div>
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>이벤트 3</p>
      </div>
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>이벤트 4</p>
      </div>
    </div>
  </div>


<!-- 푸터 부분 -->
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h4>회사소개</h4>
      <ul>
        <li><a href="#">회사소개</a></li>
        <li><a href="#">브랜드 이야기</a></li>
        <li><a href="#">채용공고</a></li>
      </ul>
    </div>

    <!-- 고객지원 -->
    <div class="footer-section">
      <h4>고객지원</h4>
      <ul>
        <li><a href="#">공지사항</a></li>
        <li><a href="#">자주묻는 질문</a></li>
        <li><a href="#">문의하기</a></li>
      </ul>
    </div>

    <!-- 이용약관 -->
    <div class="footer-section">
      <h4>이용약관</h4>
      <ul>
        <li><a href="#">이용약관</a></li>
        <li><a href="#">개인정보처리방침</a></li>
        <li><a href="#">저작권 보호정책</a></li>
      </ul>
    </div>

    <!-- 회사 정보 -->
    <div class="footer-company-info">
      <p>상호: (주)BBOL | 대표: 박예슬 | 사업자등록번호: 123-45-67890 | 통신판매업 신고번호: 2024-충남천안-00000 | 개인정보관리 책임자: 수수옥</p>
      <p>주소: 충청남도 천안시 동남구 123 | 이메일: support@BBOL3.com | 대표전화: 02-1234-5678</p>
      <p>© 2024 BBOLBBOLBBOL. All Rights Reserved.</p>
    </div>

    <!-- 소셜 미디어 -->
    <div class="footer-social">
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-facebook-f"></i></a>
      <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
</footer>

   <!-- 메인 스크립트 -->
   <script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/bannerslider.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
   
</body>

</html>
