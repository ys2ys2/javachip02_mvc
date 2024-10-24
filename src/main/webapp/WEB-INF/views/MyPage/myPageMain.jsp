<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPageMain.css"> 
<title>마이페이지 메인</title>
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
          <li><a href="${pageContext.request.contextPath}/HotPlace/banner2">여행지</a></li>
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
            <span><a href="${pageContext.request.contextPath}/Member/join">회원가입</a></span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>
  
  <!-- 상단 네비게이션 -->
  <div class="navigation">
   	<a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지 홈</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myTrips">내 여행</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myJourneys">내 게시글</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_savedList">저장목록</a>
</div>


     <!-- 왼쪽 프로필 영역 -->
    <div class="profile-section">
    <h4>My BBOL BBOL BBOL</h4>
        <div class="profile-card">
               <img src="${pageContext.request.contextPath}${member.m_profile}" alt="프로필 사진" class="profile-image">
        
        <h3 class="nickname-header">${member.m_nickname}</h3>
        
       <div class="profile-edit-container">  
<a href="${pageContext.request.contextPath}/Member/m_updateProfile"class="profile-edit-link" >
    <i class="fas fa-pencil-alt"></i> 프로필 편집
</a>
</div>
</div>
</div>

  <!-- 오른쪽 콘텐츠 영역 -->
<div class="content-section-custom">

    <!-- 여행 섹션: 다가오는 여행과 지난 여행 -->
    <div class="travel-section">
        <!-- 다가오는 여행 -->
        <div class="section-upcoming-trips">
            <h3 class="upcoming-trips-title">다가오는 여행</h3>
            <button class="add-trip-btn" onclick="location.href='${pageContext.request.contextPath}/TripSched/tripSched'">일정 추가</button>
            <c:if test="${not empty latestUpcomingTrip}">
                <div class="upcoming-trip-item">
                    <p>${latestUpcomingTrip.t_title}</p>
                    <p> 
                        <fmt:formatDate value="${latestUpcomingTrip.period_start}" pattern="yyyy-MM-dd" /> - 
                        <fmt:formatDate value="${latestUpcomingTrip.period_end}" pattern="yyyy-MM-dd" />
                    </p>
                </div>
            </c:if>
            <c:if test="${empty latestUpcomingTrip}">
                <p class="no-upcoming-trip-message">다가오는 여행이 없습니다.</p>
            </c:if>
        </div>

        <!-- 지난 여행 -->
        <div class="section-past-trips">
            <h3 class="past-trips-title">지난 여행</h3>
            <c:if test="${not empty latestPastTrip}">
                <div class="latest-past-trip">
                    <p>여행 제목: ${latestPastTrip.t_title}</p>
                    <p>여행 기간: 
                        <fmt:formatDate value="${latestPastTrip.period_start}" pattern="yyyy-MM-dd" /> - 
                        <fmt:formatDate value="${latestPastTrip.period_end}" pattern="yyyy-MM-dd" />
                    </p>
                </div>
            </c:if>
            <c:if test="${empty latestPastTrip}">
                <p class="no-past-trip-message">지난 여행 기록이 없습니다.</p>
            </c:if>
        </div>
    </div>

   <!-- 내 게시물과 나의 저장목록을 감싸는 컨테이너 -->
<div class="post-and-saved-container">
    <!-- 내 게시물 섹션 -->
    <div class="my-journeys-custom">
        <h3 class="my-journeys-title">내 게시글</h3>
        <button class="my-journeys-btn">글쓰기</button>
        <div class="my-journeys-list">
            <c:if test="${not empty savedPostList}">
                <c:forEach var="post" items="${savedPostList}">
                    <div class="post-item-custom">
                        <div class="post-header-custom">
                            <div class="post-writer-custom">${post.postWriter}</div>
                            <div class="post-date-custom">${post.postDate}</div>
                        </div>
                        <div class="post-content-custom">${post.postContent}</div>
                        <div class="post-footer-custom">
                            <span class="post-like-count"><i class="fa fa-heart"></i> ${post.likeCount}</span>
                            <span class="post-comment-count"><i class="fa fa-comment"></i> ${post.commentCount}</span>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>

    <!-- 나의 저장목록 섹션 -->
    <div class="m_content-section-header-custom">
        <c:if test="${not empty savedList}">
            <div class="m_saved-list-custom">
                <h3>나의 저장목록</h3>
                <c:forEach var="item" items="${savedList}">
                    <div class="m_saved-item-custom">
                        <img src="${item.firstimage}" alt="${item.title}" class="m_saved-image-custom">
                        <div class="m_saved-info-custom">
                            <h4 class="saved-title-custom">${item.title}</h4>
                            <p class="saved-likes-custom">❤ ${item.likes}</p>
                            <p class="saved-addr-custom">${item.addr1}</p>
                        </div>
                    </div>
                    <hr>
                </c:forEach>
            </div>
        </c:if>
    </div>
</div>

    <!-- 추천 핫플레이스 섹션 -->
    <div class="m_hotplaces-custom">
        <h2 class="hotplaces-title-custom">BBOL BBOL BBOL 추천 핫플레이스</h2>
        <div class="m_content-box-custom">
            <c:forEach var="hotplace" items="${hotplaceList}">
                <div class="m_hotplace-item-custom">
                    <img src="${hotplace.firstimage}" alt="${hotplace.title}" class="hotplace-image-custom">
                    <h3 class="hotplace-title-custom">${hotplace.title}</h3>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<%-- <%-- <!-- 푸터 부분 --> 
<footer>
  <div class="footer-container">
    <!-- 회사소개 섹션 -->
    <div class="footer-section">
      <h4>회사소개</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/introduce" target="_blank">회사소개</a></li>
        <li><a href="${pageContext.request.contextPath}/HotPlace/inputApi" target="_blank">공공데이터 API</a></li>
      </ul>
    </div>

    <!-- 고객지원 섹션 -->
    <div class="footer-section">
      <h4>고객지원</h4>
      <ul>
        <li><a href="#">공지사항</a></li>
        <li><a href="#">자주묻는 질문</a></li>
        <li><a href="#">문의하기</a></li>
      </ul>
    </div>

    <!-- 이용약관 섹션 -->
    <div class="footer-section">
      <h4>이용약관</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/clause" target="_blank">이용약관</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank">개인정보처리방침</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/marketing" target="_blank">광고성 정보 수신동의</a></li>
      </ul>
    </div>

    <!-- 회사 정보 섹션 -->
    <div class="footer-company-info">
      <p>상호: (주)BBOL | 대표: 박예슬 | 사업자등록번호: 123-45-67890 | 통신판매업 신고번호: 2024-충남천안-00000 | 개인정보관리 책임자: 수수옥</p>
      <p>주소: 충청남도 천안시 동남구 123 | 이메일: support@BBOL3.com | 대표전화: 02-1234-5678</p>
      <p>© 2024 BBOLBBOLBBOL. All Rights Reserved.</p>
    </div>

    <!-- 소셜 미디어 섹션 -->
    <div class="footer-social">
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-facebook-f"></i></a>
      <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
  </div>
</footer>
<!-- 푸터 끝 --> --%>

</body>
</html>