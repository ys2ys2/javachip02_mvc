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
  <script src="${pageContext.request.contextPath}/resources/js/bannerslider.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	

	

</head>

<body>

  <header>
    <div class="header-container">
      <div class="logo">
        <a href="${pageContext.request.contextPath}/HomePage/mainpage">BBOL BBOL BBOL</a>
      </div>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/HomePage/mainpage">홈</a></li>
          <li><a href="${pageContext.request.contextPath}/Community/c_main">커뮤니티</a></li>
          <li><a href="${pageContext.request.contextPath}/RecoSpot/travel_Seoul">여행지</a></li>
          <li><a href="${pageContext.request.contextPath}/TravelSpot/TravelSpot">여행뽈뽈</a></li>
          <li><a href="${pageContext.request.contextPath}/TripSchedule/TripList">여행일정</a></li>
        </ul>
      </nav>
		<div class="member">
        <c:choose>
          <c:when test="${not empty member}">
            <!-- 로그인 성공 시, 마이페이지와 로그아웃 표시 -->
            <div class="welcome">
                <span class="userprofile"><img src="${pageContext.request.contextPath}${member.m_profile}" alt="user-profile"></span>
                ${member.m_nickname}님 환영합니다!
            </div>
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
	          <div class="moreinfo">자세히 보기</div>
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
		            <a href="${pageContext.request.contextPath}/BannerPlace/${banner.contentid}">
		            <img src="${banner.firstimage}" alt="${banner.title}">
		          	</a>
		          </div>
		        </c:forEach>
		      </div>
		    </div>
		  </div>
		</div>
		
		
	<div class="background-wrapper">
		
	<newhotplace-section>
  <!-- 헤더 부분 -->
	  <newhotplace-header>
	    <span class="hp01">
	    <img src="${pageContext.request.contextPath}/resources/images/hotplacemapleicon.png" alt="단풍잎 이미지">
	    11가지 매력에 빠져보세요.</span>
	    <span class="hp02">Fall in 로컬</span>
	  </newhotplace-header>

    <!-- 11개의 탭을 담고 있는 ul 리스트 -->
    <ul class="newhotplace_theme-tabs">
      <li><a href="#newhot-theme-1">L</a></li>
      <li><a href="#newhot-theme-2">O</a></li>
      <li><a href="#newhot-theme-3">C</a></li>
      <li><a href="#newhot-theme-4">A</a></li>
      <li><a href="#newhot-theme-5">L</a></li>
      <li><a href="#newhot-theme-6">T</a></li>
      <li><a href="#newhot-theme-7">R</a></li>
      <li><a href="#newhot-theme-8">A</a></li>
      <li><a href="#newhot-theme-9">V</a></li>
      <li><a href="#newhot-theme-10">E</a></li>
      <li><a href="#newhot-theme-11">L</a></li>
    </ul>
	
	<div class="panel-tabs">
    <!-- 각 탭에 해당하는 콘텐츠 패널 -->
    <article id="newhot-theme-1" class="newhotplace_theme-panel" style="display: block;">
      <header>
        <span class="themeintro1">Let's go! 로컬 스토리 여행</span>
        <span class="themedescription">그 지역이 아니면 느낄 수 없는 역사 스토리 콘텐츠</span>
      </header>
		<div class="themeimage">
		<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
			<c:if test="${status.index >= 0 && status.index < 3}">
			<div class="image-box">
				<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
				<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
				<span class="image-box-1">
				로컬 스토리 여행
				</span>
			 	<p>${hotplace.title}</p>
			 	</a>
			</div>
			</c:if>
		</c:forEach>
		</div>
    </article>

    <article id="newhot-theme-2" class="newhotplace_theme-panel" style="display: none;">
      <header>
	      <span class="themeintro2">One & Only 나홀로 여행</span>
        	<span class="themedescription">어디에도 없는 나만의 커스터마이징 여행</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 3 && status.index < 6}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-2">
	      		나홀로 여행
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>

    <article id="newhot-theme-3" class="newhotplace_theme-panel" style="display: none;">
      <header>
        <span class="themeintro3">Carnival 로컬 축제</span>
        <span class="themedescription">오직 가을에만 열리는 지역축제</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 6 && status.index < 9}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-3">
	      		로컬 축제
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>

    <article id="newhot-theme-4" class="newhotplace_theme-panel" style="display: none;">
      <header>
        <span class="themeintro4">Adventure 여행</span>
        <span class="themedescription">모험 같은 여행을 떠날 계절</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 9 && status.index < 12}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-4">
	      		모험 같은 여행
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>

    <article id="newhot-theme-5" class="newhotplace_theme-panel" style="display: none;">
      <header>
        <span class="themeintro5">Leisure 가을 레저&액티비티</span>
        <span class="themedescription">높고 깨끗한 가을 하늘 아래 즐기는 여가생활</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 12 && status.index < 15}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-5">
	      		가을 레저&액티비티
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>

    <article id="newhot-theme-6" class="newhotplace_theme-panel" style="display: none;">
      <header>
        <span class="themeintro6">Taste 맛을 찾아 떠나는 여행</span>
        <span class="themedescription">미식의 계절, 제철음식이 반기는 가을여행</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 15 && status.index < 18}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-6">
	      		맛을 찾아 떠나는 여행
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>

    <article id="newhot-theme-7" class="newhotplace_theme-panel" style="display: none;">
      <header>
        <span class="themeintro7">Relax 휴식을 찾아 떠나는 여행</span>
        <span class="themedescription">도시를 벗어나 떠나는 여유로운 가을 여행</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 18 && status.index < 21}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-7">
	      		휴식을 찾아 떠나는 여행
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>

    <article id="newhot-theme-8" class="newhotplace_theme-panel" style="display: none;">
      <header>
        <span class="themeintro8">All-new 새로운 여행</span>
        <span class="themedescription">모든게 새롭고 색다른 로컬 여행</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 21 && status.index < 24}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-8">
	      		새로운 여행
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>

    <article id="newhot-theme-9" class="newhotplace_theme-panel" style="display: none;">
      <header>
        <span class="themeintro9">Vacance 문화 바캉스</span>
        <span class="themedescription">그 지역만의 문화를 체감하는 문화 바캉스</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 24 && status.index < 27}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-9">
	      		문화 바캉스 여행
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>

    <article id="newhot-theme-10" class="newhotplace_theme-panel" style="display: none;">
      <header>
        <span class="themeintro10">Eco 친환경 여행</span>
        <span class="themedescription">여행도 챙기고, 환경도 챙기는 친환경 여행</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 27 && status.index < 30}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-10">
	      		친환경 여행
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>

    <article id="newhot-theme-11" class="newhotplace_theme-panel" style="display: none;">
      <header>
        <span class="themeintro11">Limitless 모두의 여행</span>
        <span class="themedescription">어디에도 구애받지 않고 떠날 수 있는 가을 명소</span>
      </header>
		<div class="themeimage">
   	 	<c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
	      	<c:if test="${status.index >= 30 && status.index < 33}">
	      	<div class="image-box">
	      		<a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
	      		<img src="${hotplace.firstimage}" alt="${hotplace.title}" class="timage-placeholder" />
	      		<span class="image-box-11">
	      		모두의 여행
	      		</span>
	      	 	<p>${hotplace.title}</p>
	      	 	</a>
	      	</div>
	      	</c:if>
      	</c:forEach>
     	</div>
    </article>
   </div>
