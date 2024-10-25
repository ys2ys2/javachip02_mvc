<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디, 비밀번호 찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="${pageContext.request.contextPath}/resources/css/m_findId.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
   
    <script type="text/javascript">
        // 라디오 버튼 선택에 따라 다른 폼을 보여줌
        
        function toggleForm() {
            var type = document.querySelector('input[name="findType"]:checked').value;
            document.getElementById("idForm").style.display = (type === 'id') ? 'block' : 'none';
            document.getElementById("passwordForm").style.display = (type === 'password') ? 'block' : 'none';
        }

        // 이메일 인증번호 전송 함수
        function email_ok(email) {
            var contextPath = "${pageContext.request.contextPath}";
            
            if (!email || email === "") {
                alert("이메일을 입력하세요.");
                return;
            }

            $.ajax({
                type: "POST",
                url: contextPath + "/mailSend",  // 이메일 인증번호 전송 URL 수정
                data: { receiver: email },
                dataType: "text",
                success: function(response) {
                    if (response === "이메일 전송 성공") {
                        alert("이메일이 성공적으로 전송되었습니다.");
                    } else {
                        alert("이메일 전송에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.log("AJAX 오류:", error);
                }
            });
        }

        // 인증번호 확인 함수
        function verifyCode() {
            var contextPath = "${pageContext.request.contextPath}";
            var inputCode = document.getElementById("authCode").value;
            
            $.ajax({
                type: "POST",
                url: contextPath + "/verifyCode",  // 인증번호 확인 URL 수정
                data: { authCode: inputCode, 
                },
                success: function(response) {
                    if (response === "success") {
                        alert("인증이 완료되었습니다.");
                        document.getElementById("submitBtn").disabled = false; // 비밀번호 재설정 버튼 활성화
                        document.getElementById("newPasswordSection").style.display = "block"; // 비밀번호 재설정 폼 보이기
                    } else {
                        alert("인증번호가 일치하지 않습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    alert("인증번호 확인 중 오류가 발생했습니다.");
                }
            });
        }
    </script>
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

    <!-- 아이디 찾기와 비밀번호 찾기 선택 -->
   <div class="radio-group">
   <input type="radio" name="findType" value="id" id="findId" onclick="toggleForm()" checked>
   <label for="findId">아이디 찾기</label>

   <input type="radio" name="findType" value="password" id="findPassword" onclick="toggleForm()">
   <label for="findPassword">비밀번호 찾기</label>
</div>

    <div id="idForm">
        <form action="${pageContext.request.contextPath}/Member/findIdProcess" method="post">
            <!-- 가입 경로 선택 -->
            <label for="m_registration_type">가입 경로</label>
            <select name="m_registration_type" id="m_registration_type">
                <option value="email">이메일</option>
                <option value="kakao">카카오</option>
                <option value="naver">네이버</option>
                <option value="google">구글</option>
            </select>

            <label for="m_nickname">닉네임</label>
            <input type="text" name="m_nickname" id="m_nickname" placeholder="닉네임을 입력하세요.">

            <button type="submit">아이디 찾기</button>
        </form>

        <!-- 찾은 아이디가 있을 경우 출력 -->
       <c:if test="${not empty foundId}">
    <p class="custom-text">찾은 아이디: ${foundId}</p>
</c:if>

    </div>

    <!-- 비밀번호 찾기 폼 -->
    <div id="passwordForm" style="display:none;">
        <form action="${pageContext.request.contextPath}/Member/sendVerificationCode" method="post">
            <!-- 이메일 입력 -->
            <input type="email" id="email" name="m_email" placeholder="이메일을 입력하세요">
            <button type="button" onclick="email_ok(document.getElementById('email').value)">인증번호 전송</button>
        </form>

        <!-- 인증번호 입력 및 확인 -->
        <div id="verificationSection" style="margin-top: 20px;">
            <input type="text" id="authCode" placeholder="인증번호를 입력하세요">
            <button type="button" onclick="verifyCode()">인증번호 확인</button>
            <p id="verificationStatus"></p> <!-- 인증 상태를 표시할 영역 -->
        </div>
		<!-- 비밀번호 재설정 폼 (인증 성공 시에만 보임) -->
		<div id="newPasswordSection" style="display:none;">
		    <form action="${pageContext.request.contextPath}/Member/resetPassword" method="post">
		        <div>
		            <input type="password" name="newPassword" placeholder="새로운 비밀번호를 입력하세요" required>
		            <c:if test="${not empty passwordValidationError}">
		                <p class="error-message">${passwordValidationError}</p> <!-- 에러 메시지 표시 -->
		            </c:if>
		        </div>
		        <div>
		            <input type="password" name="confirmPassword" placeholder="비밀번호 확인" required>
		      
		        </div>
		        <button type="submit" id="submitBtn" disabled>비밀번호 재설정</button>
		    </form>
		</div>
    </div>

<c:if test="${passwordResetSuccess eq true}">
    <script type="text/javascript">
        alert("비밀번호 재설정이 완료되었습니다. 다시 로그인해주세요!");
    </script>
</c:if>



    <!-- 에러 메시지가 있을 경우 팝업으로 출력 -->
<c:if test="${not empty errorMessage}">
    <script type="text/javascript">
        alert("${errorMessage}");
    </script>
</c:if>

    
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
