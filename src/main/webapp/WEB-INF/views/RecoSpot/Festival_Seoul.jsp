<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Festival.css"> <!-- CSS 링크 -->
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

<!-- 제목 섹션 -->
<div class="festival-header">
   <div class="section-title1">축제 어디까지 가봤니?</div>
   <div class="schedule-main-title1">진행 중인 축제 일정</div>
</div>

<div class="calendar-section">
    <div class="date-box">
        2024.11
    </div>
</div>

<!-- 달력 슬라이더 섹션 -->
<div class="calendar-container">
    <span class="arrow" onclick="scrollCalendar(-1)">&lt;</span> <!-- 왼쪽 화살표 -->
    <div class="calendar-scroll">
        <div class="calendar-line">
            <!-- 날짜와 요일 목록 -->
            <span class="calendar-item" data-day="금" onclick="showPopup(1)">1</span>
            <span class="calendar-item" data-day="토" style="color: blue;" onclick="showPopup(2)">2</span>
            <span class="calendar-item" data-day="일" style="color: red;" onclick="showPopup(3)">3</span>
            <span class="calendar-item" data-day="월" onclick="showPopup(4)">4</span>
            <span class="calendar-item" data-day="화" onclick="showPopup(5)">5</span>
            <span class="calendar-item" data-day="수" onclick="showPopup(6)">6</span>
            <span class="calendar-item" data-day="목" onclick="showPopup(7)">7</span>
            <span class="calendar-item" data-day="금" onclick="showPopup(8)">8</span>
            <span class="calendar-item" data-day="토" style="color: blue;" onclick="showPopup(9)">9</span>
            <span class="calendar-item" data-day="일" style="color: red;" onclick="showPopup(10)">10</span>
            <span class="calendar-item" data-day="월" onclick="showPopup(11)">11</span>
            <span class="calendar-item" data-day="화" onclick="showPopup(12)">12</span>
            <span class="calendar-item" data-day="수" onclick="showPopup(13)">13</span>
            <span class="calendar-item" data-day="목" onclick="showPopup(14)">14</span>
            <span class="calendar-item" data-day="금" onclick="showPopup(15)">15</span>
            <span class="calendar-item hidden" data-day="토">16</span>
            <span class="calendar-item hidden" data-day="일">17</span>
            <span class="calendar-item hidden" data-day="월">18</span>
            <span class="calendar-item hidden" data-day="화">19</span>
            <span class="calendar-item hidden" data-day="수">20</span>
            <span class="calendar-item hidden" data-day="목">21</span>
            <span class="calendar-item hidden" data-day="금">22</span>
            <span class="calendar-item hidden" data-day="토">23</span>
            <span class="calendar-item hidden" data-day="일">24</span>
            <span class="calendar-item hidden" data-day="월">25</span>
            <span class="calendar-item hidden" data-day="화">26</span>
            <span class="calendar-item hidden" data-day="수">27</span>
            <span class="calendar-item hidden" data-day="목">28</span>
            <span class="calendar-item hidden" data-day="금">29</span>
            <span class="calendar-item hidden" data-day="토">30</span>
        </div>
    </div>
    <span class="arrow" onclick="scrollCalendar(1)">&gt;</span> <!-- 오른쪽 화살표 -->
    <i class="fa-solid fa-calendar" style="margin-left: 10px; cursor: pointer;"></i> <!-- 달력 아이콘 -->
</div>



<!-- 축제 이미지 섹션 -->
<div class="festival-images">
    <div class="image-item2">
     <a href="${pageContext.request.contextPath}/Festival/Event" class="image-item2">
        <img src="${pageContext.request.contextPath}/resources/images/T_6.png" alt="Festival Image 1">
        </a>
    </div>
    <div class="image-item2">
        <img src="${pageContext.request.contextPath}/resources/images/T_6.png" alt="Festival Image 2">
    </div>
    <div class="image-item2">
        <img src="${pageContext.request.contextPath}/resources/images/T_6.png" alt="Festival Image 3">
    </div>
</div>


<script src="${pageContext.request.contextPath}/resources/js/festival.js"></script>

</body>
</html>
