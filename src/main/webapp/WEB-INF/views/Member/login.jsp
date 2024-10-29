<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- 로그인 페이지: 메인 페이지에서 로그인 버튼이 클릭되면 이 로그인 화면으로 이동함 -->
<!-- 사용자가 로그인 정보를 입력하고, 로그인 버튼을 클릭하면 loginProcess.jsp로 데이터를 전송하는 형태로 작성할 수 있음 -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> <!-- header.css -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css"> <!-- login.css -->
    <title>로그인</title>
</head>
<body>
 <!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />

<div class="login-form-container">
   <h1 class="bbol-logo">BBOL BBOL BBOL</h1>
  <h1 class="bbol-login-title">로그인하고 여행을 시작해 보세요!</h1>
		<form method="post" action="loginProcess" class="bbol-login-form">
        <!-- 이메일 입력 필드 -->
        <label for="email">이메일</label>
        <input type="text" id="email" name="m_email" placeholder="example@bbol.com" required>

        <!-- 비밀번호 입력 필드 -->
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="m_password" placeholder="........" required>

        <!-- 로그인 옵션 및 링크 -->
        <div class="bbol-login-options">
            <label><input type="checkbox"> 로그인 유지</label>
            <a href="${pageContext.request.contextPath}/Member/m_findId">아이디 · 비밀번호 찾기</a>
        </div>

        <!-- 로그인 버튼 -->
        <button type="submit" class="bbol-login-button">로그인</button>

        <!-- 중간의 "또는" 텍스트 -->
        <div class="bbol-divider">
            <span>또는</span>
        </div>

        <!-- SNS 로그인 버튼 -->
        <div class="bbol-sns-buttons">
            <img src="${pageContext.request.contextPath}/resources/images/kakaotalkicon.png" alt="Kakao" class="bbol-sns-icon" id="kakao-login-btn">
            <img src="${pageContext.request.contextPath}/resources/images/navericon.png" alt="Naver" class="bbol-sns-icon" id="naver-login-btn">
            <img src="${pageContext.request.contextPath}/resources/images/googleicon.png" alt="Google" class="bbol-sns-icon" id="google-login-btn">
        </div>

        <!-- 회원가입 유도 -->
        <div class="bbol-signup-prompt">
            아직 회원이 아니신가요? <span onclick="location.href='${pageContext.request.contextPath}/Member/joinmain'">회원가입</span>
        </div>
    </form>
</div>
<c:if test="${not empty msg_del}">
    <script type="text/javascript">
        alert('${msg_del}');  // 서버에서 전달된 메시지를 alert으로 표시
    </script>
</c:if>

  <!-- 로그인 실패 시 오류 메시지 출력 -->
<c:if test="${not empty msg}">
    <script type="text/javascript">
        alert('${msg}');  // 서버에서 전달된 메시지를 alert으로 표시
    </script>
</c:if>
<!-- 로그인 필요 메시지 알림 -->
  <c:if test="${not empty loginMessage}">
      <script>
          alert("${loginMessage}");
      </script>
  </c:if>

    <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />
    
<!-- 카카오 SDK 추가 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
  	<script type="text/javascript">
   
   Kakao.init('490f42bb026448a091429ee1b1c4cb0c');  // 발급받은 JavaScript 키로 초기화
   console.log("Kakao SDK Initialized.");

   // 카카오 로그인 버튼 클릭 시 처리
   document.getElementById("kakao-login-btn").addEventListener("click", function() {
       console.log("카카오 로그인 버튼이 클릭되었습니다.");
       
       // 카카오 로그인 요청
       Kakao.Auth.login({
           success: function(authObj) {
               console.log("카카오 로그인 성공:", authObj);

               // 로그인 성공 시 서버로 액세스 토큰 전달하여 리다이렉트
               let kakaoLoginUrl = '${pageContext.request.contextPath}/login/kakao?accessToken=' + authObj.access_token;
               console.log("Redirecting to: " + kakaoLoginUrl);

               // 카카오 로그인 URL로 이동
               window.location.href = kakaoLoginUrl;
           },
           fail: function(err) {
               console.error("카카오 로그인 실패:", err);
               alert("카카오 로그인 실패: " + JSON.stringify(err));
           }
       });
   });
   
   
   
   
    // 네이버 로그인 버튼 클릭 시 처리
    document.getElementById("naver-login-btn").addEventListener("click", function () {
        console.log("네이버 로그인 버튼이 클릭되었습니다.");

        // 네이버 로그인 URL로 이동
        let naverLoginUrl = "${pageContext.request.contextPath}/naver/login";  // 컨트롤러의 네이버 로그인 경로로 리다이렉트
        window.location.href = naverLoginUrl;
    });
    
    
    const GOOGLE_CLIENT_ID = "981203649264-3mco0tr5ao6bgb6eulod79rn2bhvtmjd.apps.googleusercontent.com";
    const GOOGLE_REDIRECT_URI = "http://localhost:9090/BBOL/auth/google/callback";
    
    document.getElementById("google-login-btn").addEventListener("click", function() {
        console.log("구글 로그인 버튼이 클릭되었습니다.");

        // 구글 OAuth 2.0 로그인 요청
        let googleLoginUrl = "https://accounts.google.com/o/oauth2/v2/auth" +
            "?client_id=" + GOOGLE_CLIENT_ID +   // 구글 클라이언트 ID
            "&redirect_uri=" + GOOGLE_REDIRECT_URI +  // 로그인 후 리디렉트할 URI
            "&response_type=code" +  // 인증 코드 요청
            "&scope=https://www.googleapis.com/auth/userinfo.email openid";
             // 요청할 사용자 정보 범위

        console.log("Redirecting to: " + googleLoginUrl);

        // 구글 로그인 페이지로 이동
        window.location.href = googleLoginUrl;
    });

    
    
</script>

</body>
</html>
