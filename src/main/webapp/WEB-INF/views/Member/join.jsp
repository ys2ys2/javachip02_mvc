<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> <!-- header.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
    
    <title>이메일 회원가입</title>
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
            <span>${sessionScope.member.m_nickname}님 환영합니다!</span>
            <span><a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지</a></span>
            <form action="${pageContext.request.contextPath}/Member/logout" method="post" style="display:inline;">
              <button type="submit">로그아웃</button>
            </form>
          </c:when>
          <c:otherwise>
            <!-- 로그인 실패 시, 로그인과 회원가입 표시 -->
            <span><a href="${pageContext.request.contextPath}/Member/login">로그인</a></span>
            <span><a href="${pageContext.request.contextPath}/Member/signup">회원가입</a></span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>
  <!-- 메인 시작 부분 -->

<script type="text/javascript">
function email_ok(email) {
    console.log("입력된 이메일: ", email);

    if (!email || email === "") {
        alert("이메일을 입력하세요.");
        return;
    }

    var contextPath = '<%= request.getContextPath() %>';

    $.ajax({
        type: "POST",
        url: contextPath + "/mailSend",  // 서버의 컨텍스트 경로 + 서블릿 경로
        data: { receiver: email },  // 서버로 전송할 데이터 (이메일)
        dataType: "text",  // 서버에서 텍스트 형식의 응답을 받을 때
        success: function(response) {
            console.log("서버 응답: ", response);
            if (response === "이메일 전송 성공") {
                // 이메일 전송 성공 메시지 화면에 표시
                alert("이메일이 성공적으로 전송되었습니다. 계속해서 가입을 진행하세요.");
            } else {
                alert("이메일 전송에 실패했습니다. 다시 시도해주세요.");
            }
        },
        error: function(xhr, status, error) {
            console.log("AJAX 오류: ", error);  // 오류 로그 출력
            alert("서버 오류: " + error);
        }
    });
}
// 인증번호 확인 함수
function verifyCode() {
    var inputCode = document.getElementById("authCode").value; // 사용자가 입력한 인증번호

    var contextPath = '<%= request.getContextPath() %>';
    
    $.ajax({
        type: "POST",
        url: contextPath +"/verifyCode",  // VerifyCode 서블릿에 요청
        data: { authCode: inputCode },  // 사용자가 입력한 인증번호 전달
        success: function(response) {
            if (response === "success") {
                alert("인증이 완료되었습니다. 회원가입을 진행하세요.");
                document.getElementById("submitBtn").disabled = false; // 회원가입 버튼 활성화
            } else {
                alert("인증번호가 일치하지 않습니다.");
            }
        },
        error: function(xhr, status, error) {
            alert("인증번호 확인 중 오류가 발생했습니다.");
        }
    });
}

function checkCode(){
    var v1 = document.getElementById("code_check").value;
    var v2 = document.getElementById("code").value;

    if(v1 != v2){
        document.getElementById('checkCode').style.color = "red";
        document.getElementById('checkCode').innerHTML = "잘못된 인증번호";
        makeNull();
    }else{
        document.getElementById('checkCode').style.color = "green";
        document.getElementById('checkCode').innerHTML = "인증번호가 확인되었습니다";
        makeReal();
    }
}

function makeReal(){
    var hi = document.getElementById("hi");
    hi.type = "submit";
}

function makeNull(){
    var hi = document.getElementById("hi");
    hi.type = "hidden";
}

$(document).ready(function() {
    // 이메일 입력 후 포커스가 벗어날 때 이메일 중복 체크 AJAX 요청
    $('#email').on('blur', function() {
        var email = $(this).val();
        if (email !== '') {
            $.ajax({
                type: 'POST',
                url: '<%= request.getContextPath() %>/checkEmail.jsp',  // 이메일 중복 체크할 JSP 또는 서블릿 경로
                data: { email: email },
                dataType: "text", 
                success: function(response) {
                    if (response === 'exists') {
                        $('#emailMsg').text('이미 사용 중인 이메일입니다.').show();
                        $('#submitBtn').prop('disabled', true);  // 가입 버튼 비활성화
                    } else {
                        $('#emailMsg').hide();
                        $('#submitBtn').prop('disabled', false);  // 가입 버튼 활성화
                    }
                },
                error: function(xhr, status, error) {
                    console.log('AJAX 요청 오류:', error);
                }
            });
        } else {
            $('#emailMsg').hide();
            $('#submitBtn').prop('disabled', true);
        }
    });
});
    

</script>



<h1>회원가입</h1>


<div class="join-form-container">
  <h1>이메일 가입</h1>
  
  <form class="joinForm" name="joinForm" method="post" action="${pageContext.request.contextPath}/SignUp/joinProcess">
    <!-- 이메일 -->
    <label for="email">이메일</label>
    <div class="auth-button-group">
      <input type="text" id="email" name="email" placeholder="아이디로 사용할 이메일을 입력해 주세요." required>
      <button type="button" onclick="email_ok(document.getElementById('email').value)">인증번호 전송</button>
    </div>

    <!-- 인증번호 -->
    <label for="authCode">인증번호</label>
    <div class="auth-button-group">
      <input type="text" id="authCode" name="authCode" placeholder="이메일로 받은 인증번호를 입력해 주세요." required>
      <button type="button" onclick="verifyCode()">인증하기</button>
    </div>

    <!-- 닉네임 -->
    <label for="nickname">닉네임</label>
    <input type="text" id="nickname" name="nickname" placeholder="영문, 숫자, 한글 2-7자" required>

    <!-- 비밀번호 -->
    <label for="password">비밀번호</label>
    <input type="password" id="password" name="password" placeholder="영문, 숫자, 특수문자가 모두 들어간 8-20자" required>
    <input type="password" id="password_re" name="password_re" placeholder="비밀번호를 한 번 더 입력해 주세요." required>


    <div class="terms-container">
      <input type="checkbox" id="agree_all"> 전체 동의
      <div class="terms-list">
        <label>
          <input type="checkbox"> 이용약관 동의
          <a href="javascript:void(0);" class="terms-link" onclick="openTermsModal('terms')">전문보기</a>
        </label>
        <label>
          <input type="checkbox"> 개인정보 수집·이용 동의
          <a href="javascript:void(0);" class="terms-link" onclick="openTermsModal('privacy')">전문보기</a>
        </label>
        <label>
          <input type="checkbox"> 마케팅 메일 수신 동의 (선택)
          <a href="javascript:void(0);" class="terms-link" onclick="openTermsModal('marketing')">전문보기</a>
        </label>
      </div>
    </div>
    
    <!-- 모달 팝업 HTML -->
    <div id="termsModal" class="modal">
      <div class="modal-content">
        <span class="close" onclick="closeTermsModal()">&times;</span>
        <h2 id="modalTitle"></h2>
        <p id="modalContent"></p>
      </div>
    </div>
    

    <!-- 가입 완료 버튼 -->
    <button type="submit" id="submitBtn">가입</button>
  </form>
</div>



</body>
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script> <!-- header.js -->
<script src="${pageContext.request.contextPath}/resources/js/lang-toggle.js"></script> <!-- lang-toggle.js -->
<script src="${pageContext.request.contextPath}/resources/js/user.js"></script> <!-- user.js -->
<script src="${pageContext.request.contextPath}/resources/js/join.js"></script> <!-- join.js도 추가 -->
</html>
