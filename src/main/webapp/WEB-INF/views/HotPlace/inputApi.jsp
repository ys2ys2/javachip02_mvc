<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공공데이터 API DB 저장하기</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inputApi.css">
    
</head>

<body>
    <div class="container">
        <h1>뽈뽈뽈</h1>
        <h1>공공데이터 API DB 조회, 저장</h1>
        <form action="${pageContext.request.contextPath}/HotPlace/processCodeApi" method="post">
            <label for="regionCode">지역 코드</label>
            <p>서울 : 1 , 인천 : 2 , 대전 : 3 , 대구 : 4 , 광주 : 5 , 부산 : 6 , 울산 : 7<br><br>세종 : 8 , 경기 : 31 , 강원 : 32 , 충북 : 33 , 충남 : 34 ,
            	경북 : 35<br><br>경남 : 36 , 전북 : 37 , 전남 : 38 , 제주 : 39<br>
            </p>
            <input class="inputText" type="text" id="regionCode" name="regionCode" placeholder="지역 코드를 입력해 주세요." required>
            <button class="inputApi" type="submit">API 데이터 조회하기</button>
        </form>
    </div>
</body>





</html>