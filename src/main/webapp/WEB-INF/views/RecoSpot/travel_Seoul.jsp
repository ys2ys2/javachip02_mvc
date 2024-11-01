<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Random" %>



<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BBOL BBOL BBOL</title>
     <!-- 상대 경로를 사용한 css링크-->   
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/travel.css?v=1.0">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- icon.css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
</head>

<body>
<!-- header -->
<jsp:include page="/WEB-INF/views/Components/header.jsp" />

<!-- 박스랑 카드 조절하기 -->
<div class="footer-section">
<!-- 푸터 위에 동그란 이미지 슬라이더 -->
<div class="footer-slider-container">
    <div class="footer-slider-content">
        <div class="swiper">
            <div class="swiper-wrapper">
                <!-- 이미지와 지역 이름 -->
                <div class="swiper-slide">
                    <a href="${pageContext.request.contextPath}/RecoSpot/travel_Seoul">
                        <img src="${pageContext.request.contextPath}/resources/images/서울.jpg" alt="서울" class="circle-image">
                        <div class="region-name-box">
                            <div class="region-name">서울</div>
                        </div>
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="${pageContext.request.contextPath}/RecoSpot/travel_Daejeon">
                        <img src="${pageContext.request.contextPath}/resources/images/인천.jpg" alt="대전" class="circle-image">
                        <div class="region-name-box">
                            <div class="region-name">대전</div>
                        </div>
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="${pageContext.request.contextPath}/RecoSpot/travel_Incheon">
                        <img src="${pageContext.request.contextPath}/resources/images/인천.jpg" alt="인천" class="circle-image">
                        <div class="region-name-box">
                            <div class="region-name">인천</div>
                        </div>
                    </a>
                </div>

                <!-- 다른 지역들 -->
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/대구.jpg" alt="대구" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">대구</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/경기.jpg" alt="경기" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">경기</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/부산.jpg" alt="부산" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">부산</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/울산.jpg" alt="울산" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">울산</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/광주.jpg" alt="광주" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">광주</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/강원.jpg" alt="강원" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">강원</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/충북.jpg" alt="충북" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">충북</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/충남.jpg" alt="충남" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">충남</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/경북.jpg" alt="경북" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">경북</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/경남.jpg" alt="경남" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">경남</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/전북.jpg" alt="전북" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">전북</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/전남.jpg" alt="전남" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">전남</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/제주.jpg" alt="제주" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">제주</div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <img src="${pageContext.request.contextPath}/resources/images/세종.jpg" alt="세종" class="circle-image">
                    <div class="region-name-box">
                        <div class="region-name">세종</div>
                    </div>
                </div>
            </div>
        </div>
    <!-- 푸터 아래 3개의 박스 -->
	<div class="footer-boxes">
	  <!-- 박스 1 -->
	<div class="footer-box">
	  <div class="event-box">행사</div>
	  <div class="event-content">
	    <div class="event-title">2024 파리나무십자가 소년 합창단 특별초청공연</div>
	    <div class="event-description">
	      2024 파리나무 십자가<br>
	      소년 합창단 특별초청공연에 여러분을 초대합니다.
	    </div>
	    <a href="${pageContext.request.contextPath}/Festival/Event2" class="more-info">자세히보기 &gt;</a>
	  </div>
	</div>

	<!-- 박스 2 -->
	<div class="footer-box">
	  <div class="event-box">행사</div>
	  <div class="event-content">
	    <div class="event-title">서울일러스트레이션페어 V.18</div>
	    <div class="event-description">
	      [레이션페어]<br>
	      강남구 예술의 전당에서 열리는 서울일러스트레이션페어!
	    </div>
	    <a href="${pageContext.request.contextPath}/Festival/Event" class="more-info">자세히보기 &gt;</a>
	  </div>
	</div>
    
	<!-- 박스 3 -->
	  <div class="footer-box">
	    <div class="event-box">행사</div>
	    <div class="event-content">
	      <div class="event-title">행복의 파랑새</div>
	      <div class="event-description">
	        [종로문화재단] 음악동화 [행복의 파랑새]<br>
	        종로구에서 진행하는 축제입니다.
	      </div>
	      <a href="${pageContext.request.contextPath}/Festival/Event3" class="more-info">자세히보기 &gt;</a>
	    </div>
	  </div>
	</div>
   </div>
  </div>
</div>


<div class="travel-post-container">
    <h2>서울 여행기</h2>
    <div class="travel-post-list">
        <c:forEach var="post" items="${travelPost}">
            <div class="travel-post-content">
                <div class="travel-post-img">
                    <a href="${pageContext.request.contextPath}/Community/travelPostDetail/${post.tp_idx}">
                        <c:choose>
                            <c:when test="${post.tp_idx == 9}">
                                <img src="${pageContext.request.contextPath}/resources/images/t_idx_1.jpg" alt="image1">
                            </c:when>
                            <c:when test="${post.tp_idx == 10}">
                                <img src="${pageContext.request.contextPath}/resources/images/t_idx_2.jfif" alt="image2">
                            </c:when>
                            <c:when test="${post.tp_idx == 12}">
                                <img src="${pageContext.request.contextPath}/resources/images/t_idx_3.PNG" alt="image3">
                            </c:when>
                            <c:when test="${post.tp_idx == 13}">
                                <img src="${pageContext.request.contextPath}/resources/images/t_idx_4.PNG" alt="image4">
                            </c:when>
                            <c:when test="${post.tp_idx == 14}">
                                <img src="${pageContext.request.contextPath}/resources/images/t_idx_5.PNG" alt="image5">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/resources/images/default.jpg" alt="default image">
                            </c:otherwise>
                        </c:choose>
                    </a>
                </div>
                <div class="travel-post-title">${post.content}</div>
                <div class="travel-post-writer">by ${post.writer}</div>
            </div>
        </c:forEach>
    </div>
</div>

              

<jsp:include page="journal_Seoul.jsp" />


<!-- footer -->
<jsp:include page="/WEB-INF/views/Components/footer.jsp" />
<!-- 메인 스크립트 -->
<script src="${pageContext.request.contextPath}/resources/header.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/travel.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>



</body>




</html>