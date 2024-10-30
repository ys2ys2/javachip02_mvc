<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setTimeZone value="UTC" />

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/hotplace.css">

  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBGXfM-W2P67M4VmuJdGHedKT73_rMEWQ&callback=initMap" async defer></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/googlemap.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/section.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/br.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- 차트 -->
  
  <title>함께 떠나는 핫플 여행! ${hotplace.title}</title>
</head>

<body>

<!-- header -->
<jsp:include page="/WEB-INF/views/Components/header.jsp" />
  <div class="overlay"></div>
  <div class="h_minibody">
    <!-- 타이틀 -->
    <div class="h_title-container">
        <h2>${hotplace.title}</h2> <!-- 제목 -->
        <h3>${hotplace.addr1}</h3> <!-- 장소 -->
        
        <!-- mapx와 mapy 값을 자바스크립트로 전달 -->
        <script type="text/javascript">
            var mapx = "${hotplace.mapx}";
            var mapy = "${hotplace.mapy}";
            var firstimage = "${hotplace.firstimage}";
        </script>
    </div>
    <div class="h_icons">
		<!-- 좋아요 버튼 -->
		<button class="h_button" id="likeButton">
		  <img src="${pageContext.request.contextPath}/resources/images/heart.png" alt="likes" id="likeImage">
		</button>
		<!-- 저장하기 버튼 -->
		<form id="saveForm" action="${pageContext.request.contextPath}/hotplace/save" method="post">
		    <!-- contentid가 JSP에서 제대로 전달되는지 확인 -->
		    <input type="hidden" name="contentid" value="${hotplace.contentid}">
		    <button type="submit" class="f_button">
		        <img src="${pageContext.request.contextPath}/resources/images/favorite.png" alt="favorite">
		    </button>
		</form>
      <button class="s_button" onclick="toggleSharePopup()">
        <img src="${pageContext.request.contextPath}/resources/images/share.png" alt="share">
      </button>
    </div>
    
    
        <!-- 공유하기 팝업 -->
	<div id="sharePopup" class="share-popup">
	    <div class="share-popup-content">
	        <div class="share-header">
	            <span>공유하기</span>
	            <button class="close-btn" onclick="toggleSharePopup()">×</button>
	        </div>
	        <div class="share-options">
    			<div class="share-option" onclick="shareToFacebook()">
	                <img src="${pageContext.request.contextPath}/resources/images/share_facebook.png" alt="페이스북">
	                <span>페이스북</span>
	            </div>
	            <div class="share-option" onclick="shareToX()">
	                <img src="${pageContext.request.contextPath}/resources/images/share_x.png" alt="엑스">
	                <span>엑스</span>
	            </div>
	            <div class="share-option" onclick="shareToKakao()">
	                <img src="${pageContext.request.contextPath}/resources/images/share_kakaotalk.png" alt="카카오톡">
	                <span>카카오톡</span>
	            </div>
	            <div class="share-option" onclick="shareToBand()">
	                <img src="${pageContext.request.contextPath}/resources/images/share_band.png" alt="밴드">
	                <span>밴드</span>
	            </div>
	        </div>
	        <div class="share-url">
	            <input type="text" value=" " id="shareUrl" readonly>
	            <button onclick="copyUrl()">URL 복사</button>
	        </div>
	    </div>
	</div>

    <!-- 네비바 부분 -->
    <div class="h_section-container">
      <ul class="h_navbar">
        <li class="h_nav-item"><a href="#" data-target="section-photos">사진보기</a></li>
        <li class="h_nav-item"><a href="#" data-target="section-details">상세정보</a></li>
        <li class="h_nav-item"><a href="#" data-target="section-weather">날씨정보</a></li>
        <li class="h_nav-item"><a href="#" data-target="section-talk">여행톡</a></li>
        
      </ul>
    </div>

	<!-- 사진 보기 섹션 (메인 슬라이드) -->
	<div id="section-photos" class="h_content">
	    <div class="swiper mySwiper2">
	        <div class="swiper-wrapper">
	            <!-- firstimage 필드를 쉼표로 나누어 배열로 처리 -->
	            <c:set var="imageArray" value="${fn:split(hotplace.firstimage, ',')}" />
	            <c:forEach var="imgUrl" items="${imageArray}">
	                <div class="swiper-slide">
	                    <img src="${fn:trim(imgUrl)}" alt="핫플 이미지" />
	                </div>
	            </c:forEach>
	        </div>
	        <button class="custom-next-button">
	            <img src="${pageContext.request.contextPath}/resources/images/right_arrow.png" alt="다음">
	        </button>
	        <button class="custom-prev-button">
	            <img src="${pageContext.request.contextPath}/resources/images/left_arrow.png" alt="이전">
	        </button>
	    </div>
	
	    <!-- Swiper 썸네일 추가 -->
	    <div thumbsSlider="" class="swiper mySwiper">
	        <div class="swiper-wrapper">
	            <c:forEach var="imgUrl" items="${imageArray}">
	                <div class="swiper-slide">
	                    <img src="${fn:trim(imgUrl)}" alt="핫플 썸네일 이미지" />
	                </div>
	            </c:forEach>
	        </div>
	    </div>
	</div>

    <!-- 상세정보 -->
    <div id="section-details" class="h_details_title">
      <span>상세 정보</span>
    </div>
    <div class="h_details">
        <p id="description-text">${hotplace.overview}</p>
    </div>

    <!-- 구글 맵 -->
    <div id="map" class="h_map">
      <div class="google_map"></div>
    </div>
    
    
    <!-- 날씨정보 -->
    <div id="section-weather" class="h_details_title">
      <span>날씨정보</span>
    </div>
    
	<div class="weather_area">
		<div class="weather_info">
    	<button id="prevButton" class="slide-button">
	      <img src="${pageContext.request.contextPath}/resources/images/hot_left_button.png" alt="Prev">
	    </button>
	    <div class="temperature-container" >
      		<canvas id="weatherCanvas" width="9999" height="300" style="position:absolute; top:0; left:0; z-index:10;"></canvas>
	      	<ul class="temperature-list" style="position:relative; z-index:2; width: 9999px; display: flex;"></ul>
 	  	</div>
        <button id="nextButton" class="slide-button">
          <img src="${pageContext.request.contextPath}/resources/images/hot_right_button.png" alt="Prev">
        </button>
		</div>
	</div>
	    
    

    <!-- 여행톡 부분 -->
    <div id="section-talk" class="h_talk">
      <h2>여행톡 <span>${totalTalkCount}</span></h2>
    </div>

    <div class="comment-form">
      <c:choose>
        <c:when test="${not empty sessionScope.member.m_nickname}">
          <!-- 로그인된 사용자가 댓글 작성 가능 -->
          <form action="${pageContext.request.contextPath}/HotPlace/insert" method="post">
            <!-- hidden으로 contentid 전달하기(위에 form사용) -->
            <input type="hidden" name="contentid" value="${hotplace.contentid}" />	<!-- contentid로 상세페이지 전달 -->
            <input type="hidden" name="type" value="HotPlace"> <!-- type으로 어떤 페이지에서 작성되는지 전달 -->
            <textarea id="commentText" name="talkText" placeholder="소중한 댓글을 남겨주세요."></textarea>
            <div class="form-actions">
              <button class="login-button" id="submitButton">작성하기</button>
            </div>
          </form>
        </c:when>
        <c:otherwise>
          <!-- 로그인되지 않은 경우 -->
          <a href="${pageContext.request.contextPath}/Member/login" onclick="alert('로그인 해 주시길 바랍니다!');">
            <textarea id="commentText" placeholder="로그인 후 소중한 댓글을 남겨주세요." readonly onclick="redirectToLogin()"></textarea>
          </a>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="comments-section">
      <c:forEach var="talk" items="${talkList}">
        <div class="comment" data-talk-id="${talk.talkIdx}">
          <div class="user-info">
            <!-- DB에 저장된 프로필 사진 가져오기 -->
			<img src="${pageContext.request.contextPath}${talk.talkProfile}" alt="user-profile">
            <span class="username">${talk.talkNickname}</span>
            <span class="date">
              <!-- 수정일이 없으면 생성일을 표시 -->
              <fmt:formatDate value="${talk.talkUpdatedAt != null ? talk.talkUpdatedAt : talk.talkCreatedAt}" pattern="yyyy-MM-dd HH:mm" />
            </span>
          </div>
          <p class="comment-text">${talk.talkText}</p>
          <textarea class="edit-comment-text" style="display:none;">${talk.talkText}</textarea>

          <div class="comment-actions">
            <!-- 세션에 저장된 member의 m_email 값과 talk의 talkEmail 값을 비교 -->
            <c:if test="${sessionScope.member.m_email eq talk.talkEmail}">
              <button class="delbtn" data-talk-id="${talk.talkIdx}">삭제하기</button>
              <button class="editbtn" data-talk-id="${talk.talkIdx}">수정하기</button>
            </c:if>
            <button class="cancelbtn" data-talk-id="${talk.talkIdx}" style="display:none;">취소하기</button>
            <button class="savebtn" data-talk-id="${talk.talkIdx}" style="display:none;">저장하기</button>
          </div>
        </div>
      </c:forEach>
    </div>
    


    <!-- 페이지네이션 -->
    <div class="pagination">
      <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
          <c:when test="${i == currentPageNumber}">
            <span class="current-page">${i}</span>
          </c:when>
          <c:otherwise>
            <button class="pagination-link" data-page="${i}">${i}</button>
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </div>
    </div>

