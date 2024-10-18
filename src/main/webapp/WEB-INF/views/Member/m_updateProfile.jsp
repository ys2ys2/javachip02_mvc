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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_updateProfile.css"> 
<title>회원정보 변경</title>
</head>
<body>
 <div class="overlay"></div>

  <header>
    <div class="header-container">
      <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
      <nav>
        <ul>
          <li><a href="#" data-ko="홈" data-en="Home">홈홈</a></li>
          <li><a href="#" data-ko="커뮤니티" data-en="Community">커뮤니티</a></li>
          <li><a href="#" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
          <li><a href="#" data-ko="여행뽈뽈" data-en="BBOL BBOL BBOL">여행뽈뽈</a></li>
          <button class="search-btn">
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
          <button class="user-btn">
            <i class="fa-solid fa-user"></i>
          </button>
          <button class="earth-btn">
            <i class="fa-solid fa-earth-americas"></i>
          </button>
          <button class="korean" id="lang-btn" data-lang="ko">English</button>
        </ul>
      </nav>
    </div>
  </header>
  <!-- 상단 네비게이션 -->
  <div class="navigation">
     <a href="${pageContext.request.contextPath}/MyPage/m_myTrips">내 여행</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myJourneys">내 여행기</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_savedList">저장목록</a>
   	 <a href="${pageContext.request.contextPath}/MyPage/m_commentManagement">댓글관리</a>
</div>



    <!-- 왼쪽 프로필 영역 -->
    <div class="profile-section">
    <h4>My BBOL BBOL BBOL</h4>
        <div class="profile-card">
               <img src="${member.m_profile}" alt="프로필 사진" class="profile-image">
        
        <h3>${member.m_nickname}</h3>
            <p>팔로워: 0 | 팔로잉: 0</p>
            <!-- 프로필 편집 버튼 (JavaScript로 페이지 이동) -->
<a href="${pageContext.request.contextPath}/Member/m_updateProfile">
    <button>프로필 편집</button>
</a>
</div>
</div>

<div class="profile-container">
    <!-- enctype을 추가하여 파일 업로드 가능하도록 설정 enctype="multipart/form-data"-->
    <div class="profile-form-container">
        <form method="post" action="updateProcess" >
       <%--     <!-- 프로필 이미지 표시 및 변경 -->
    <div class="profile-image-section">
        <img src="${member.m_profile}" alt="프로필 사진" class="profile-image" style="width:150px;height:150px;border-radius:50%;"><br>
        <label for="m_profileImage">프로필 이미지 변경:</label>
        <input type="file" id="m_profile" name="m_profile"><br>
    </div>
 --%>
    <!-- 회원 식별 정보 -->
    <input type="hidden" name="m_idx" value="${member.m_idx}">
    
    <!-- 이메일 (읽기 전용) -->
    <label for="m_email">이메일:</label>
    <input type="text" id="m_email" name="m_email" value="${member.m_email}" readonly><br>
    
    <!-- 비밀번호 -->
    <label for="m_password">비밀번호:</label>
    <input type="password" id="m_password" name="m_password" value="${member.m_password}"><br>
    
    <!-- 닉네임 -->
    <label for="m_nickname">닉네임:</label>
    <input type="text" id="m_nickname" name="m_nickname" value="${member.m_nickname}"><br>
    <!-- 중복된 닉네임 메시지를 표시 -->
    <c:if test="${not empty msg}">
        <p style="color:red;">${msg}</p> <!-- 오류 메시지 빨간색으로 표시 -->
    </c:if>
    <!-- 제출 버튼 -->
    <input type="submit" value="변경하기">
    
            <!-- 취소 버튼 -->
            <input type="button" value="취소하기" onclick="location.href='../index.do'">
            <p>
    		<a href="javascript:cancel()">회원 탈퇴</a>
				</p>
        </form>
    </div>
</div>

<br>

<!-- 회원정보 변경 실패 시 오류 메시지 출력 -->
<c:if test="${not empty msg}">
    <p> ${msg} </p>
</c:if>

<script>
    // 회원 탈퇴 확인
    function cancel(){
        const answer = confirm("정말 회원탈퇴 하겠습니까?");
        if(answer){
            location.href = "cancelProcess.do";
        }
    }
</script>

</body>
</html>
