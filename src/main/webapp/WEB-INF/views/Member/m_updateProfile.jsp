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
<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_updateProfile.css"> 
<title>회원정보 변경</title>
</head>
<body>

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
                <span class="userprofile"><img src="${pageContext.request.contextPath}${member.m_profile}" alt="user-profile"></span>
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

<div class="profile-container">
    <div class="profile-form-container">
        <form action="updateProcess" method="post" enctype="multipart/form-data">
            <!-- 프로필 이미지 표시 및 변경 -->
            <div class="profile-image-section">
                <!-- 프로필 이미지가 없으면 기본이미지 -->
                <c:if test="${empty member.m_profile}">
                    <img src="${pageContext.request.contextPath}${member.m_profile}" id="profileImage">
                </c:if>
                <!-- 프로필 이미지가 있으면 이미지 -->
                <c:if test="${!empty member.m_profile}">
                    <img src="${pageContext.request.contextPath}${member.m_profile}" id="profileImage">
                </c:if>
            </div>

		        <div class="profile-btn-area">
		    <label for="imageInput" class="profile-image-label">
		        <i class="fas fa-camera"></i> <!-- Font Awesome 아이콘 추가 -->
		    </label>
		    <input type="file" name="profileImage" id="imageInput" accept="image/*">
		</div>

            <!-- 회원 식별 정보 -->
            <input type="hidden" name="m_idx" value="${member.m_idx}">
            
            <!-- 이메일 (읽기 전용) -->
            <label for="m_email" class="profile-label">이메일</label>
            <input type="text" id="m_email" name="m_email" class="profile-input" value="${member.m_email}" readonly><br>

            <!-- 비밀번호 -->
            <label for="m_password" class="profile-label">비밀번호</label>
            <input type="password" id="m_password" name="m_password" class="profile-input"><br>

            <label for="confirmPassword" class="profile-label">비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="profile-input"><br>

            <!-- 닉네임 -->
            <label for="m_nickname" class="profile-label">닉네임</label>
            <input type="text" id="m_nickname" name="m_nickname" class="profile-input" value="${member.m_nickname}"><br>
            
            <!-- 오류 메시지 처리 -->
            <c:if test="${not empty passwordValidationError}">
                <p class="error-message">${passwordValidationError}</p>
            </c:if>
            <c:if test="${not empty passwordError}">
                <p class="error-message">${passwordError}</p>
            </c:if>
            <c:if test="${not empty nicknameError}">
                <p class="error-message">${nicknameError}</p>
            </c:if>
            <c:if test="${not empty generalError}">
                <p class="error-message">${generalError}</p>
            </c:if>

           <!-- 제출 및 취소 버튼 -->
            <div class="button-group">
                <input type="submit" class="profile-submit-btn" value="변경하기">
                <input type="button" class="profile-cancel-btn" value="취소하기" onclick="location.href='../MyPage/myPageMain'">
            </div>
            <p>
                <a href="javascript:cancel()" class="profile-delete-link">회원 탈퇴</a>
            </p>
        </form>
    </div>
</div>

<!-- 프로필 이미지 미리보기 JavaScript -->
<script>
    document.getElementById('imageInput').addEventListener('change', function(event) {
        var file = event.target.files[0]; // 선택한 파일 가져오기
        if (file) {
            var reader = new FileReader(); // 파일을 읽기 위한 FileReader 객체 생성
            reader.onload = function(e) {
                document.getElementById('profileImage').src = e.target.result; // img 태그의 src를 새 이미지로 변경
            };
            reader.readAsDataURL(file); // 파일을 Data URL로 변환하여 이미지로 읽기
        }
    });
</script>

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
<!-- 푸터 부분 -->
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h4>회사소개</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/introduce" target="_blank">회사소개</a></li>
        <li><a href="${pageContext.request.contextPath}/HotPlace/inputApi"target="_blank">공공데이터 API</a></li>
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
        <li><a href="${pageContext.request.contextPath}/FooterPage/clause" target="_blank">이용약관</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank">개인정보처리방침</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/marketing" target="_blank">광고성 정보 수신동의</a></li>
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
</body>
</html>
