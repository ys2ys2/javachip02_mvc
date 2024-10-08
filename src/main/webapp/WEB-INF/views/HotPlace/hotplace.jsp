<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import="java.net.URL, java.net.URLEncoder, java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<%
  // 공데 API, URL 및 매개변수 설정하기
  String apiKey = "1a3173da-82c0-4157-aa94-ebc826557103";
  String numOfRows = "30"; // 메인 화면에 5개 필요
  String pageNo = "9"; // 1페이지에서 가져오기

  // API 요청 URL 빌드 - 공데 사이트에 apiKey, numOfRows, pageNo 3개 있음
  StringBuilder urlBuilder = new StringBuilder("http://api.kcisa.kr/openapi/service/rest/meta/KTOtour");
  urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + URLEncoder.encode(apiKey, "UTF-8"));
  urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode(numOfRows,"UTF-8"));
  urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8"));

  // HTTP 연결 설정
  URL url = new URL(urlBuilder.toString());
  HttpURLConnection conn = (HttpURLConnection) url.openConnection();
  conn.setRequestMethod("GET");
  conn.setRequestProperty("Content-type", "application/json");

  // API 응답 처리하기
  int responseCode = conn.getResponseCode();
  BufferedReader rd;
  if (responseCode >= 200 && responseCode <= 300) {
    rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
  }else {
    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
  }

  StringBuilder sb = new StringBuilder();
  String line;
  while ((line = rd.readLine()) != null) {
	    sb.append(line);
	}
  rd.close();
  conn.disconnect();

  // XML 데이터 문자열로 가져오기
  String xmlResponse = sb.toString();

  // 필요한 데이터 필터링 및 출력
  String[] items = xmlResponse.split("<item>");

  // 데이터 저장할 리스트 생성
  //item을 저장할 수 있는 List를 만들어서 각 항목을 Map으로 저장, Map은 특정 item 세부정보를 json형식익인 key-value로 관리
  //Map으로 title, author, date 등 저장, Map<String,Sting> 이건 키, 값 다 문자열(String)이라는 표시
  List<Map<String, String>> itemList = new ArrayList<>();

  //배열 items에서 각 항목을 순차적으로 처리하기 위해 for문 사용(items 배열은 여러개를 가지고 있기 때문에 하나씩 순회하면서 사용)
  //i가 1부터 시작되는 이유는 보통 첫번째 항목 = 0 은 헤더 정보나, 불필요한 메타 데이터일 수 있기 때문에 패스하기 위해서!
  //items.length 사용해서 i < items.length 배열의 크기만큼만 반복문 실행(item 배열에 들어가있는 데이터 갯수만큼 반복해서 처리)
  
  for (int i = 1; i < items.length; i++) {
    String item = items[i];

    // 각 항목의 필요한 필드 추출
    // item.split("<title>")[1].split("</title>") = item 문자열을 <title>태그 기준으로 나눔
    // <title>제목</title> 이니까 <title>로 분리해서 두 부분으로 나눔
    // 첫 번째 배열 요소[0]은 title의 앞의 내용(필요하지 않음, 더미 가능성 많아서)
    // 두 번째 배열 요소[1]은 title의 뒤의 내용 = 제목 포함 부분
    // 결과적으로 <title>제목</title> 이라는 부분에서 제목 앞인 [0]을 뺀 제목 부분의 문자열만 추출
    // <title>을 ""로 감싼 이유? 문자열들을 정확하게 지정해서 split 함수로 원하는 데이터를 추출하려고

    String title = item.split("<title>")[1].split("</title>")[0]; // 제목
    String description = item.split("<description>")[1].split("</description>")[0]; //설명
    String spatial = item.split("<spatial>")[1].split("</spatial>")[0]; //위치

    // HTML 엔티티 디코딩
	description = StringEscapeUtils.unescapeHtml4(description);

    // 데이터를 Map에 저장
    Map<String, String> itemData = new HashMap<>();
    itemData.put("title", title);
    itemData.put("description", description);
    itemData.put("spatial", spatial); // 위치 데이터를 저장

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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" /> <!-- slick css -->
  <link rel="stylesheet" href="hotplace.css">
  <link rel="stylesheet" href="../css/header.css"> <!-- header.css -->
  <link rel="stylesheet" href="../css/footer.css"> <!-- footer.css-->

  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBGXfM-W2P67M4VmuJdGHedKT73_rMEWQ&callback=initMap" async defer></script>
  <script src="../HotPlace/googlemap.js"></script>
  <script src="../HotPlace/section.js"></script>
  <script src="../components/header.js"></script>
  <script src="../components/lang-toggle.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="../HotPlace/br.js"></script>

  
  <title>함께 떠나는 핫플 여행!</title>


</head>

<body>

  <!-- 어두운 배경 -->
  <div class="overlay"></div>

  <header>
    <div class="header-container">
      <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
      <nav>
        <ul>
          <li><a href="#" data-ko="홈" data-en="Home">홈</a></li>
          <li><a href="#" data-ko="커뮤니티" data-en="Community">커뮤니티</a></li>
          <li><a href="#" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
          <li><a href="#" data-ko="여행뽈뽈" data-en="BBOL BBOL BBOL">여행뽈뽈</a></li>
          <button class="search-btn">
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
          <button class="user-btn">
            <i class="fa-solid fa-user"></i>
          </button>
          <button class="earth-btn">
            <i class="fa-solid fa-earth-americas"></i>
          </button>
          <button class="korean" id="lang-btn" data-lang="ko">English</button>
        </ul>
      </nav>
    </div>
    <!-- 검색 바 -->
<!--     <div class="search-bar-container">
      <div class="search-bar-content">
        <input type="text" placeholder="도시나 키워드를 검색해보세요..." data-ko="도시나 키워드를 검색해보세요..."
          data-en="Search cities or keywords...">
        <button class="close-btn"><i class="fa-solid fa-times"></i></button>
      </div>
    </div> -->
  </header>
  

	<%
	  // 첫 번째 항목만 선택
	  Map<String, String> firstItem = itemList.get(12);
	  request.setAttribute("firstItem", firstItem); // 첫 번째 item을 request에 저장
	%>


  <div class="h_minibody">
    <!-- 타이틀 -->
    <div class="h_title-container">
      <h2>제목 : ${firstItem.title}</h2> <!-- EL로 제목 표시 -->
      <h3>장소 : ${firstItem.spatial}</h3> <!-- EL로 장소 표시 -->
      <h4>소제목 : 실용적인 구조로 되어 있는 동양 성곽의 백미</h4>
    </div>
    <div class="h_icons">
      <button class="h_button">
        <img src="../images/heart.png" alt="likes">
      </button>
      <button class="f_button">
        <img src="../images/favorite.png" alt="favorite">
      </button>
      <button class="s_button">
        <img src="../images/share.png" alt="share">
      </button>
    </div>

    <!-- 네비바 부분 -->
    <div class="h_section-container">
      <ul class="h_navbar">
        <li class="h_nav-item"><a href="#" data-target="section-photos">사진보기</a></li>
        <li class="h_nav-item"><a href="#" data-target="section-details">상세정보</a></li>
        <li class="h_nav-item"><a href="#" data-target="section-talk">여행톡</a></li>
        <li class="h_nav-item"><a href="#" data-target="section-recommend">추천여행</a></li>
      </ul>
    </div>


    <!-- 본문 -->
    <div id="section-photos" class="h_content">
      <img src="../images/firecastle01.jpg" alt="화성01">
      <img src="../images/firecastle02.jpg" alt="화성02">
      <img src="../images/firecastle03.jpg" alt="화성03">
      <img src="../images/firecastle04.jpg" alt="화성04">
      <img src="../images/firecastle05.jpg" alt="화성05">
      <img src="../images/firecastle06.jpg" alt="화성06">
    </div>



    <div id="section-details" class="h_details_title">
      <span>상세정보</span>
    </div>
    <div class="h_details">
  		<p id="description-text">${firstItem.description}</p> <!-- 공공데이터에서 받아온 설명 표시 -->
    </div>
    <button class="h_details_more">
      내용 더보기...
    </button>

    <div id="map" class="h_map">
      <div class="google_map"></div> <!-- 구글 맵 부분 -->
    </div>
    

    <div id="section-talk" class="h_talk">
      <h2>여행 톡 <span>2</span></h2>
      <div class="comment-form">
        <textarea placeholder="로그인 후 소중한 댓글을 남겨주세요."></textarea>
        <div class="form-actions">
          <button class="login-button">로그인</button>
        </div>
      </div>

      <div class="comments-section">
        <div class="comment">
          <div class="user-info">
            <img src="../images/user-placeholder.png" alt="user">
            <span class="username">홍삼</span>
            <span class="date">2024.9.24</span>
          </div>
          <p>현재와 과거가 함께 있는 느낌이 드는 곳입니다. 역사적으로도 의미가 있는 곳이라서 사진과 정보를 확인하고 가니 더 좋았습니다</p>
          <div class="comment-actions">
            <span>👍 0</span>
          </div>
        </div>

        <div class="comment">
          <div class="user-info">
            <img src="../images/user-placeholder.png" alt="user">
            <span class="username">파워</span>
            <span class="date">2024.9.21</span>
          </div>
          <p>밤과 낮 각각의 매력이 있는 곳. 가족과 산책하며 끌끌끌 다니는 재미가 있어요</p>
          <div class="comment-actions">
            <span>👍 0</span>
          </div>
        </div>
      </div>

      <div class="more-comments">
        <a href="#">댓글 더보기 +</a>
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



  
  <script>
  	var spatial = "${firstItem.spatial}";  // 값이 문자열이므로 따옴표로 감싸줍니다
  </script>

</body>
</html>
