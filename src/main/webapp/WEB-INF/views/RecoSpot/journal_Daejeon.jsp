<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/journal.css?v=1.0">
<!-- jQuery를 사용하기 위한 API 추가 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>

<script>

	//맛집을 클릭했을 때 famous.jsp를 호출할 수 있도록 함
	$(".image-item3").on("click", function(){
		
		//famous.jsp를 호출하는 url: /aaa
		location.href = "${pageContext.request.contextPath}/Matzip/famous";
		
	});


</script>




</head>
<body>


<!-- 여행 일정 -->
<div class="schedule-section">
    <!-- 네모 박스에 차는 제목 -->
    
    
      <div class="section-title">지금 여행일정 고민중이라고요?</div>
    

    <!-- 서울 여행일정 제목 -->
    <div class="schedule-main-title-box">
        <div class="schedule-main-title">서울 여행일정</div>
    </div>

    <!-- 일정 3개 가로로 배치 -->
    <div class="schedule-container">
        <div class="schedule-item">
            <img src="${pageContext.request.contextPath}/resources/images/T_2.png" alt="Seoul Map 1">
            <div class="image-description">
                <span class="category">TRAVEL</span>
                <span class="date">2024.08.05~2024.08.08</span>
                <div class="image-title">서울 탐방</div>
                <div class="author">보리보리</div>
            </div>
            <!-- 지도 아이콘 및 장소 공유 -->
            <div class="map-icons-container">
                <i class="fa-solid fa-map"></i><span class="icon-text">${commentCount}</span>
                <i class="fa-solid fa-share-nodes"></i><span class="icon-text">${commentCount}</span>
            </div>
        </div>

        <div class="schedule-item">
            <img src="${pageContext.request.contextPath}/resources/images/T_2.png" alt="Seoul Map 1">
            <div class="image-description">
                <span class="category">TRAVEL</span>
                <span class="date">2024.08.05~2024.08.08</span>
                <div class="image-title">서울 탐방</div>
                <div class="author">보리보리</div>
            </div>
            <!-- 지도 아이콘 및 장소 공유 -->
            <div class="map-icons-container">
                <i class="fa-solid fa-map"></i><span class="icon-text">${commentCount}</span>
                <i class="fa-solid fa-share-nodes"></i><span class="icon-text">${commentCount}</span>
            </div>
        </div>
                <div class="schedule-item">
            <img src="${pageContext.request.contextPath}/resources/images/T_2.png" alt="Seoul Map 1">
            <div class="image-description">
                <span class="category">TRAVEL</span>
                <span class="date">2024.08.05~2024.08.08</span>
                <div class="image-title">서울 탐방</div>
                <div class="author">보리보리</div>
            </div>
            <!-- 지도 아이콘 및 장소 공유 -->
            <div class="map-icons-container">
                <i class="fa-solid fa-map"></i><span class="icon-text">${commentCount}</span>
                <i class="fa-solid fa-share-nodes"></i><span class="icon-text">${commentCount}</span>
            </div>
        </div>

        <div class="schedule-item">
            <img src="${pageContext.request.contextPath}/resources/images/T_2.png" alt="Seoul Map 1">
            <div class="image-description">
                <span class="category">TRAVEL</span>
                <span class="date">2024.08.05~2024.08.08</span>
                <div class="image-title">서울 탐방</div>
                <div class="author">보리보리</div>
            </div>
            <!-- 지도 아이콘 및 장소 공유 -->
            <div class="map-icons-container">
                <i class="fa-solid fa-map"></i><span class="icon-text">${commentCount}</span>
                <i class="fa-solid fa-share-nodes"></i><span class="icon-text">${commentCount}</span>
            </div>
        </div>
    </div>
 </div>



<!-- 뜨고 있는 장소 섹션 -->
<div class="hot-spot-section">
    <div class="section2-title">지금 서울 뜨고있는 장소가 궁금해?</div>
       <div class="schedule2-main-title-box">
    <div class="hot-spot-main-title1">핫플</div>
    </div>

    <!-- 뜨고 있는 장소 4개 가로로 배치 -->
    <div class="image-container">
        <div class="image-item2">
        <img src="${pageContext.request.contextPath}/resources/images/ttt1.png" alt="서울 악령시장 4">
            <div class="image-description">
                <div class="image-title">대덕숲유원지</div>
                <div class="location">충청북도 청주시 상당구 미원면 대덕리 </div>
            </div>
        </div>

        <div class="image-item2">
            <img src="${pageContext.request.contextPath}/resources/images/ttt2.png" alt="서울 악령시장 4">
            <div class="image-description">
                <div class="image-title">태화강 은하수 다리</div>
                <div class="location">울산광역시 남구 무거동</div>
            </div>
        </div>

        <div class="image-item2">
            <img src="${pageContext.request.contextPath}/resources/images/ttt3.png" alt="서울 악령시장 4">
            <div class="image-description">
                <div class="image-title">돌하르방미술관</div>
                <div class="location">제주특별자치도 제주시 조천읍 북촌서1길 70</div>
            </div>
        </div>

        <div class="image-item2">
            <img src="${pageContext.request.contextPath}/resources/images/ttt4.png" alt="서울 악령시장 4">
            <div class="image-description">
                <div class="image-title">만인산 자연휴양림</div>
                <div class="location">대전광역시 동구 산내로 106</div>
            </div>
        </div>
    </div>
</div>

<!-- 핫플 섹션 -->
<div class="restaurant-section">
    <div class="section3-title">우리 동네 맛집이 궁금해?</div>
       <div class="schedule3-main-title-box">
    <div class="restaurant-main-title">맛집</div>
    </div>

    <div class="image-container">
        <div class="image-item3">
             <a href="${pageContext.request.contextPath}/Matzip/seoulFamous" class="image-item3">
            <img src="${pageContext.request.contextPath}/resources/images/ppp1.png" alt="중화일상">
          <div class="image-description">
                <div class="image-title">조박집투(별관점)</div>
                <div class="location">서울특별시 마포구 토정로 311</div>
            </div>
          </a>
        </div>

        <div class="image-item3">
            <img src="${pageContext.request.contextPath}/resources/images/ppp2.png" alt="중화일상">
            <div class="image-description">
                <div class="image-title">유래회관</div>
                <div class="location">서울특별시 성동구 마장로 196</div>
            </div>
        </div>

        <div class="image-item3">
            <img src="${pageContext.request.contextPath}/resources/images/ppp3.png" alt="중화일상">
            <div class="image-description">
                <div class="image-title">신의주찹쌀순대</div>
                <div class="location">서울특별시 관악구 청룡1길 33</div>
            </div>
        </div>

        <div class="image-item3">
            <img src="${pageContext.request.contextPath}/resources/images/ppp4.png" alt="중화일상">
            <div class="image-description">
                <div class="image-title">해태식당</div>
                <div class="location">서울특별시 강남구 영동대로 725</div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="Festival_Seoul.jsp" />

<!-- FontAwesome 스크립트 추가 -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

</body>
</html>
