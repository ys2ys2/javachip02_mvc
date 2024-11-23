<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Festival.css?v=1.0"> <!-- CSS 링크 -->
<!-- jQuery를 사용하기 위한 API 추가 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>

<script>

	//맛집을 클릭했을 때 famous.jsp를 호출할 수 있도록 함
	$(".image-item2").on("click", function(){
		
		//famous.jsp를 호출하는 url: /aaa
		location.href = "${pageContext.request.contextPath}/Matzip/famous";
		
	});


</script>
    
    
</head>
<body>


  
<!-- 축제 이미지 슬라이더 섹션 -->
<div class="section22-title">진행중인<br> 행사가 궁금해?</div>

<div class="festival-slider">

    <div class="festival-slide">
        <a href="${pageContext.request.contextPath}/Festival/Event">
            <img src="${pageContext.request.contextPath}/resources/images/Festival_Seoul1.png" alt="Festival Image 1">
        </a>
        <div class="festival-info">
            <h3>레이션페어</h3>
            <p class="event-district">강남구</p>
            <div class="event-info">
                <p class="event-period">
                    <span class="label">기간 </span> 2024-12-22<br>2024-12-22
                </p>
                <p class="event-location">
                    <span class="label">장소 </span> 예술의전당
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/Festival/Event">
            <button class="action-button">바로가기</button>
            </a>
        </div>
    </div>
    
    <div class="festival-slide">
        <a href="${pageContext.request.contextPath}/Festival/Event2">
            <img src="${pageContext.request.contextPath}/resources/images/Festival_Seoul2.jpg" alt="Festival Image 2">
        </a>
        <div class="festival-info">
            <h3>파리나무십자가</h3>
            <p class="event-district">강남구</p>
            <div class="event-info">
                <p class="event-period">
                    <span class="label">기간</span> 2024-12-22<br>2024-12-22
                </p>
                <p class="event-location">
                    <span class="label">장소</span> 예술의전당
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/Festival/Event2">
            <button class="action-button">바로가기</button>
            </a>
        </div>
    </div>
    
    <div class="festival-slide">
        <a href="${pageContext.request.contextPath}/Festival/Event3">
            <img src="${pageContext.request.contextPath}/resources/images/Festival_Seoul3.png" alt="Festival Image 3">
        </a>
        <div class="festival-info">
            <h3>행복의 파랑새</h3>
            <p class="event-district">종로구</p>
            <div class="event-info">
                <p class="event-period">
                    <span class="label">기간</span> 2024-12-12<br>2024-12-13
                </p>
                <p class="event-location">
                    <span class="label">장소</span> 아이들극장
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/Festival/Event3">
            <button class="action-button">바로가기</button>
        	</a>
        </div> 
    </div>
    
</div>



<!-- <script src="${pageContext.request.contextPath}/resources/js/festival.js?v=1.0"></script> -->

</body>
</html>
