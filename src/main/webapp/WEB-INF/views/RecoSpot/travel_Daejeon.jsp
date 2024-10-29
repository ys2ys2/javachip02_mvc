<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>BBOL BBOL BBOL</title>
         <!-- 상대 경로를 사용한 css링크-->   
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/travel.css">

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
    </div>
</div>

              
            <!-- 푸터 아래 3개의 박스 -->
            <div class="footer-boxes">
              <!-- 박스 1 -->
              <div class="footer-box">
                <div class="event-box">행사</div>
                <div class="event-content">
                  <div class="event-title">잠수교 뚜벅뚜벅 축제</div>
                  <div class="event-description">
                    한강에서 힐링 어때요?<br>
                    선선한 가을에 힐링 나들이 즐겨요
                  </div>
                  <a href="#" class="more-info">자세히보기 &gt;</a>
                </div>
              </div>
            
              <!-- 박스 2 -->
              <div class="footer-box">
                <div class="event-box">행사</div>
                <div class="event-content">
                  <div class="event-title">잠수교 뚜벅뚜벅 축제</div>
                  <div class="event-description">
                    한강에서 힐링 어때요?<br>
                    선선한 가을에 힐링 나들이 즐겨요
                  </div>
                  <a href="#" class="more-info">자세히보기 &gt;</a>
                </div>
              </div>
            
              <!-- 박스 3 -->
              <div class="footer-box">
                <div class="event-box">행사</div>
                <div class="event-content">
                  <div class="event-title">잠수교 뚜벅뚜벅 축제</div>
                  <div class="event-description">
                    한강에서 힐링 어때요?<br>
                    선선한 가을에 힐링 나들이 즐겨요
                  </div>
                  <a href="#" class="more-info">자세히보기 &gt;</a>
                </div>
              </div>
            </div>

<jsp:include page="journal_Daejeon.jsp" />


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
<!-- 메인 스크립트 -->
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/travel.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>


    </body>

    </html>