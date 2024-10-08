<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/journal.css">
</head>
<body>

<div class="journal-section">
    <!-- 제목 -->
    <div class="section-title1">대전 여행기</div>

<div class="image-container">
    <!-- 이미지 1 -->
    <div class="image-item">
        <img src="${pageContext.request.contextPath}/resources/images/T_1.png" alt="Seoul Trip 1">
        <div class="image-description">
            <span class="category">TRAVEL</span>
            <span class="date">2024.08.05~2024.08.08</span>
            <div class="image-title">언제가도 다채로운 서울 여행</div>
            <div class="author">보리공주님</div>
        </div>
        
        <!-- 아이콘 영역 -->
        <div class="icon-container">
            <i class="fa-solid fa-comment-dots"></i><span class="icon-text">${commentCount}</span>
            <i class="fa-solid fa-heart"></i><span class="icon-text">${commentCount}</span>
            <i class="fa-solid fa-eye"></i><span class="icon-text">${commentCount}</span>
        </div>
    </div>

    <!-- 이미지 2 -->
    <div class="image-item">
        <img src="${pageContext.request.contextPath}/resources/images/T_1.png" alt="Seoul Trip 2">
        <div class="image-description">
            <span class="category">TRAVEL</span>
            <span class="date">2024.08.05~2024.08.08</span>
            <div class="image-title">언제가도 다채로운 서울 여행</div>
            <div class="author">보리공주님</div>
        </div>
        <!-- 아이콘 영역 -->
        <div class="icon-container">
            <i class="fa-solid fa-comment-dots"></i><span class="icon-text">${commentCount}</span>
            <i class="fa-solid fa-heart"></i><span class="icon-text">${commentCount}</span>
            <i class="fa-solid fa-eye"></i><span class="icon-text">${commentCount}</span>
        </div>
    </div>

    <!-- 이미지 3 -->
    <div class="image-item">
        <img src="${pageContext.request.contextPath}/resources/images/T_1.png" alt="Seoul Trip 3">
        <div class="image-description">
            <span class="category">TRAVEL</span>
            <span class="date">2024.08.05~2024.08.08</span>
            <div class="image-title">언제가도 다채로운 서울 여행</div>
            <div class="author">보리공주님</div>
        </div>
        <!-- 아이콘 영역 -->
        <div class="icon-container">
            <i class="fa-solid fa-comment-dots"></i><span class="icon-text">0</span>
            <i class="fa-solid fa-heart"></i><span class="icon-text">0</span>
            <i class="fa-solid fa-eye"></i><span class="icon-text">0</span>
        </div>
    </div>

    <!-- 이미지 4 -->
    <div class="image-item">
        <img src="${pageContext.request.contextPath}/resources/images/T_1.png" alt="Seoul Trip 4">
        <div class="image-description">
            <span class="category">TRAVEL</span>
            <span class="date">2024.08.05~2024.08.08</span>
            <div class="image-title">언제가도 다채로운 서울 여행</div>
            <div class="author">보리공주님</div>
        </div>
        <!-- 아이콘 영역 -->
        <div class="icon-container">
            <i class="fa-solid fa-comment-dots"></i><span class="icon-text">0</span>
            <i class="fa-solid fa-heart"></i><span class="icon-text">0</span>
            <i class="fa-solid fa-eye"></i><span class="icon-text">0</span>
        </div>
    </div>
</div>


<!-- 여행 일정 -->
<div class="schedule-section">
    <div class="section-title">지금 여행일정 고민중이라고요?</div>
    <div class="schedule-main-title">대전 여행일정</div>

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