<!-- footer -->
<jsp:include page="/WEB-INF/views/Components/footer.jsp" />



<!-- 스크립트 부분 -->
   <!-- 이미지 슬라이드 JS -->
   <script>
     var swiper = new Swiper(".mySwiper", {
       loop: true,
       spaceBetween: 10,
       slidesPerView: 4,
       freeMode: true,
       watchSlidesProgress: true,
     });
     var swiper2 = new Swiper(".mySwiper2", {
       loop: true,
       spaceBetween: 10,
       navigation: {
         nextEl: ".custom-next-button", 
         prevEl: ".custom-prev-button", 
       },
       thumbs: {
         swiper: swiper,
       },
     });
   </script>
 
   <script type="text/javascript">
   	var memberEmail = "${sessionScope.member.m_email}";
       var memberNickname = "${sessionScope.memberNickname}";
       var memberId = "${sessionScope.memberId}";
       var contentid = "${hotplace.contentid}"; // contentid를 JSP에서 전달받아 정의

   </script>
   
   <c:if test="${not empty message}">
     <script>
         alert("${message}");
     </script>
   </c:if>
   
   
   <!-- 좋아요 버튼 함수 -->
<script>
  // likeButton이라는 id를 가진 버튼을 선택
  const likeButton = document.getElementById('likeButton');

  // 버튼이 클릭되었을 때 실행할 함수
  likeButton.addEventListener('click', function () {
    // 현재 이미지 요소를 선택
    const likeImage = document.getElementById('likeImage');
    
    // 이미지 경로를 확인하고, 이미지를 교체하는 로직
    if (likeImage.src.includes('heart.png')) {
      likeImage.src = '${pageContext.request.contextPath}/resources/images/heart_color.png'; // 하트가 눌렸을 때 이미지 변경
      alert("'좋아요'를 누르셨습니다.");
    } else {
      likeImage.src = '${pageContext.request.contextPath}/resources/images/heart.png'; // 다시 원래 하트로
      alert("'좋아요'가 취소되었습니다.");
    }
  });
