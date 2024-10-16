<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import="java.net.URL, java.net.URLEncoder, java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
  
  <!-- 메인 스크립트 -->
  <script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/bannerslider.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	

	

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
          <li><a href="${pageContext.request.contextPath}/HotPlace/hotplace2">여행지</a></li>
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
    	<c:forEach var="banner" items="${bannerPlaces}" varStatus="status">
    		<c:if test="${status.first}"> <!-- 첫 번째 요소만 출력 -->
            <h2 id="description-title">${banner.title}</h2>
	        <p id="description-text">${banner.overview}</p>
            <a href="${pageContext.request.contextPath}/BannerPlace/${banner.contentid}" class="detail-link">
	          자세히 보기
	        </a>
	        </c:if>
      	</c:forEach>

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
		        <c:forEach var="banner" items="${bannerPlaces}">
		          <div class="swiper-slide">
		            <img src="${banner.firstimage}" alt="${banner.title}">
		          </div>
		        </c:forEach>
		      </div>
		    </div>
		  </div>
		</div>


	<div class="mainratio">
	<!-- 인기 여행지 섹션 -->
	<div class="famous">
	  <h2>인기 여행지</h2>
	  <div class="famous-list">
	    <!-- Model에서 전달된 hotplaceTitles 출력 -->
	    <c:forEach var="hotplace" items="${hotplaceDetails}">
	      <div class="famous-item" onmouseover="expandImage(this)" onmouseout="resetImages()">
	        <a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	          <div class="image-container">
	            <img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	          </div>
	          <p>${hotplace.title}</p>
	        </a>
	      </div>
	    </c:forEach>
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
   		<c:forEach var="hotplace" items="${hotplaceDetails}">
    <div class="hotplace-item">
		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	    	<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="image-placeholder" />
	    	<p>${hotplace.title}</p>
      </a>
    </div>
    	</c:forEach>
  </div>
</div>
   
      
      
  <!-- 축제 섹션 -->
  <div class="event-section">
    <h2>축제</h2>
    <div class="event-list">
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>축제 1</p>
      </div>
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>축제 2</p>
      </div>
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>축제 3</p>
      </div>
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>축제 4</p>
      </div>
    </div>
  </div>
  </div> <!--  end of mainratio -->
  
 </div> <!-- end of main-container  -->

<!-- 푸터 부분 -->
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h4>회사소개</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/introduce" target="_blank">회사소개</a></li>
        <li><a href="${pageContext.request.contextPath}/HotPlace/inputApi"target="_blank">공공데이터 API</a></li>
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
        <li><a href="${pageContext.request.contextPath}/FooterPage/clause" target="_blank">이용약관</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank">개인정보처리방침</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/marketing" target="_blank">광고성 정보 수신동의</a></li>
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
    
  </div>
</footer>



<script type="text/javascript">
  // JSP에서 전달받은 데이터를 JSON 형식으로 변환하여 자바스크립트로 전달
  var descriptions = 
    <%= new org.json.JSONArray((List<?>) request.getAttribute("bannerPlaces")).toString() %>;
  var contextPath = "${pageContext.request.contextPath}";
</script>


<!-- 스크립트 -->
<script>
  let currentExpanded = null; // 현재 확장된 이미지 저장

  function resetImages() {
    const allItems = document.querySelectorAll('.famous-item');
    allItems.forEach(item => {
      item.style.flexGrow = '1'; // 모든 이미지를 원래 크기로 복귀
    });
    currentExpanded = null; // 확장 상태 초기화
  }

  function expandImage(element) {
    const allItems = document.querySelectorAll('.famous-item');
    
    // 모든 아이템의 기본 크기를 1로 설정
    allItems.forEach(item => {
      item.style.flexGrow = '1';
    });

    // 클릭한 이미지를 60%로 확장
    element.style.flexGrow = '5'; // 60%로 확장
    currentExpanded = element; // 현재 확장된 이미지 저장

    // 나머지 이미지들은 각 20%로 작게 설정
    allItems.forEach(item => {
      if (item !== element) {
        item.style.flexGrow = '2'; // 나머지 아이템은 20%로 설정
      }
    });
  }
</script>


   
   
</body>

</html>