<div class="hot-spot-section">
    <div class="section-title">테마가 있는 여행을 즐겨보세요!</div>
    <div class="hot-spot-main-title">대전 여행뽈뽈</div>

    <!-- 뜨고 있는 장소 4개 가로로 배치 -->
    <div class="image-container">
        <div class="image-item1">
            <img src="${pageContext.request.contextPath}/resources/images/T_3.png" alt="등대해수욕장">
            <div class="image-description">
                <div class="image-title">등대해수욕장</div>
            </div>
        </div>

        <div class="image-item1">
            <img src="${pageContext.request.contextPath}/resources/images/T_3.png" alt="해수욕장 2">
            <div class="image-description">
                <div class="image-title">등대해수욕장</div>
            </div>
        </div>

        <div class="image-item1">
            <img src="${pageContext.request.contextPath}/resources/images/T_3.png" alt="해수욕장 3">
            <div class="image-description">
                <div class="image-title">등대해수욕장</div>
            </div>
        </div>

        <div class="image-item1">
            <img src="${pageContext.request.contextPath}/resources/images/T_3.png" alt="해수욕장 4">
            <div class="image-description">
                <div class="image-title">등대해수욕장</div>
            </div>
        </div>
    </div>
</div>

<!-- 뜨고 있는 장소 섹션 -->
<div class="hot-spot-section">
    <div class="section-title2">지금 서울 뜨고있는 장소가 궁금해?</div>
    <div class="hot-spot-main-title1">대전 핫플</div>

    <!-- 뜨고 있는 장소 4개 가로로 배치 -->
    <div class="image-container">
        <div class="image-item2">
        <img src="${pageContext.request.contextPath}/resources/images/T_4.png" alt="서울 악령시장 4">
            <div class="image-description">
                <div class="image-title">서울 악령시장</div>
                <div class="location">서울특별시 송파구</div>
            </div>
        </div>

        <div class="image-item2">
            <img src="${pageContext.request.contextPath}/resources/images/T_4.png" alt="서울 악령시장 4">
            <div class="image-description">
                <div class="image-title">서울 악령시장 2</div>
                <div class="location">서울특별시 송파구</div>
            </div>
        </div>

        <div class="image-item2">
            <img src="${pageContext.request.contextPath}/resources/images/T_4.png" alt="서울 악령시장 4">
            <div class="image-description">
                <div class="image-title">서울 악령시장 3</div>
                <div class="location">서울특별시 송파구</div>
            </div>
        </div>

        <div class="image-item2">
            <img src="${pageContext.request.contextPath}/resources/images/T_4.png" alt="서울 악령시장 4">
            <div class="image-description">
                <div class="image-title">서울 악령시장 4</div>
                <div class="location">서울특별시 송파구</div>
            </div>
        </div>
    </div>
</div>

<!-- 핫플 섹션 -->
<div class="restaurant-section">
    <div class="section-title3">우리 동네 맛집이 궁금해?</div>
    <div class="restaurant-main-title">대전 맛집</div>

    <div class="image-container">
        <div class="image-item3">
            <img src="${pageContext.request.contextPath}/resources/images/T_5.png" alt="중화일상">
            <div class="image-description">
                <div class="image-title">중화일상</div>
                <div class="location">서울특별시 송파구</div>
            </div>
        </div>

        <div class="image-item3">
            <img src="${pageContext.request.contextPath}/resources/images/T_5.png" alt="중화일상">
            <div class="image-description">
                <div class="image-title">중화일상 2</div>
                <div class="location">서울특별시 송파구</div>
            </div>
        </div>

        <div class="image-item3">
            <img src="${pageContext.request.contextPath}/resources/images/T_5.png" alt="중화일상">
            <div class="image-description">
                <div class="image-title">중화일상 3</div>
                <div class="location">서울특별시 송파구</div>
            </div>
        </div>

        <div class="image-item3">
            <img src="${pageContext.request.contextPath}/resources/images/T_5.png" alt="중화일상">
            <div class="image-description">
                <div class="image-title">중화일상 4</div>
                <div class="location">서울특별시 송파구</div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="Festival_Daejeon.jsp" />

<!-- FontAwesome 스크립트 추가 -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

</body>
</html>
