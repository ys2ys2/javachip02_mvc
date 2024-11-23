<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.human.web.vo.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import="java.net.URL, java.net.URLEncoder" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.io.IOException" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ page import="java.net.URL, java.net.URLEncoder, java.net.HttpURLConnection" %>

 <%! 
	//JSON 필드 값을 추출하는 메서드
	private static String getFieldValue(String json, String fieldName) {
	   int start = json.indexOf("\"" + fieldName + "\":");
	   if (start == -1) return null;
	
	   start = json.indexOf(":", start) + 1;
	   int end = json.indexOf(",", start);
	   if (end == -1) end = json.indexOf("}", start);
	
	   return json.substring(start, end).replaceAll("[\"{}]", "").trim();
	}
 
 %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BBOL BBOL BBOL</title>
    <!-- 상대 경로를 사용한 CSS 링크 -->   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> <!-- header.css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css"> <!-- footer.css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Event.css?v=1.0"> <!-- Event.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
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

<!-- 공공데이터 가져와서 화면에 출력하는 부분: eventsList로 가져옴 -->

    <div class="t_minibody">
        <div class="t_title-container">
         <%-- <c:forEach var="event" items="${events}" varStatus="vs"> 행사 데이터를 여러개 가겨올 때 사용하는 반복문--%>
	      <h2>제목 : ${events[0].TITLE}</h2> <!-- EL로 제목 표시 -->
	      <h3>장소 : ${events[0].GUNAME}</h3> <!--  EL로 장소 표시 -->
	      <h4>소제목 : 서울일러스트레이션페어 V.18</h4>
	        </div>
	
<div class="h_icons">
    <!-- 왼쪽 섹션 (좋아요 버튼) -->
    <div class="left-icons">
        <button class="h_button" id="likeButton">
            <img src="${pageContext.request.contextPath}/resources/images/heart.png" alt="likes" id="likeImage">
        </button>
    </div>

    <!-- 오른쪽 섹션 (저장하기, 공유하기 버튼) -->
    <div class="right-icons">
        <!-- 저장하기 버튼 -->
        <form id="saveForm" action="${pageContext.request.contextPath}/hotplace/save" method="post">
            <input type="hidden" name="contentid" value="${dataplace.contentid}" />
            <button type="submit" class="f_button">
                <img src="${pageContext.request.contextPath}/resources/images/favorite.png" alt="favorite">
            </button>
        </form>
        
        <!-- 공유하기 버튼 -->
        <button class="s_button" onclick="toggleSharePopup()">
            <img src="${pageContext.request.contextPath}/resources/images/share.png" alt="share">
        </button>
    </div>
</div>

<!-- 공유 팝업 -->
<div id="sharePopup" style="display: none; position: absolute; top: 50px; right: 50px; padding: 10px; background-color: #fff; border: 1px solid #ddd;">
    <p>공유할 플랫폼을 선택하세요:</p>
    <button onclick="shareToPlatform('facebook')">Facebook</button>
    <button onclick="shareToPlatform('twitter')">Twitter</button>
    <button onclick="shareToPlatform('kakaotalk')">KakaoTalk</button>
</div>

<script>
  const likeButton = document.getElementById('likeButton');
  const sharePopup = document.getElementById('sharePopup');

  // 좋아요 버튼 기능
  likeButton.addEventListener('click', function () {
    const likeImage = document.getElementById('likeImage');
    
    if (likeImage.src.includes('heart.png')) {
      likeImage.src = '${pageContext.request.contextPath}/resources/images/heart_color.png';
      alert("'좋아요'를 누르셨습니다.");
    } else {
      likeImage.src = '${pageContext.request.contextPath}/resources/images/heart.png';
      alert("'좋아요'가 취소되었습니다.");
    }
  });

  // 공유 팝업 토글 기능
  function toggleSharePopup() {
    if (sharePopup.style.display === "none") {
      sharePopup.style.display = "block";
    } else {
      sharePopup.style.display = "none";
    }
  }

  // 공유 기능
  function shareToPlatform(platform) {
    alert(platform + "에 공유합니다!");
    // 실제 공유 기능 코드 추가 가능
    toggleSharePopup(); // 공유 후 팝업 닫기
  }
