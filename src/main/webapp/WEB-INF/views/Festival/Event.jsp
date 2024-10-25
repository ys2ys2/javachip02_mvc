<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>BBOL BBOL BBOL</title>
         <!-- 상대 경로를 사용한 css링크-->   
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> <!-- header.css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css"> <!-- footer.css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Event.css"> <!-- Event.css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- icon.css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
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
          <li><a href="${pageContext.request.contextPath}/Community/c_main">커뮤니티</a></li>
          <li><a href="${pageContext.request.contextPath}/HotPlace/hotplace2">여행지</a></li>
          <li><a href="${pageCOntext.request.contextPath}/TravelSpot/TravelSpot">여행뽈뽈</a></li>
          <li><a href="${pageContext.request.contextPath}/TripSched/tripSched">여행일정</a></li>
        </ul>
      </nav>
      <div class="member">
        <c:choose>
          <c:when test="${not empty member}">
            <!-- 로그인 성공 시, 마이페이지와 로그아웃 표시 -->
            <div class="welcome">
            	<span class="userprofile"><img src="${member.m_profile}" alt="user-profile"></span>
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
  
<div class="t_minibody">
  <!-- 타이틀 -->
  <div class="t_title-container">
    <h2>삼원가든</h2>
    <h3>서울 강남구</h3>
    <h4>일상 속 귀한 만남이 모여 잔치가 되는 곳</h4>
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
  <img src="${pageContext.request.contextPath}/resources/images/1.png" alt="삼원가든" class="slide">
   <img src="${pageContext.request.contextPath}/resources/images/2.jpg" alt="삼원가든1" class="slide">
   <img src="${pageContext.request.contextPath}/resources/images/3.jpg" alt="삼원가든2" class="slide">
   <img src="${pageContext.request.contextPath}/resources/images/1.png" alt="삼원가든3" class="slide">
  </div>
  <button class="next1" onclick="plusSlides(1)">&#10095;</button>
</div>


 <div id="details" class="t_details_title">
      <span>상세정보</span>
    </div>
    
    
    <!-- 공공데이터 받아올 장소 -->

   <!-- 댓글 더보기 -->
  <div class="t_details_more">
    <a href="#">내용 더보기 +</a>
  </div>


  
<!-- 구글 맵 부분(지도 부분) -->
<div id="location" class="location-section">
    <p>위치</p> 
</div>
   

<!-- 댓글 작성 폼 -->
<div class="comment-form">
  <div class="textarea-container">
    <textarea placeholder="로그인 후 소중한 댓글을 남겨주세요."></textarea>
    <button class="comment-submit">등록</button> <!-- 등록 버튼을 텍스트 영역 안에 위치시킴 -->
  </div>
  <div class="form-actions">
    <button class="login-button">로그인</button>
  </div>
</div>

<div id="comments" class="h_talk">
  <!-- 댓글 아이콘과 댓글 텍스트가 버튼 형태로 표시 -->
  <button class="comment-button">
    <i class="fa-solid fa-comment-dots"></i>
    <span>댓글</span>
    <span class="comment-count">2</span> <!-- 댓글 수 표시 -->
  </button>
</div>


  <!-- 댓글 섹션 -->
  <div class="comments-section">
    <!-- 첫 번째 댓글 -->
    <div class="comment">
      <div class="user-info">
          <img src="${pageContext.request.contextPath}/resources/images/2.jpg" alt="장꼬맹" class="de">
        <span class="username">장꼬맹</span>
        <span class="date">2024.10.02</span>
      </div>
      <p>멍멍</p>
      <div class="comment-actions">
        <!-- 좋아요 및 답글 아이콘 추가 -->
        <i class="fa-solid fa-thumbs-up"></i> 좋아요
        <i class="fa-solid fa-comment-dots"></i> 답글
      </div>
    </div>

    <!-- 두 번째 댓글 -->
    <div class="comment">
      <div class="user-info">
       <img src="${pageContext.request.contextPath}/resources/images/2.jpg" alt="장보리" class="des">
        <span class="username">보리</span>
        <span class="date">2024.10.02</span>
      </div>
      <p>야옹</p>
      <div class="comment-actions">
        <!-- 좋아요 및 답글 아이콘 추가 -->
        <i class="fa-solid fa-thumbs-up"></i> 좋아요
        <i class="fa-solid fa-comment-dots"></i> 답글
      </div>
    </div>
  </div>

  <!-- 댓글 더보기 -->
  <div class="more-comments">
    <a href="#">댓글 더보기 +</a>
  </div>

  <!-- 근처 행사 추천 섹션 -->
  <div class="recommendations">
    <h3>근처 행사 추천 👍</h3>
    <div class="recommendation-images">
      <!-- 행사 추천 사진들 -->
      <img src="${pageContext.request.contextPath}/resources/images/T_6.png" alt="행사1">
      <img src="${pageContext.request.contextPath}/resources/images/T_6.png" alt="행사2">
      <img src="${pageContext.request.contextPath}/resources/images/T_6.png" alt="행사3">
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
        </div>
</footer>
<!-- 메인 스크립트 -->
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script> <!-- header.js -->
<script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script> <!-- lang-toggle.js -->
<script src="${pageContext.request.contextPath}/resources/js/famous.js"></script>	<!-- famous.js -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
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
    
    