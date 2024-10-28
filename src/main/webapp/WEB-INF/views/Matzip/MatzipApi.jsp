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
        <h1>맛집 API DB 조회, 저장</h1>
        <form action="${pageContext.request.contextPath}/Matzip/processMatzipCodeApi" method="post">
            <label for="regionCode">음식점 ID :</label>
            <input type="text" id="restaurantIds" name="restaurantIds" placeholder="예: 1583, 1917, 5216" required>
            <br>
            <label for="restaurantNames">음식점 이름 :</label>
            <input type="text" id="restaurantNames" name="restaurantNames" placeholder="예: 원조한치, 미성옥, 삼호복집" required>
            <button class="inputApi" type="submit">API 데이터 조회하기</button>
        </form>
        <a href="https://www.data.go.kr/data/15097008/fileData.do" target="_blank">
           	<button class="inputApi1">음식점 정보 .csv 다운받기</button>
        </a>
    </div>
</body>





</html>