</script>

	        
 		<%-- </c:forEach> --%>
        <!-- 네비바 부분 -->
        <div class="t_section-container">
            <ul class="t_navbar">
                <li class="t_nav"><a href="#photos" data-target="photos">사진</a></li>
                <li class="t_nav"><a href="#details" data-target="details">상세정보</a></li>
                <li class="t_nav"><a href="#location" data-target="location">위치</a></li> 
                <li class="t_nav"><a href="#comments" data-target="comments">댓글</a></li>
            </ul>
        </div>

        <div id="photos" class="slider-container">
            <div class="slider">
               <img src="${events[0].MAIN_IMG}" alt="이미지" class="slide">
            </div>
        </div>

        <div id="details" class="t_details_title">
            <span>상세정보</span>
        </div>
        
<div id="eventDetails">
    <div class="details-left">
         <p class="two-line-link">
          <span class="bullet">•</span><strong>예약 사이트 주소:</strong>
          <a href="${events[0].ORG_LINK}" target="_blank" class="link-wrap">
            https://booking.naver.com<br>
            <span class="indented-link">/booking/5/bizes/16695</span>
          </a>
    </p>
    <p><span class="bullet">•</span> <strong>전시 종류:</strong> ${events[0].CODENAME}</p>
        <p><span class="bullet">•</span> <strong>예약 시작:</strong> ${events[0].RGSTDATE}</p>
    </div>
    <div class="details-right">
        <p><span class="bullet">•</span> <strong>날짜:</strong> ${events[0].DATE}</p>
        <p><span class="bullet">•</span> <strong>연령:</strong> ${events[0].USE_TRGT}</p>
        <p><span class="bullet">•</span> <strong>가격:</strong> ${events[0].USE_FEE}</p>
        <p><span class="bullet">•</span> <strong>장소(홀):</strong> ${events[0].PLACE}</p>
    </div>
</div>
   

        <div id="location" class="location-section">
            <p>위치</p>
            <!-- 지도 API -->
            <div id="googleMap" style="width: 100%; height: 500px; border-radius: 15px; overflow: hidden;"></div>

	    <script>
        function myMap() {
            var mapOptions = {
                center: new google.maps.LatLng(37.51148310935, 127.06033711446), // 중심 좌표
                zoom: 16
            };

            var map = new google.maps.Map(document.getElementById("googleMap"), mapOptions);

            // 사용자 지정 마커 아이콘 설정
            var markerIcon = {
                url: "https://maps.google.com/mapfiles/ms/icons/red-dot.png", // 빨간 핀 아이콘 URL
                scaledSize: new google.maps.Size(50, 50) // 아이콘 크기 조정
            };

            // 마커 추가
            var marker = new google.maps.Marker({
                position: { lat: 37.51148310935, lng: 127.06033711446 }, // 마커 위치 좌표
                map: map,
                title: "목적지", // 마커에 나타날 제목
                icon: markerIcon
            });
        }
        
		</script> 
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDso1zI7icUyAIp2AWJkdk0SyZrm4u3jmo&callback=myMap"></script>
        </div>
        <!-- https://maps.googleapis.com/maps/api/js?key= 인증키 &callback=myMap -->
         


<!-- 댓글 작성 폼 -->
<div class="comment-form">
    <div class="textarea-container">
        <!-- 로그인한 경우와 아닌 경우를 같은 구조로 유지 -->
        <c:choose>
            <c:when test="${not empty member}">
                <!-- 로그인한 경우, 입력 가능 -->
                <textarea id="commentContent" name="comment" placeholder="소중한 댓글을 남겨주세요."></textarea>
                <button type="button" class="comment-submit" data-m_idx="${member.m_idx}">등록</button>
            </c:when>
            <c:otherwise>
                <!-- 로그인하지 않은 경우, 비활성화 상태로 표시 -->
                <textarea id="commentContent" placeholder="로그인 후 소중한 댓글을 남겨주세요." disabled></textarea>
                <button type="button" class="comment-submit" disabled>등록</button>
            </c:otherwise>
        </c:choose>
    </div>
</div>


