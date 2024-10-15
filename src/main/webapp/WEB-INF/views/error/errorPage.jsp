<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 오류</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        .error-container {
            color: red;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h2>로그인 실패</h2>
        <p>로그인에 실패했습니다. 다시 시도해 주세요.</p>
        <button onclick="location.href='/'">홈으로 돌아가기</button>
    </div>
</body>
</html>