</newhotplace-section>	
		
	<!-- background img -->
	<div class="hotplaceback" style="background: url(&quot;https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&amp;id=7e0aefba-db64-46d3-ad9d-62332fc470c4&quot;) no-repeat rgb(255, 255, 255);">
		<div class="hotratio">
			<span class="hot-left">
				<h2>가을은 여행의 계절</h2>
				<p>청명한 하늘과 선선한 바람 따라 떠나기 좋은 여행지와<br>
				정부에서 준비한 다양한 혜택과 이벤트를 소개합니다.</p>
			</span>
			
			<span class="hot-right">
				<img src="${pageContext.request.contextPath}/resources/images/hotplacebackground02.png" alt="여행 이미지">
			</span>
		</div>
		<div class="tfamous">
				<img src="${pageContext.request.contextPath}/resources/images/famous-title.png" alt="여행 이미지">
		  <div class="famous-list">
		    <!-- Model에서 전달된 hotplaceTitles 출력 -->
		    <c:forEach var="dataplace" items="${dataplaceDetails}">
		      <div class="famous-item" onmouseover="expandImage(this)">
        		<a href="${pageContext.request.contextPath}/DataPlace/${dataplace.contentid}">
		          <div class="image-container">
		            <img src="${dataplace.firstimage}" alt="${dataplace.title}" class="timage-placeholder" />
		          </div>
		          <p>${dataplace.title}</p>
		        </a>
		      </div>
		    </c:forEach>
		  </div>
		</div>
	</div>
  </div>

	<div class="mainratio">
	

    <!-- 인기 커뮤니티 섹션 -->
    <div class="Community">
      <div class="community-list">
        <div class="community-item">
        	<div class="c_img">
        		<img src="${pageContext.request.contextPath}/resources/images/c_board.png" alt="여행 이미지">
        	</div>
        	<div class="c_board">
        	  <span class="c_intro">오늘의 인기 커뮤니티</span>
        	  
        	  <!-- travelPost 데이터를 반복하면서 출력 -->
        	  <c:forEach var="post" items="${travelPost}">
			    <div class="board-item">
            		<div class="board-title">${post.tag_name} 여행기</div> <!-- 매칭된 tag_name 출력 -->
			    	<a href="${pageContext.request.contextPath}/Community/travelPostDetail/${post.tp_idx}">
			    	<span class="board-desc">${post.content}</span></a> <!-- content 출력 -->
			    </div>
			  </c:forEach>
        	</div>
        </div>
      </div>
    </div>
   </div>  
      
 <!-- 축제 섹션 -->
 <div class="event-section">
    <div class="event-header">
  		<span class="header_white">여행가는 가을 <span class="header_brown">특별 축제</span></span>
  		<a href="${pageContext.request.contextPath}/RecoSpot/travel_Seoul">여행지 바로가기
  			<img alt="바로가기 화살표" src="${pageContext.request.contextPath}/resources/images/header_arrow.png"></a>
  	</div>
  
	<div class="event-list mySwiper">
	    <div class="event-list-wrapper swiper-wrapper">
	        <c:forEach var="event" items="${eventImages}">
	            <div class="event_swiper-slide swiper-slide">
	                <img alt="축제 이미지" src="${event.t_main_img}">
	              	<span class="event_span">${event.t_title}</span>
	            </div>
	        </c:forEach>
	    </div>
	</div>
   </div>
   
  <div class="mainratio">
   
   <div class="endtitle">
   		<p>'뽈뽈뽈' 추천 여행지 참여 기관</p>
   		<div class="organization-container">
   			<ul class="organization-list">
            <li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-1-1.png');"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-2-1.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-3-2.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-1.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-28.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-2.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-3.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-23.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-24.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-5.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-25.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-6.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-32.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-27.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-7.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-8.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-9.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-10.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-29.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-11.png')"><li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-12.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-13.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-14.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-30.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-15.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-26.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-16.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-17.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-31.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-19.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-21.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-22.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-1.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-2.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-26.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-4.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-25.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-5.png')"></li>
            <li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-1-1.png');"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-2-1.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-3-2.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-1.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-28.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-2.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-3.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-23.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-24.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-5.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-25.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-6.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-32.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-27.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-7.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-8.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-9.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-10.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-29.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-11.png')"><li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-12.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-13.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-14.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-30.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-15.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-26.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-16.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-17.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-31.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-19.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-21.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-4-22.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-1.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-2.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-26.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-4.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-25.png')"></li>
   			<li style="background-image: url('https://korean.visitkorea.or.kr/travelmonth/assets/images/organization/img-organization-5-5.png')"></li>
  			
  			</ul>
  		</div>
  	</div>
  
  <!-- 오른쪽 하단에 고정된 이미지 버튼 -->
	<div class="floating-button">
	    <a href="${pageContext.request.contextPath}/MyPage/FAQ">
	        <img src="${pageContext.request.contextPath}/resources/images/chatbot.png" alt="챗봇 이미지">
	    </a>
	</div>
  
 </div> <!-- end of main-container  -->
 
 </div> <!-- end of mainratio -->
 
 
 

