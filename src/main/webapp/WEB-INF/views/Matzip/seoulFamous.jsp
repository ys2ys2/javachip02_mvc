<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page errorPage="errorPage.jsp" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.XML" %>


    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>BBOL BBOL BBOL</title>
         <!-- 상대 경로를 사용한 css링크-->   
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> <!-- header.css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css"> <!-- footer.css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/famous.css"> <!-- famouse.css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- icon.css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
    </head>

    <body>
    <!-- 어두운 배경 -->
  <div class="overlay"></div>
	<!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />
  
<div class="t_minibody">
  <!-- 타이틀 -->
  <div class="t_title-container">
     <%-- <c:forEach var="event" items="${events}" varStatus="vs"> 행사 데이터를 여러개 가겨올 때 사용하는 반복문--%>
	      <h2>제목 : ${matzips[0].NAME_KOR}</h2> <!-- EL로 제목 표시 -->
	      <h3>장소 : ${matzips[0].ADD_KOR_ROAD}</h3> <!-- EL로 장소 표시 -->
	      <h4>소제목 : 일식</h4>
  </div>

<!-- 아이콘 추가: 좋아요, 댓글, 공유하기 -->
<div class="t_social-icons">
  <i class="fa-solid fa-comment-dots"></i><span class="icon-text">${commentCount}</span> <!-- 댓글 아이콘 -->
  <i class="fa-solid fa-heart"></i><span class="icon-text">${likeCount}</span> <!-- 좋아요 아이콘 -->
  <i class="fa-solid fa-share-alt"></i><span class="icon-text">${shareCount}</span> <!-- 공유하기 아이콘 -->
</div>

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
           <button class="prev1" onclick="plusSlides(-1)">&#10094;</button>
           <div class="slider">
           <img src=" ${matzips[0].CATE1_NAME}" alt="이미지" class="slide">
           </div>
           <button class="next1" onclick="plusSlides(1)">&#10095;</button>
			</div>


 <div id="details" class="t_details_title">
      <span>상세정보</span>
    </div>
    
    <div id="eventDetails">
  <p><strong>카테고리:</strong> ${matzips[0].CATE1_NAME}</p> 
  <p><strong>음식점 이름:</strong> ${matzips[0].NAME_KOR}</p>   
   <p><strong>음식점 주소:</strong> ${matzips[0].ADD_KOR_ROAD}</p>
  <p><strong>음식점 연락처:</strong> ${matzips[0].RES_CONTACT}</p>
  <p><strong>카테고리:</strong> ${matzips[0].CATE3_NAME}</p>
	</div>
    
    <!-- 공공데이터 받아올 장소 -->

  <!-- 댓글 더보기 -->
  <div class="t_details_more">
    <a href="#">내용 더보기 +</a>
  </div>

  
<!-- 구글 맵 부분(지도 부분) -->
<div id="location" class="location-section">
    <p>위치</p> 
       <!-- 지도 API -->
            <div id="googleMap" style="width: 100%;height: 700px;"></div>

		<script>
		   function myMap(){
		      var mapOptions = { 
		            center:new google.maps.LatLng(37.51148310935, 127.06033711446),
		            zoom:16
		      };
		 
		      var map = new google.maps.Map( 
		             document.getElementById("googleMap") 
		            , mapOptions );
		   }
		</script> 
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDso1zI7icUyAIp2AWJkdk0SyZrm4u3jmo&callback=myMap"></script>
        </div>
        <!-- https://maps.googleapis.com/maps/api/js?key= 인증키 &callback=myMap -->

<%-- 댓글 작성 폼 --%>
<div class="comment-form">
    <div class="textarea-container">
        <%-- 로그인한 경우 --%>
        <c:if test="${not empty member}">
            <%-- POST 방식으로 댓글 전송하는 form --%>
          <form id="commentForm" action="/Matzip/secomments" method="post">
                <%-- 댓글 내용 입력 --%>
                <textarea id="commentContent" name="comment" placeholder="소중한 댓글을 남겨주세요."></textarea>

                <%-- m_idx 값을 hidden 필드로 전송 --%>
              <input type="hidden" name="m_idx" value="${member.m_idx}">
                
                <%-- 댓글 등록 버튼 --%>
                <button type="button" class="comment-submit" 
                		data-m_idx="${member.m_idx}" 
                		data-t_sm_idx="${matzips[0].t_sm_idx}">등록</button>
            </form>
        </c:if>

        <%-- 로그인하지 않은 경우 --%>
        <c:if test="${empty member}">
            <textarea id="commentContent" placeholder="로그인 후 소중한 댓글을 남겨주세요." disabled></textarea>
            <button type="button" class="comment-submit">등록</button>
        </c:if>
    </div>
</div>

<%-- 댓글 버튼 및 댓글 수 --%>
<div id="comments" class="h_talk">
    <button class="comment-button">
        <i class="fa-solid fa-comment-dots"></i>
        <span>댓글</span>
        <span class="comment-count"><c:out value="${commentCount}" /></span> 
    </button>
</div>

