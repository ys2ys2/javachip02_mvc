<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Google OAuth Callback</title>
</head>
<body>
    <script type="text/javascript">
        window.onload = function() {
            // URL에서 인증 코드 추출
            const params = new URLSearchParams(window.location.search);
            const code = params.get('code');

            if (code) {
                // 서버로 인증 코드 전달
                fetch('http://localhost:9090/BBOL_prjt/auth/google/token', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ code: code })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        console.log("로그인 성공:", data);
                        // 메인 페이지로 리다이렉트
                        window.location.href = "http://localhost:9090/BBOL_prjt/index.jsp";
                    } else {
                        console.error("로그인 실패:", data);
                    }
                })
                .catch(error => {
                    console.error("서버 통신 중 오류 발생:", error);
                });
            }
        }
    </script>
</body>
</html>
