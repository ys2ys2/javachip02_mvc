<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link href="${pageContext.request.contextPath}/resources/css/joinmain.css" rel="stylesheet" type="text/css">
    <title>회원가입 메인페이지</title>
</head>
<body>
  <!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />

   <!-- 회원가입 폼 -->
<div class="joinmain-form-container">
    <h3 class="bbol-login-title">회원가입 하고<br> <span>BBOL BBOL BBOL</span> <br>시작해 보세요!</h3>

    <form class="joimain-form" name="jointype" method="post" action="">
        <!-- 카카오 로그인 버튼 -->
        <button type="button"  id="kakao-login-btn" class="kakao-button">
                <img src="${pageContext.request.contextPath}/resources/images/kakaolargeicon.png" alt="카카오">
        </button>

        <!-- 이메일 가입 버튼 -->
        <a href="${pageContext.request.contextPath}/Member/join"><button type="button" class="email-button" onclick="location.href='join.jsp'">이메일로 가입</button></a>

        <!-- 또는 구분선 -->
        <div class="join-divider">
            <span>또는</span>
        </div>

        <!-- SNS 로그인 버튼 -->
        <div class="sns-buttons">
            <button type="button" id="naver-login-btn"><img src="${pageContext.request.contextPath}/resources/images/navericon.png" alt="Naver" class="sns-icon"></button>
            <button type="button" id="google-login-btn">
            <img src="${pageContext.request.contextPath}/resources/images/googleicon.png" alt="Google" class="sns-icon"></button>
        </div>

        <!-- 로그인 유도 문구 -->
        <p class="login-prompt">이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/Member/login"><span onclick="location.href='../Login/login.jsp'">로그인</span></a></p>
    </form>
</div>


    <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />

 <!-- 카카오 SDK 추가 -->
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script type="text/javascript">
        Kakao.init('490f42bb026448a091429ee1b1c4cb0c');  // 발급받은 JavaScript 키로 초기화
        console.log("Kakao SDK Initialized.");

        $("#kakao-login-btn").on("click", function() {
            console.log("카카오 회원가입 버튼이 클릭되었습니다.");

            Kakao.Auth.login({
                success: function(authObj) {
                    console.log("회원가입 성공:", authObj);

                    Kakao.API.request({
                        url: '/v2/user/me',
                        success: function(res) {
                            console.log(res);
                            alert('회원가입 성공');
                            // 토큰을 받아 서버에 전달 (여기서는 간단히 Redirect 처리)
                            location.href = 'http://localhost:9090/BBOL/signup/kakao?accessToken=' + authObj.access_token;
                        },
                        fail: function(err) {
                            console.error("사용자 정보 요청 실패:", err);
                            alert(JSON.stringify(err));
                        }
                    });
                },
                fail: function(err) {
                    console.error("로그인 실패:", err);
                    alert(JSON.stringify(err));
                }
            });
        });

        const GOOGLE_CLIENT_ID = "981203649264-3mco0tr5ao6bgb6eulod79rn2bhvtmjd.apps.googleusercontent.com";
        const GOOGLE_REDIRECT_URI = "http://localhost:9090/BBOL/auth/google/callback";

     // 구글 회원가입 버튼 클릭 시 처리
        document.getElementById("google-login-btn").addEventListener("click", function () {
            console.log("구글 회원가입 버튼이 클릭되었습니다.");

            let googleAuthUrl = "https://accounts.google.com/o/oauth2/v2/auth" +
                "?client_id=" + GOOGLE_CLIENT_ID +
                "&redirect_uri=" + GOOGLE_REDIRECT_URI +
                "&response_type=code" +
                "&scope=https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email";                

            console.log("Redirecting to: " + googleAuthUrl); // 리디렉션 URL 로그
            window.location.href = googleAuthUrl;  // 구글 회원가입 페이지로 이동
        });
     
     
     
        // 네이버 로그인 버튼 클릭 시 처리
        document.getElementById("naver-login-btn").addEventListener("click", function () {
            console.log("네이버 로그인 버튼이 클릭되었습니다.");

            // 네이버 로그인 요청을 위한 URL 생성
            let naverLoginUrl = "${pageContext.request.contextPath}/naver/login";

            console.log("Redirecting to: " + naverLoginUrl); // 리디렉션 URL 로그
            window.location.href = naverLoginUrl;  // 네이버 로그인 페이지로 이동
        });
    </script>
</body>
<!-- 외부 JavaScript 파일 불러오기 -->

</html>