<%-- 댓글 목록 --%>
<div class="comments-section">
    <c:choose>
        <%-- 로그인 여부 확인 --%>
        <c:when test="${not empty sessionScope.member}">
            <%-- 로그인한 경우에만 댓글 목록 표시 --%>
            <c:choose>
                <c:when test="${not empty commentsList}">
                    <c:forEach var="comment" items="${commentsList}">
                        <div class="comment">
                            <div class="user-info">
                                <img src="${contextPath}/resources/images/2.jpg" 
                                     alt="${comment.t_smc_author_id}" 
                                     class="de">
                                <span class="username">
                                    <c:out value="${comment.t_smc_author_id}" />
                                </span>

                                <span class="date">
                                    <c:choose>
                                        <c:when test="${not empty comment.t_smc_created_at}">
                                            <fmt:formatDate value="${comment.t_smc_created_at}" pattern="yyyy-MM-dd" />
                                        </c:when>
                                        <c:otherwise>
                                            날짜 정보 없음
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <p><c:out value="${comment.t_smc_content}" /></p>
                            
							<%-- 댓글 액션 버튼: 답글, 수정, 삭제 --%>
                            <div class="comment-actions">
                                <%-- 댓글 수정 및 삭제 버튼: 로그인한 사용자만 본인의 댓글 수정 및 삭제 가능 --%>
                                <c:if test="${comment.t_smc_author_id == sessionScope.member.m_idx}">
                                    <button type="button" class="comment-edit" 
                                            data-t_smc_author_id="${comment.t_smc_author_id}"
                                            data-t_smc_idx="${comment.t_smc_idx}"> 
                                        수정
                                    </button>
                                    <button type="button" class="comment-delete" 
                                            data-t_smc_author_id="${comment.t_smc_author_id}"
                                            data-t_smc_idx="${comment.t_smc_idx}">
                                        삭제
                                    </button>
                                </c:if>
                            </div>

                            <%-- 답글 아이콘 --%>
                            <i class="fa-solid fa-comment-dots"></i> 
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>댓글이 없습니다. 첫 번째 댓글을 작성해 주세요!</p>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <p>로그인 후 댓글을 작성할 수 있습니다.</p>
        </c:otherwise>
    </c:choose>
</div>


<!-- JavaScript 변수 설정을 위한 스크립트 블록 -->
<script>
  var isLoggedIn = ${sessionScope.member != null}; // 로그인 상태 확인 (Boolean 값으로 설정)
  var memberId = "<c:out value='${sessionScope.member != null ? sessionScope.member.m_idx : ""}'/>"; // 로그인된 사용자 ID
  var eventId = "<c:out value='${not empty itemList ? itemList[0].title : ""}'/>"; // 이벤트 ID
  var contextPath = "<c:out value='${pageContext.request.contextPath}'/>"; // 컨텍스트 경로
</script>

        <!-- 댓글 더보기 -->
        <div class="more-comments">
            <a href="#">댓글 더보기 +</a>
        </div>
        
  <!-- 근처 행사 추천 섹션 -->
  <div class="recommendations">
    <h3>근처 행사 추천 👍</h3>
    <div class="recommendation-images">
      <!-- 행사 추천 사진들 -->
      <img src="${pageContext.request.contextPath}/resources/images/2.jpg" alt="행사1">
      <img src="${pageContext.request.contextPath}/resources/images/2.jpg" alt="행사2">
      <img src="${pageContext.request.contextPath}/resources/images/2.jpg" alt="행사3">
    </div>
  </div>
</div>



<!-- footer -->
<jsp:include page="/WEB-INF/views/Components/footer.jsp" />
<!-- 메인 스크립트 -->
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script> <!-- header.js -->
<script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script> <!-- lang-toggle.js -->
<script src="${pageContext.request.contextPath}/resources/js/famous.js"></script> <!-- famous.js -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
//댓글 작성 함수

//jQuery 이용
 $(function(){

	$(".comment-submit").on("click", function(){
	
		alert("등록버튼 실행");
		
		if (isLoggedIn==="false") {//로그인이 안된 경우
	        alert("로그인 후 댓글을 작성할 수 있습니다.");
	        redirectToLogin();
	        return;
  		 }
   		 
	  	 const commentContent = $('#commentContent').val();
	  	 const m_idx = $(this).data('m_idx');// data-m_idx의 속성값 가져오기
	  	 const t_sm_idx = $(this).data('t_sm_idx');//맛집 ID
	  	 
	  	 if (commentContent.trim() === "") {
		        alert("댓글을 입력하세요.");
		        return;
		 }
	    
	    $.ajax({
	    	type: "post",
	    	url: "comments",
	    	data: { m_idx: m_idx, 
      			    comment: commentContent,
      			    t_sm_idx: t_sm_idx
      		},
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
/* function loadComments() {
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
 */
 
//댓글 수정 버튼 이벤트
$(".comment-edit").on("click", function(){
	const t_smc_idx = $(this).data('t_smc_idx'); // data-t_smc_idx 속성에서 댓글 ID 가져오기
	const t_smc_author_id = $(this).data('t_smc_author_id'); //행사 댓글 작성자 ID
	const newCommentContent = prompt("수정할 댓글 내용을 입력하세요:");

	if (newCommentContent !== null && newCommentContent.trim() !== "") {
		$.ajax({
			type: "post",
			url: "editComment", // URL 수정
			data: {
				commentId: t_smc_idx,  // 서버에서 t_smc_idx를 commentId로 받음
				newComment: newCommentContent,
				authorId: t_smc_author_id
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

//댓글 삭제 버튼 이벤트
$(".comment-delete").on("click", function(){
	const t_smc_idx = $(this).data('t_smc_idx'); // 행사 댓글번호 가져오기
	const t_smc_author_id = $(this).data('t_smc_author_id'); //행사 댓글 작성자 ID
	console.log("t_smc_idx: ", t_smc_idx);
	console.log("t_smc_author_id: ", t_smc_author_id);
	

	if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
		$.ajax({
			type: "post",
			url: "deleteComment", // URL 수정
			data: {
				t_smc_idx: t_smc_idx,
				t_smc_author_id: t_smc_author_id
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




  const swiper = new Swiper('.swiper', {
    slidesPerView: 10,
    spaceBetween: 30,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    loop: true
  });
</script>

    </body>

    </html>
    
    
    
    
    
    
    
 
    