<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디, 비밀번호 찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_findId.css">

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

    <!-- 아이디 찾기와 비밀번호 찾기 선택 -->
    <label><input type="radio" name="findType" value="id" onclick="toggleForm()" checked> 아이디 찾기</label>
    <label><input type="radio" name="findType" value="password" onclick="toggleForm()"> 비밀번호 찾기</label>

    <h2>아이디 찾기</h2>
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
            <input type="text" name="m_nickname" id="m_nickname" placeholder="닉네임을 입력하세요">

            <button type="submit">아이디 찾기</button>
        </form>

        <!-- 찾은 아이디가 있을 경우 출력 -->
        <c:if test="${not empty foundId}">
            <p>찾은 아이디: ${foundId}</p>
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
                <input type="password" name="newPassword" placeholder="새로운 비밀번호를 입력하세요" required>
                <input type="password" name="confirmPassword" placeholder="비밀번호 확인" required>
                <button type="submit" id="submitBtn" disabled>비밀번호 재설정</button>
            </form>
        </div>
    </div>

    <!-- 에러 메시지가 있을 경우 출력 -->
    <c:if test="${not empty errorMessage}">
        <p>${errorMessage}</p>
    </c:if>

    <a href="${pageContext.request.contextPath}/Member/login">로그인 하러 가기</a>
</body>
</html>