<div class="comments-section">
    <c:choose>
        <c:when test="${not empty commentsList}">
            <c:forEach var="comment" items="${commentsList}">
                <div class="comment">
                    <div class="user-info">
                        <!-- 프로필 이미지 경로를 동적으로 설정 -->
					   <c:choose>
					    <c:when test="${not empty member.m_profile}">
					        <img src="${pageContext.request.contextPath}/${member.m_profile}" 
					             alt="<c:out value='${member.m_nickname}'/>" 
					             class="de">
					    </c:when>
					    <c:otherwise>
					        <img src="${pageContext.request.contextPath}/resources/images/default_profile.jpg" 
					             alt="기본 이미지" 
					             class="de">
					    </c:otherwise>
					</c:choose>

                        <!-- 닉네임을 동적으로 설정 -->
                        <span class="username"><c:out value="${member.m_nickname}" /></span>

                        <span class="date">
                            <c:choose>
                                <c:when test="${not empty comment.t_comment_created_at}">
                                    <fmt:formatDate value="${comment.t_comment_created_at}" pattern="yyyy-MM-dd" />
                                </c:when>
                                <c:otherwise>
                                    날짜 정보 없음
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>


     <p><c:out value="${comment.t_comment_content}" /></p>

                    <!-- 댓글 액션 버튼: 답글, 수정, 삭제 -->
                    <div class="comment-actions">
                      

                        <!-- 댓글 수정 및 삭제 버튼: 로그인한 사용자만 본인의 댓글 수정 및 삭제 가능 -->
                        <c:if test="${comment.t_comment_author_id == member.m_idx}">
                            <button type="button" class="comment-edit" 
                            	    data-t_comment_author_id="${comment.t_comment_author_id}"
                            	    data-t_ec_idx="${comment.t_ec_idx}">
                                수정
                            </button>
                            <button type="button" class="comment-delete" 
                            	    data-t_comment_author_id="${comment.t_comment_author_id}"
                            	    data-t_ec_idx="${comment.t_ec_idx}">
                                삭제
                            </button>
                        </c:if>

                        <i class="fa-solid fa-comment-dots"></i> 
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>댓글이 없습니다. 첫 번째 댓글을 작성해 주세요!</p>
        </c:otherwise>
    </c:choose>
</div>


<!-- JavaScript 변수 설정을 위한 스크립트 블록 -->
<script>
  var isLoggedIn = "${sessionScope.member != null}"; // 로그인 상태 확인
  var memberId = "${sessionScope.member != null ? sessionScope.member.m_idx : ''}"; // 로그인된 사용자 ID
  var eventId = "${itemList[0].title}"; // 이벤트 ID
  var contextPath = "${pageContext.request.contextPath}"; // 컨텍스트 경로
</script>

 
       

      
       <div class="recommendations">
    <div class="festival-slider">
        <!-- 첫 번째 행사 -->
        <div class="festival-slide">
            <a href="${pageContext.request.contextPath}/Festival/Event">
                <img src="${pageContext.request.contextPath}/resources/images/Festival_Seoul2.jpg" alt="Festival Image 1">
            </a>
            <div class="festival-info">
                <h3>파리나무십자가</h3>
                <button class="action-button" data-href="${pageContext.request.contextPath}/Festival/Event2">바로가기</button>
            </div>
        </div>

        <!-- 두 번째 행사 -->
        <div class="festival-slide">
            <a href="${pageContext.request.contextPath}/Festival/Event4">
                <img src="${pageContext.request.contextPath}/resources/images/Festival_Seoul4.png" alt="Festival Image 2">
            </a>
            <div class="festival-info">
                <h3>오페라 갈라</h3>
                <button class="action-button" data-href="${pageContext.request.contextPath}/Festival/Event4">바로가기</button>
            </div>
        </div>

        <!-- 세 번째 행사 -->
        <div class="festival-slide">
            <a href="${pageContext.request.contextPath}/Festival/Event3">
                <img src="${pageContext.request.contextPath}/resources/images/Festival_Seoul3.png" alt="Festival Image 3">
            </a>
            <div class="festival-info">
                <h3>행복의 파랑새</h3>
                <button class="action-button" data-href="${pageContext.request.contextPath}/Festival/Event3">바로가기</button>
            </div>
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

            <div class="footer-section">
                <h4>고객지원</h4>
                <ul>
                    <li><a href="#">공지사항</a></li>
                    <li><a href="#">자주묻는 질문</a></li>
                    <li><a href="#">문의하기</a></li>
                </ul>
            </div>

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
        </div>
</footer>
<!-- 메인 스크립트 -->
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script> <!-- header.js -->
<script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script> <!-- lang-toggle.js -->
<script src="${pageContext.request.contextPath}/resources/js/famous.js"></script>	<!-- famous.js -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/Events.js"></script> --%>
<script>

//댓글 작성 함수

