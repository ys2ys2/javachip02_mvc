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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">

  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBGXfM-W2P67M4VmuJdGHedKT73_rMEWQ&callback=initMap" async defer></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/googlemap.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/section.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/br.js"></script>
  <title>최신 여행지! ${matzip.title}</title>
</head>

<body>


  <!-- 어두운 배경 -->
  <div class="overlay"></div>
  <!-- header -->
  <jsp:include page="/WEB-INF/views/Components/header.jsp" />

  <div class="h_minibody">
    <!-- 타이틀 -->
    <div class="h_title-container">
        <h2>${matzip.title}</h2> <!-- 제목 -->
        <h3>${matzip.addr1}</h3> <!-- 장소 -->
        
        <!-- mapx와 mapy 값을 자바스크립트로 전달 -->
        <script type="text/javascript">
            var mapx = "${matzip.mapx}";
            var mapy = "${matzip.mapy}";
            var firstimage = "${matzip.firstimage}";
        </script>
    </div>
    <div class="h_icons">
		<!-- 좋아요 버튼 -->
		<button class="h_button" id="likeButton">
		  <img src="${pageContext.request.contextPath}/resources/images/heart.png" alt="likes" id="likeImage">
		</button>
		<!-- 저장하기 버튼 -->
		<form id="saveForm" action="${pageContext.request.contextPath}/hotplace/save" method="post">
		    <input type="hidden" name="contentid" value="${matzip.contentid}" /> <!-- contentid 전달 -->
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
        <li class="h_nav-item"><a href="#" data-target="section-talk">여행톡</a></li>
        <li class="h_nav-item"><a href="#" data-target="section-recommend">추천여행</a></li>
      </ul>
    </div>

	<!-- 사진 보기 섹션 (메인 슬라이드) -->
	<div id="section-photos" class="h_content">
	    <div class="swiper mySwiper2">
	        <div class="swiper-wrapper">
	            <!-- firstimage 필드를 쉼표로 나누어 배열로 처리 -->
	            <c:set var="imageArray" value="${fn:split(matzip.firstimage, ',')}" />
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
      <span>상세정보</span>
    </div>
    <div class="h_details">
        <p id="description-text">${matzip.overview}</p>
    </div>

    <!-- 구글 맵 -->
    <div id="map" class="h_map">
      <div class="google_map"></div>
    </div>

    <!-- 여행톡 부분 -->
    <div id="section-talk" class="h_talk">
      <h2>여행톡 <span>${totalTalkCount}</span></h2>
    </div>

    <div class="comment-form">
      <c:choose>
        <c:when test="${not empty sessionScope.member.m_nickname}">
          <!-- 로그인된 사용자가 댓글 작성 가능 -->
			<form action="${pageContext.request.contextPath}/Matzip/insert" method="post">
			<input type="hidden" name="contentid" value="${matzip.contentid}"> <!-- contentid -->
			<input type="hidden" name="type" value="matzip">	<!-- type까지 추가 -->
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
            <img src="${pageContext.request.contextPath}${member.m_profile}" alt="user-profile">
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
        var memberEmail = "${sessionScope.memberEmail}";
        var memberNickname = "${sessionScope.memberNickname}";
        var memberId = "${sessionScope.memberId}";
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
    


</body>
</html>
