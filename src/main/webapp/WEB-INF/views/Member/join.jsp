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
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
    <title>이메일 회원가입</title>
</head>
<body>

<!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
    var contextPath = "${pageContext.request.contextPath}";

    // 이메일 중복 체크
    $('#email').on('blur', function() {
        var email = $(this).val();
        if (email !== '') {
            $.ajax({
                type: 'POST',
                url: contextPath + "/Member/checkId", // 이메일 중복 체크할 URL
                data: { m_email: email },
                dataType: "text",
                success: function(response) {
                    console.log("이메일 중복 체크 응답: " + response);
                    if (response === 'FAIL') {
                        $('#emailMsg').text('이미 사용 중인 이메일입니다.').css('display', 'block');
                        $('#submitBtn').prop('disabled', true);  // 가입 버튼 비활성화
                    } else {
                        $('#emailMsg').css('display', 'none');
                        $('#submitBtn').prop('disabled', false);  // 가입 버튼 활성화
                    }
                },
                error: function(xhr, status, error) {
                    console.log('AJAX 요청 오류:', error);
                }
            });
        } else {
            $('#emailMsg').css('display', 'none');
            $('#submitBtn').prop('disabled', true);
        }
    });

    // 닉네임 중복 체크
    $('#nickname').on('blur', function() {
        var nickname = $(this).val();
        if (nickname !== '') {
            $.ajax({
                type: 'POST',
                url: contextPath + "/Member/checkNickname", // 닉네임 중복 체크할 URL
                data: { m_nickname: nickname },
                dataType: "text",
                success: function(response) {
                    console.log("닉네임 중복 체크 응답: " + response);
                    if (response === 'FAIL') {
                        $('#nicknameMsg').text('이미 사용 중인 닉네임입니다.').css('display', 'block');
                        $('#submitBtn').prop('disabled', true);  // 가입 버튼 비활성화
                    } else {
                        $('#nicknameMsg').css('display', 'none');
                        $('#submitBtn').prop('disabled', false);  // 가입 버튼 활성화
                    }
                },
                error: function(xhr, status, error) {
                    console.log('AJAX 요청 오류:', error);
                }
            });
        } else {
            $('#nicknameMsg').css('display', 'none');
            $('#submitBtn').prop('disabled', true);
        }
    });

});

// 이메일 인증
function email_ok(email) {
    var contextPath = '<%= request.getContextPath() %>';
    if (!email || email === "") {
        alert("이메일을 입력하세요.");
        return;
    }

    $.ajax({
        type: "POST",
        url: contextPath + "/mailSend",
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

// 인증번호 확인
function verifyCode() {
    var inputCode = document.getElementById("authCode").value;
    var contextPath = '<%= request.getContextPath() %>';
    
    $.ajax({
        type: "POST",
        url: contextPath + "/verifyCode",
        data: { authCode: inputCode },
        success: function(response) {
            if (response === "success") {
                alert("인증이 완료되었습니다.");
                document.getElementById("submitBtn").disabled = false; 
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


<div class="join-form-container">
  <h1>이메일 가입</h1>
  
  <form class="joinForm" name="joinForm" method="post" action="${pageContext.request.contextPath}/Member/joinProcess" onsubmit="return sendit();">
    <!-- 이메일 -->
    <label for="email">이메일</label>
    <div class="auth-button-group">
      <input type="text" id="email" name="m_email" placeholder="아이디로 사용할 이메일을 입력해 주세요." required>
      <button type="button" onclick="email_ok(document.getElementById('email').value)">인증번호 전송</button>
    </div>
    <span id="emailMsg" class="error-msg" style="color: red; display: none;"></span> <!-- 이메일 유효성 메시지 -->

    <!-- 인증번호 -->
    <label for="authCode">인증번호</label>
    <div class="auth-button-group">
      <input type="text" id="authCode" name="authCode" placeholder="이메일로 받은 인증번호를 입력해 주세요." required>
      <button type="button" onclick="verifyCode()">인증하기</button>
    </div>
    
    <!-- 닉네임 -->
    <label for="nickname">닉네임</label>
    <input type="text" id="nickname" name="m_nickname" placeholder="영문, 숫자, 한글 2-7자" required>
    <span id="nicknameMsg" class="error-msg" style="color: red; display: none;"></span> <!-- 닉네임 유효성 메시지 -->
    
    <!-- 비밀번호 -->
    <label for="password">비밀번호</label>
    <input type="password" id="password" name="m_password" placeholder="영문, 숫자, 특수문자가 모두 들어간 8-20자" required>
    <span id="passwordMsg" class="error-msg" style="color: red; display: none;"></span> <!-- 비밀번호 유효성 메시지 -->

    <!-- 비밀번호 확인 -->
    <label for="password_re">비밀번호 확인</label>
    <input type="password" id="password_re" name="m_password_re" placeholder="비밀번호를 한 번 더 입력해 주세요." required>
    <span id="passwordReMsg" class="error-msg" style="color: red; display: none;"></span> <!-- 비밀번호 확인 메시지 -->



    <div class="terms-container">
      <input type="checkbox" id="agree_all" onclick="checkAll(this)"> 전체 동의
      <div class="terms-list">
        <label>
          <input type="checkbox" id="agree_terms"> 이용약관 동의(필수)
          <a href="javascript:void(0);" class="terms-link" onclick="openTermsModal('terms')">전문보기</a>
        </label>
        <label>
          <input type="checkbox" id="agree_privacy"> 개인정보 수집·이용 동의(필수)
          <a href="javascript:void(0);" class="terms-link" onclick="openTermsModal('privacy')">전문보기</a>
        </label>
        <label>
          <input type="checkbox" id="agree_marketing"> 마케팅 메일 수신 동의 (선택)
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
  <!-- 성공 메시지 출력 -->
<c:if test="${not empty msg}">
    <script>
        alert('${msg}');  // 성공 메시지를 alert로 표시
    </script>
</c:if>






<script>  
    // 전체 동의 체크박스 선택 시 나머지 체크박스들도 모두 선택
  function checkAll(checkbox) {
    const terms = document.getElementById("agree_terms");
    const privacy = document.getElementById("agree_privacy");
    const marketing = document.getElementById("agree_marketing");

    terms.checked = checkbox.checked;
    privacy.checked = checkbox.checked;
    marketing.checked = checkbox.checked;

    toggleSubmitButton();
  }

  // 필수 항목 체크 시 가입 버튼 활성화/비활성화
  function toggleSubmitButton() {
    const terms = document.getElementById("agree_terms").checked;
    const privacy = document.getElementById("agree_privacy").checked;
    const submitBtn = document.getElementById("submitBtn");

    // 필수 항목이 모두 체크되었을 때만 가입 버튼 활성화
    if (terms && privacy) {
      submitBtn.disabled = false;
    } else {
      submitBtn.disabled = true;
    }
  }

  // 각 개별 체크박스가 변경될 때에도 가입 버튼을 활성화/비활성화 처리
  document.getElementById("agree_terms").addEventListener("change", toggleSubmitButton);
  document.getElementById("agree_privacy").addEventListener("change", toggleSubmitButton);

  // 모달 열기/닫기 함수는 생략
</script>
  
  
    <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />

</body>
<script src="${pageContext.request.contextPath}/resources/js/user.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/join.js"></script>
</html>