//jQuery 이용

 $(function(){
	 
	 //바로가기 버튼 클릭시 해당 JSP페이지로 이동하기
	 $(".action-button").on("click", function(){
		 const actionBtnHref = $(this).data("href");
		 
		 location.href = actionBtnHref;
		 
	 });
	 
	 
	 

	$(".comment-submit").on("click", function(){
	
		alert("등록버튼 실행");
		
		if (isLoggedIn==="false") {//로그인이 안된 경우
	        alert("로그인 후 댓글을 작성할 수 있습니다.");
	        redirectToLogin();
	        return;
  		 }
   		 
	  	 const commentContent = $('#commentContent').val();
	  	 const m_idx = $(this).data('m_idx');// data-m_idx의 속성값 가져오기
	  	
	  	 if (commentContent.trim() === "") {
		        alert("댓글을 입력하세요.");
		        return;
		 }
	    
	    $.ajax({
	    	type: "post",
	    	url: "comments",
	    	data: { m_idx: m_idx, 
      			    comment: commentContent },
	    	success: function(response){
	    		if(response.trim() === "SUCCESS"){
		    		alert("댓글이 등록되었습니다.");
		    		$('#commentContent').val("");
		    		window.location.reload();//현재 페이지 새로고침
	    		}else{
	    			alert("댓글 등록 실패");
	    		}
	    	},
	    	error: function(){
	    		alert("댓글 등록 중 에러발생");
	    	}
	    
	    
	    });//end of ajax
	
	});

});
// 댓글 목록을 불러오는 함수
function loadComments() {
    $.ajax({
        type: "get",
        url: "commentsList", // 서버에서 댓글 목록 가져오기
        dataType: "json",
        success: function(data) {
        	//댓글 목록을 HTML 양식으로 만들어서 html() 메소드에 인수로 넣어줌
        	console.log("data:"+data);
        	let dataHtml='테스트';
            $("#commentsSection").html(dataHtml); // 댓글 목록을 페이지에 삽입
        },
        error: function() {
            alert("댓글 목록을 불러오는 중 에러 발생");
        }
    });//end of ajax
    
}//end of loadComments

//댓글 삭제 버튼 이벤트
$(".comment-delete").on("click", function(){
	const t_ec_idx = $(this).data('t_ec_idx'); // 행사 댓글번호 가져오기
	const t_comment_author_id = $(this).data('t_comment_author_id'); //행사 댓글 작성자 ID
	console.log("t_ec_idx: ", t_ec_idx);
	console.log("t_comment_author_id: ", t_comment_author_id);
	

	if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
		$.ajax({
			type: "post",
			url: "deleteComment", // URL 수정
			data: {
				t_ec_idx: t_ec_idx,
				t_comment_author_id: t_comment_author_id
			},
			success: function(response){
				if(response.trim() === "SUCCESS"){
					alert("댓글이 삭제되었습니다.");
					window.location.reload();//현재 페이지 새로고침
				} else {
					alert("댓글 삭제 실패");
				}
			},
			error: function(){
				alert("댓글 삭제 중 에러 발생");
			}
		});
	}
});

//댓글 수정 버튼 이벤트
$(".comment-edit").on("click", function(){
	const t_ec_idx = $(this).data('t_ec_idx'); // data-t_ec_idx 속성에서 댓글 ID 가져오기
	const t_comment_author_id = $(this).data('t_comment_author_id'); //행사 댓글 작성자 ID
	const newCommentContent = prompt("수정할 댓글 내용을 입력하세요:");

	if (newCommentContent !== null && newCommentContent.trim() !== "") {
		$.ajax({
			type: "post",
			url: "editComment", // URL 수정
			data: {
				commentId: t_ec_idx,  // 서버에서 t_ec_idx를 commentId로 받음
				newComment: newCommentContent,
				authorId: t_comment_author_id
			},
			success: function(response){
				if(response.trim() === "SUCCESS"){
					alert("댓글이 수정되었습니다.");
					window.location.reload();//현재 페이지 새로고침
					// AJAX로 댓글 목록 다시 불러오기 (비동기 방식)
					//loadComments(); // 댓글 목록 새로고침 함수 호출
				} else {
					alert("댓글 수정 실패");
				}
			},
			error: function(){
				alert("댓글 수정 중 에러 발생");
			}
		});
	} else {
		alert("댓글 내용을 입력해주세요.");
	}
});




  const swiper = new Swiper('.swiper', {
    slidesPerView: 10,
    spaceBetween: 30,
    navigation: {
      next1El: '.swiper-button-next',
      prev1El: '.swiper-button-prev',
    },
    loop: true
  });
  

</script>

    </body>

    </html>
    
    