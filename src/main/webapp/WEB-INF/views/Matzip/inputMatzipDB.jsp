<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DB 저장 결과</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/processDetailApi.css">
</head>
<body>
    <div class="resultcontainer">
        <h1>DB 저장 결과</h1>
        <p>${message}</p>
        
        <form action="${pageContext.request.contextPath}/Matzip/MatzipApi" method="get">
            <button type="submit">API 조회로 돌아가기</button>
        </form>
    </div>

    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>
