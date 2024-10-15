<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
          <li><a href="${pageContext.request.contextPath}/HotPlace/hotplace2">여행지</a></li>
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
  <!-- 상단 네비게이션 -->
  <div class="navigation">
     <a href="${pageContext.request.contextPath}/MyPage/m_myTrips">내 여행</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myJourneys">내 여행기</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_savedList">저장목록</a>
   	 <a href="${pageContext.request.contextPath}/MyPage/m_commentManagement">댓글관리</a>
</div>

<div class="container">

    <!-- 왼쪽 프로필 영역 -->
    <div class="profile-section">
    <h4>My BBOL BBOL BBOL</h4>
        <div class="profile-card">
            <img src="${pageContext.request.contextPath}/resources/images/profile.jpg" alt="프로필 사진" class="profile-image">
            <h3>박옥수수</h3>
            <p>팔로워: 0 | 팔로잉: 0</p>
            <button onclick="openProfileModal()">프로필 편집</button>
        </div>
    </div>
<%-- <!-- 모달 창 잠시만 주석 -->
<div id="profileModal" class="modal">
    <div class="modal-content">
        <h2>내 프로필 편집</h2>

        <form id="profileForm" enctype="multipart/form-data">
            <!-- 프로필 이미지 변경 -->
            <label for="profileImage">프로필 이미지</label>
            <input type="file" id="profileImage" name="profileImage">
            
            <!-- 닉네임 변경 -->
            <label for="nickname">닉네임*</label>
            <input type="text" id="nickname" name="nickname" value="${member.m_nickname}" onkeyup="checkNickname(this.value)">
            <span id="nicknameStatus"></span>

          
            <button type="button" onclick="updateProfile()">확인</button>
        </form>

        <button onclick="closeProfileModal()">취소</button>
    </div>
</div> --%>
    <!-- 오른쪽 콘텐츠 영역 -->
    <div class="content-section">

        <!-- 다가오는 여행과 내 여행기 (두 개가 나란히 위치) -->
        <div class="top-content">
            <!-- 다가오는 여행 -->
            <div id="my-trips" class="upcoming-trips">
                <h2>다가오는 여행</h2>
               <button class="black-button">일정 추가</button>
                <div class="content-box"></div>
            </div>

            <!-- 내 여행기 -->
            <div id="my-journeys" class="my-journeys">
                <h2>내 여행기</h2>
                <button class="black-button">글쓰기</button>
                <div class="content-box"></div>
            </div>
        </div>

        <!-- 지난 여행과 나의 저장목록 (두 개가 나란히 위치) -->
        <div class="middle-content">
            <!-- 지난 여행 -->
            <div id="my-past-trips" class="past-trips">
                <h2>지난 여행</h2>
                <div class="content-box"></div>
            </div>

            <!-- 나의 저장목록 -->
            <div id="my-saved-list" class="my-saved-list">
                <h2>나의 저장목록</h2>
                <div class="content-box"></div>
            </div>
        </div>

      	<!-- 추천 핫플레이스 섹션 -->
			<div class="m_hotplaces">
		    <h2>BBOL BBOL BBOL 추천 핫플레이스</h2>
		
		    <!-- 콘텐츠를 보여줄 content-box -->
		    <div class="m_content-box">
		        <!-- c:forEach를 사용하여 m_mypageList를 반복 처리 -->
		        <c:forEach var="mypage" items="${m_mypageList}">
		            <div class="m_hotplace-item">
		                <!-- 이미지 출력 (firstimage) -->
		                <img src="${mypage.firstimage}" alt="${mypage.title}">
		
		                <!-- 제목 출력 (title) -->
		                <h3>${mypage.title}</h3>
		            </div>
		        </c:forEach>
		        
		    </div>
		</div>
</div>
</div>
</body>
   <script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/m_profile.js"></script>
</html>