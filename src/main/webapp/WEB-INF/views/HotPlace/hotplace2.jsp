<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import="java.net.URL, java.net.URLEncoder, java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="com.human.web.jdbc.DBCP" %>

<%@ page import="java.util.List" %>
<%@ page import="com.human.web.vo.TalkVO, com.human.web.repository.TalkDAO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <fmt:setTimeZone value="UTC" />



<%

	int currentPageNumber = 1; // 기본 페이지 (변수명 변경)
	int commentsPerPage = 10; // 페이지당 댓글 수
	
    // 요청으로부터 현재 페이지 번호를 가져오기
    if (request.getParameter("page") != null) {
        currentPageNumber = Integer.parseInt(request.getParameter("page"));
    }

    int offset = (currentPageNumber - 1) * commentsPerPage;
    
    
    // 데이터베이스 연결 변수
    DBCP dbcp = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 데이터 리스트 생성
    List<Map<String, String>> itemList = new ArrayList<>();
    List<TalkVO> talkList = new ArrayList<>();


    int totalComments = 0;
    try {
        // DBCP 객체 생성
        dbcp = new DBCP();
        Connection conn = dbcp.conn;  // DBCP를 통해 가져온 커넥션 객체
        
        // 전체 댓글 수 가져오기
        String countSql = "SELECT COUNT(*) AS total FROM talk";
        pstmt = conn.prepareStatement(countSql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalComments = rs.getInt("total");
        }

        int totalPages = (int) Math.ceil((double) totalComments / commentsPerPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPageNumber", currentPageNumber);
        request.setAttribute("totalTalkCount", totalComments);		// 전체 댓글 수를 request에 저장


        // SQL 쿼리 작성 및 실행
        // LIMIT 1 = 첫번째 행 결과값 반환, OFFSET 2 = 0행,1행 건너뛰고 2행 결과 가져오기 (테이블 3번째 값)
        String sql = "SELECT title, addr1, overview, firstimage, mapx, mapy FROM hotplace LIMIT 1 OFFSET 2";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        // 결과 처리
        while (rs.next()) {
            // 각 항목을 Map으로 저장
            Map<String, String> itemData = new HashMap<>();
            itemData.put("title", rs.getString("title"));				// 제목
            itemData.put("addr1", rs.getString("addr1"));				// 주소
            itemData.put("overview", rs.getString("overview"));			// 설명
            itemData.put("firstimage", rs.getString("firstimage"));		// 이미지
            itemData.put("mapx", rs.getString("mapx"));					// 경도
            itemData.put("mapy", rs.getString("mapy"));					// 위도
            itemList.add(itemData);
        }

        // 데이터 request에 저장
        request.setAttribute("itemList", itemList);
        
        // 댓글 데이터 가져오기 (페이지네이션, 10개씩)
        // 작성 날짜, 수정 날짜 중 GREATEST를 써서 더 큰 날짜로(최신)
        String talkSql = "SELECT * FROM talk ORDER BY GREATEST(talk_created_at, talk_updated_at) DESC LIMIT ? OFFSET ?";
        
		pstmt = conn.prepareStatement(talkSql);
        pstmt.setInt(1, commentsPerPage);
        pstmt.setInt(2, offset);

        rs = pstmt.executeQuery();
        
        while (rs.next()) {
            TalkVO talk = new TalkVO();
            talk.setTalkIdx(rs.getInt("talk_idx"));
            talk.setTalkNickname(rs.getString("talk_nickname"));
            talk.setTalkEmail(rs.getString("talk_email"));
            talk.setTalkText(rs.getString("talk_text"));
            talk.setTalkCreatedAt(rs.getTimestamp("talk_created_at"));
            talk.setTalkUpdatedAt(rs.getTimestamp("talk_updated_at"));
            talkList.add(talk);
        }

        // 댓글 데이터 request에 저장
        request.setAttribute("talkList", talkList);


    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 자원 해제
        if (dbcp != null) {
            dbcp.close(); // 모든 자원을 반환하는 close() 메서드 호출
        }
    }
    
%>



<%-- <%
    // TalkDAO 객체 생성
    TalkDAO talkDAO = new TalkDAO();
    // 모든 댓글 가져오기
    List<TalkDTO> talkList = talkDAO.getAllTalks();
    request.setAttribute("talkList", talkList); // request에 talkList 저장
%> --%>




<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" /> <!-- slick css -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/hotplace.css"> <!-- hotplace.css -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> <!-- header.css -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css"> <!-- footer.css-->

  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBGXfM-W2P67M4VmuJdGHedKT73_rMEWQ&callback=initMap" async defer></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/googlemap.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/section.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/br.js"></script>
  

  
  <title>함께 떠나는 핫플 여행! 2페이지</title>

</head>

<body>

  <!-- 어두운 배경 -->
  <div class="overlay"></div>
  <div class="overlay" onclick="toggleSharePopup()"></div>

  <header>
    <div class="header-container">
      <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
      <nav>
        <ul>
          <li><a href="../HomePage/mainpage.jsp" data-ko="홈" data-en="Home">홈</a></li>
          <li><a href="#" data-ko="커뮤니티" data-en="Community">커뮤니티</a></li>
          <li><a href="#" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
          <li><a href="#" data-ko="여행뽈뽈" data-en="BBOL BBOL BBOL">여행뽈뽈</a></li>
          <button class="search-btn">
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
		  <button class="user-btn" onclick="location.href='${pageContext.request.contextPath}/Login/login'">
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
  


  <div class="h_minibody">
    <!-- 타이틀 -->
    <div class="h_title-container">
	    <c:forEach var="item" items="${itemList}">
	        <h2>${item.title}</h2> <!-- 제목 -->
	        <h3>${item.addr1}</h3> <!-- 장소 -->
	       <!--  <h4>${item.title}</h4> 소제목 -->
	    </c:forEach>
    </div>
    <div class="h_icons">
      <button class="h_button">
        <img src="${pageContext.request.contextPath}/resources/images/heart.png" alt="likes">
      </button>
      <button class="f_button">
        <img src="${pageContext.request.contextPath}/resources/images/favorite.png" alt="favorite">
      </button>
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


    <!-- 본문 -->
    
	<!-- 사진 보기 섹션 (메인 슬라이드) -->
	<div id="section-photos" class="h_content">
		<div class="swiper mySwiper2">
		  <div class="swiper-wrapper">
		    <c:forEach var="item" items="${itemList}">
		      <c:set var="imageArray" value="${fn:split(item.firstimage, ',')}" />
		      <c:forEach var="imgUrl" items="${imageArray}">
		        <div class="swiper-slide">
		          <img src="${fn:trim(imgUrl)}" alt="핫플 이미지" />
		        </div>
		      </c:forEach>
		    </c:forEach>
		  </div>
		 <!-- 슬라이드 좌,우 이미지 버튼 -->
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
		    <c:forEach var="item" items="${itemList}">
		      <c:set var="imageArray" value="${fn:split(item.firstimage, ',')}" />
		      <c:forEach var="imgUrl" items="${imageArray}">
		        <div class="swiper-slide">
		          <img src="${fn:trim(imgUrl)}" alt="핫플 썸네일 이미지" />
		        </div>
		      </c:forEach>
		    </c:forEach>
		  </div>
		</div>
	</div>



    <div id="section-details" class="h_details_title">
      <span>상세정보</span>
    </div>
    <div class="h_details">
        <c:forEach var="item" items="${itemList}">
            <p id="description-text">${item.overview}</p>
        </c:forEach>
    </div>
    

	<!-- 구글 맵 -->
    <div id="map" class="h_map">
      <div class="google_map"></div>
    </div>
    

	<%-- 댓글 리스트를 request에 이미 저장함: talkList --%>
	<c:set var="commentCount" value="${fn:length(talkList)}" />

	<!-- 여행톡 부분 -->
	<div id="section-talk" class="h_talk">
	    <h2>여행톡 <span>${totalTalkCount}</span></h2> <!-- totalTalkCount 출력 -->
	</div>
  	
    <div class="comment-form">
	<%-- 사용자 정보가 세션에 있는지 확인 --%>
	<c:choose>
	    <c:when test="${not empty sessionScope.memberNickname}">
	        <!-- 로그인된 사용자가 댓글 작성 가능 -->
	        <textarea id="commentText" placeholder="소중한 댓글을 남겨주세요."></textarea>
	        <div class="form-actions">
	            <button class="login-button" id="submitButton">작성하기</button>
	        </div>
	    </c:when>
	    <c:otherwise>
	        <!-- 로그인되지 않은 경우 -->
	        
	        <a href="${pageContext.request.contextPath}/Login/login" onclick="alert('로그인 해 주시길 바랍니다!');">
            <textarea id="commentText" placeholder="로그인 후 소중한 댓글을 남겨주세요." readonly onclick="redirectToLogin()"></textarea>
            </a>
	    </c:otherwise>
	</c:choose>

	</div>

<div class="comments-section">
    <c:forEach var="talk" items="${talkList}">
        <div class="comment" data-talk-id="${talk.talkIdx}">
            <div class="user-info">
                <img src="${pageContext.request.contextPath}/resources/images/user-placeholder.png" alt="user">
                <span class="username">${talk.talkNickname}</span>
                <span class="date">
                    <fmt:formatDate value="${talk.talkUpdatedAt != null ? talk.talkUpdatedAt : talk.talkCreatedAt}" pattern="yyyy-MM-dd HH:mm" />
                </span>
            </div>
            <p class="comment-text">${talk.talkText}</p>
            <textarea class="edit-comment-text" style="display:none;">${talk.talkText}</textarea> <!-- 수정용 텍스트 에어리어 -->
            
<%--             <!-- 디버깅을 위한 이메일 출력 -->
            <c:out value="로그인한 이메일: ${sessionScope.memberEmail}"/><br>
            <c:out value="DB에 저장된 이메일: ${talk.talkEmail}"/> --%>

            <div class="comment-actions">
                <c:if test="${sessionScope.memberEmail == talk.talkEmail}">
                    <button class="delbtn" data-talk-id="${talk.talkIdx}">삭제하기</button>
                    <button class="editbtn" data-talk-id="${talk.talkIdx}">수정하기</button>
                </c:if>
                <button class="cancelbtn" data-talk-id="${talk.talkIdx}" style="display:none;">취소하기</button>
                <button class="savebtn" data-talk-id="${talk.talkIdx}" style="display:none;">저장하기</button> 
            </div>
        </div>
    </c:forEach>
</div>
</div>


<!-- 페이지네이션 -->
<div class="pagination">
    <!-- 페이지 번호 링크 생성 -->
    <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
            <c:when test="${i == currentPageNumber}">
                <span class="current-page">${i}</span> <!-- 현재 페이지는 링크 없이 표시 -->
            </c:when>
            <c:otherwise>
                <!-- 페이지 번호를 클릭할 때 AJAX로 데이터를 불러오게 data-page 속성 추가 -->
                <button class="pagination-link" data-page="${i}">${i}</button>
            </c:otherwise>
        </c:choose>
    </c:forEach>
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
    <c:forEach var="item" items="${itemList}" varStatus="status">
        if (${status.first}) {
            mapx = parseFloat("${item.mapx}");
            mapy = parseFloat("${item.mapy}");
            firstimage = '${fn:split(item.firstimage, ",")[0]}'; // DB의 쉼표중 첫번째[0] 이미지만 가져오기
        }
    </c:forEach>
</script>
	
	
  <!-- 공공데이터 이미지 슬라이드 js -->
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
	    nextEl: ".custom-next-button", // 커스텀 "다음" 버튼 연결
	    prevEl: ".custom-prev-button", // 커스텀 "이전" 버튼 연결
	  },
      thumbs: {
        swiper: swiper,
      },
    });
    
  </script>
  


</body>
</html>