<!-- 푸터 부분 -->
<footer>

<jsp:include page="/WEB-INF/views/Components/footer.jsp" />

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

  document.querySelectorAll('.famous-item').forEach(item => {
    // 마우스가 아이템 위로 들어왔을 때 확장
    item.addEventListener('mouseenter', function() {
      if (currentExpanded === null) {
        expandImage(item); // 처음 마우스 올릴 때 이미지 확장
      }
    });

    // 마우스가 떠나도 이미지는 그대로 유지 (mouseleave 이벤트 삭제)
    // 현재 확장된 상태를 유지하기 위해 추가 작업 없음
  });

  // 이미지 클릭 시 초기화
  document.querySelector('.reset-button').addEventListener('click', resetImages);
</script>

<!-- 스크립트: 탭 클릭 시 콘텐츠 전환 -->
<script>

//페이지가 로드되면 첫 번째 탭과 패널을 기본으로 표시
  window.addEventListener('DOMContentLoaded', function() {
	  const firstTab = document.querySelector('.newhotplace_theme-tabs li:first-child');
	  const firstPanel = document.querySelector('.newhotplace_theme-panel:first-child');
  
  // 첫 번째 탭에 active 클래스 추가
  firstTab.classList.add('active');
  
  // 첫 번째 패널을 표시
  firstPanel.style.display = 'block';
  });


  // 탭을 클릭할 때 해당 article을 보여주고 나머지는 숨김
  document.querySelectorAll('.newhotplace_theme-tabs li a').forEach(function(tab) {
    tab.addEventListener('click', function(event) {
      event.preventDefault();
      
      // 모든 article을 숨김
      document.querySelectorAll('.newhotplace_theme-panel').forEach(function(panel) {
        panel.style.display = 'none';
      });
      
      // 클릭한 탭에 해당하는 article만 표시
      var target = this.getAttribute('href');
      document.querySelector(target).style.display = 'block';
    });
  });
  
  //탭 누르면 주황색 화살표
  document.querySelectorAll('.newhotplace_theme-tabs li').forEach(tab => {
  tab.addEventListener('click', function () {
    // 모든 탭에서 active 클래스 제거
    document.querySelectorAll('.newhotplace_theme-tabs li').forEach(t => t.classList.remove('active'));
    // 클릭한 탭에 active 클래스 추가
    this.classList.add('active');

    // 모든 패널 숨기기
    document.querySelectorAll('.newhotplace_theme-panel').forEach(panel => panel.style.display = 'none');

    // 클릭한 탭과 연결된 패널 표시
    const target = this.querySelector('a').getAttribute('href');
    document.querySelector(target).style.display = 'block';
  });
});
</script>

<script>
  const swiper = new Swiper('.mySwiper', {
    slidesPerView: 3, // 한 번에 보이는 슬라이드 개수
    slidesPerGroup: 3, // 한 번에 넘길 슬라이드 개수
    spaceBetween: 30, // 슬라이드 간 간격
    loop: true, // 루프 설정
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    autoplay: {
    	delay: 3000,
    	disableOnInteraction: false,	//사용자 상호작용 후에도 자동 슬라이드 유지
    },
  });
</script>


   
   
</body>

</html>