</script>    

<script type="text/javascript">
   // 세션에 저장된 로그인 정보가 있는지 확인하여 JavaScript 변수에 저장
   var isLoggedIn = <c:out value="${not empty sessionScope.member ? 'true' : 'false'}" />;

   // 로그인 여부에 따른 경고 메시지와 폼 제출 처리
   document.getElementById('saveForm').addEventListener('submit', function(event) {
       if (!isLoggedIn) {
           // 로그인되지 않은 경우 경고 메시지와 로그인 페이지로 리다이렉트
           event.preventDefault();  // 폼 제출을 막음
           alert('로그인이 필요합니다!');
           window.location.href = '${pageContext.request.contextPath}/Member/login';  // 로그인 페이지로 이동
       } else {
           // 로그인된 경우에만 저장 작업 진행
           alert('저장 목록에 추가되었습니다!');
       }
   });
</script>



<!-- 5일 3시간 간격 -->
<script>
window.onload = function() {
    var lat = parseFloat('${hotplace.mapy}');
    var lon = parseFloat('${hotplace.mapx}');
    var apiKey = '3e865753bd8625e5661275515b2f320c';
    var url = 'https://api.openweathermap.org/data/2.5/forecast?lat=' + lat + '&lon=' + lon + '&appid=' + apiKey + '&units=metric&lang=kr';

    $.getJSON(url, function(data) {
        console.log("API 응답 데이터:", data);

        var forecastList = data.list;
        var baseTemp = Math.round(forecastList[0].main.temp); // 첫 번째 항목의 온도를 기준으로 설정
        var points = []; // 점 좌표를 저장할 배열

        forecastList.slice(0, 40).forEach(function(forecast, index) {
            var dateTime = forecast.dt_txt;
            var temp = Math.round(forecast.main.temp);
            var icon = forecast.weather[0].icon;

            // 시간별로 낮과 밤 구분
            var hour = parseInt(dateTime.slice(11, 13));
            if (hour >= 18 || hour < 7) {
                icon = icon.replace('d', 'n');
            } else {
                icon = icon.replace('n', 'd');
            }

            // 사용자 정의 아이콘 경로 설정
            var customIconUrl = getCustomIconUrl(icon);

            // 온도 차이에 따라 점의 위치 계산 (1도당 2px 이동)
            var tempDifference = temp - baseTemp; // 기준 온도와의 차이
            var topOffset = -tempDifference * 2; // 1도당 2px 위로 이동 (기준 온도보다 높으면 위로, 낮으면 아래로)

            // 리스트 항목 생성
            var li = document.createElement('li');
            li.innerHTML =
                '<div class="temp">' + temp + '°</div>' +
                '<span class="dot" style="top: ' + (40 + topOffset) + 'px;"></span>' + // 점의 위치 조정
                '<div class="icon"><img src="' + customIconUrl + '" alt="weather-icon"></div>' +
                '<div class="time">' + dateTime.slice(11, 16) + '</div>' +
                '<div class="date">' + dateTime.slice(5, 10) + '</div>' +
                '<div class="day">' + getDayOfWeek(dateTime) + '</div>'; // 요일 표시

            // 리스트에 추가
            document.querySelector('.temperature-list').appendChild(li);
        });

        // dot이 그려진 후, 좌표를 찾아 선을 그리는 작업 실행
        setTimeout(function() {
	    var dots = document.querySelectorAll('.temperature-list .dot');
	    var points = [];
	
	    // 각 dot 요소의 위치를 계산
	    dots.forEach(function(dot, index) {
	        var rect = dot.getBoundingClientRect();  // 요소의 좌표 정보 얻기
	        //var xPos = rect.left + (rect.width / 2); // 중앙 x 좌표 계산
	        //var yPos = rect.top + (rect.height / 2); // 중앙 y 좌표 계산 (window.scrollY 제거)
	        
	        var xPos = rect.x;
	        var yPos = rect.y;
	       
	        
	        // 좌표 저장
	        points.push({ x: xPos, y: yPos });
	        //points.push({ x: rect.x, y: rect.y });
	 		
	        //쌤이 알려주신 console.log
	        //console.log("x:"+rect.x+",y:"+rect.y);
	        //console.log(`Dot ${index + 1}: X = ${rect.x}, Y = ${rect.y}`);
	        
	    });
	
	    // 점들을 이음
	    drawLines(points);
	    
	}, 0); // 1초 후에 좌표 계산 시작 (렌더링 후 지연 시간)
    });
    
    // 선 그리는 함수
    function drawLines(points) {
        var canvas = document.getElementById('weatherCanvas');
        var ctx = canvas.getContext('2d');
        
        //Canvas 크기, 위치 가져오기
    	var canvasRect = canvas.getBoundingClientRect(); // canvas의 화면 내 위치 가져오기
        
        //캔버스 크기 console
        //console.log("Canvas width: " + canvas.width + ", height: " + canvas.height);
        ctx.clearRect(0, 0, canvas.width, canvas.height); // 기존 선을 지움
        ctx.translate(0, 2); // 전체 Y 좌표를 1px 아래로 이동


        // 선 그리기
        if (points.length > 0) {
            ctx.beginPath();
            
            // 첫 번째 점으로 이동 (캔버스 좌표계로 변환 + 1px 아래로 이동)
            ctx.moveTo(points[0].x - canvasRect.left, points[0].y - canvasRect.top);

            // 각 점으로 선을 그림
            for (var i = 1; i < points.length; i++) {
            	//어디서부터 선 그렸는지 console.log
                //console.log(`Drawing line to Point ${i + 1}: X = ${points[i].x}, Y = ${points[i].y}`);
                ctx.lineTo(points[i].x - canvasRect.left, points[i].y - canvasRect.top);
            }
            
            ctx.strokeStyle = '#D5D5D5'; // 선 색상
            ctx.lineWidth = 2;	//선 굵기
            ctx.stroke();
        }
    }
};

    // 요일 계산 함수
    function getDayOfWeek(dateTime) {
        var daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
        var dateObj = new Date(dateTime);
        return daysOfWeek[dateObj.getDay()];
    }

    // 아이콘 커스텀 함수
    function getCustomIconUrl(iconCode) {
        var iconMap = {
            '01d': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt1.svg',
            '01n': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt2.svg',
            '02d': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt3.svg',
            '02n': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt6.svg',
            '03d': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt5.svg',
            '03n': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt6.svg',
            '04d': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt7.svg',
            '04n': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt6.svg',
            '09d': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt9.svg',
            '10d': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt22.svg',
            '11d': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt18.svg',
            '13d': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt11.svg',
            '50d': 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/weather_new_new/img/weather_svg_v2/icon_flat_wt17.svg'
        };

        return iconMap[iconCode] || 'https://example.com/icons/default-icon.png';
    }
    
    

</script>

<script>

document.addEventListener('DOMContentLoaded', function() {
    var prevButton = document.getElementById('prevButton');
    var nextButton = document.getElementById('nextButton');
    var container = document.querySelector('.temperature-container');  // 스크롤할 컨테이너

    prevButton.addEventListener('click', function() {
        console.log("Prev Button Clicked");
        if (container) {
            container.scrollBy({ left: -300, behavior: 'smooth' });  // 왼쪽으로 300px 스크롤
        }
    });

    nextButton.addEventListener('click', function() {
        console.log("Next Button Clicked");
        if (container) {
            container.scrollBy({ left: 300, behavior: 'smooth' });  // 오른쪽으로 300px 스크롤
        }
    });
});


</script>






</body>
</html>
