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
        
        <h3>${member.m_nickname}</h3>
        
         
<a href="${pageContext.request.contextPath}/Member/m_updateProfile">
    <button>프로필 편집</button>
</a>
</div>
</div>

<div class="profile-container">
    <div class="profile-form-container">
        <form action="updateProcess" method="post" enctype="multipart/form-data">
           <!-- 프로필 이미지 표시 및 변경 -->
    <div class="profile-image-section">
       <%-- 프로필 이미지가 없으면 기본이미지 --%>
       <c:if test="${empty member.m_profile}" >
           <img src="${pageContext.request.contextPath}${member.m_profile}" id="profileImage">
       </c:if>
       <%-- 프로필 이미지가 있으면 이미지 --%>
       <c:if test="${!empty member.m_profile}" >
           <img src = "${pageContext.request.contextPath}${member.m_profile}" id="profileImage">
       </c:if>
   </div>
   <span id="deleteImage">x</span>

   <div class="profile-btn-area">
       <label for="imageInput">이미지 선택</label>
       <input type="file" name="profileImage" id="imageInput" accept="image/*">
  
   </div>
    </div>

    <!-- 회원 식별 정보 -->
    <input type="hidden" name="m_idx" value="${member.m_idx}">
    
    <!-- 이메일 (읽기 전용) -->
    <label for="m_email">이메일</label>
    <input type="text" id="m_email" name="m_email" value="${member.m_email}" readonly><br>
    
    <!-- 비밀번호 -->
    <label for="m_password">비밀번호</label>
    <input type="password" id="m_password" name="m_password" ><br>
    
  
    <label for="confirmPassword">비밀번호 확인</label>
    <input type="password" id="confirmPassword" name="confirmPassword" ><br>
  

    <!-- 닉네임 -->
    <label for="m_nickname">닉네임</label>
    <input type="text" id="m_nickname" name="m_nickname" value="${member.m_nickname}"><br>
    
    <!-- 오류 메시지 처리 -->
    <c:if test="${not empty passwordValidationError}">
        <p style="color:red;">${passwordValidationError}</p>
    </c:if>
    <c:if test="${not empty passwordError}">
        <p style="color:red;">${passwordError}</p>
    </c:if>
    <c:if test="${not empty nicknameError}">
        <p style="color:red;">${nicknameError}</p>
    </c:if>
    <c:if test="${not empty generalError}">
        <p style="color:red;">${generalError}</p>
    </c:if>
    
    
    <!-- 제출 버튼 -->
    <input type="submit" value="변경하기">
    
            <!-- 취소 버튼 -->
            <input type="button" value="취소하기" onclick="location.href='../MyPage/myPageMain'">
            <p>
    		<a href="javascript:cancel()">회원 탈퇴</a>
				</p>
        </form>
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
