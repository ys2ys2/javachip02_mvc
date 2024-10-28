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

 <!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />
  
  
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
   <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />
</body>
</html>
