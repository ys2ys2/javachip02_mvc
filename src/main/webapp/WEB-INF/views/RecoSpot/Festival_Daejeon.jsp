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

<!-- 제목 섹션 -->
<div class="festival-header">
   <div class="section-title1">축제 어디까지 가봤니?</div>
</div>


<!-- 축제 이미지 슬라이더 섹션 -->
<div class="festival-slider">

    <div class="festival-slide">
        <a href="${pageContext.request.contextPath}/Festival/Event">
            <img src="${pageContext.request.contextPath}/resources/images/Festival_Seoul1.png" alt="Festival Image 1">
        </a>
    <div class="festival-info">
    <h3>서울일러스트레이션페어 V.18</h3>
   <p class="event-district">강남구</p>
    <div class="event-info">
        <p class="event-period">기간<br> 2024-12-22<br>~2024-12-22</p>
        <p class="event-location">장소(홀)<br> 예술의전당 콘서트홀</p>
    </div>
    <button class="action-button">바로가기</button>
</div>
    </div>
    
    
    <div class="festival-slide">
      <a href="${pageContext.request.contextPath}/Festival/Event2">
        <img src="${pageContext.request.contextPath}/resources/images/Festival_Seoul2.jpg" alt="Festival Image 2">
         </a>
          <div class="festival-info">
            <h3>2024 파리나무십자가 소년<br>합창단 특별초청공연</h3>
           <p class="event-district">강남구</p>
              <div class="event-info">
             <p class="event-period">기간<br> 2024-12-22<br>~2024-12-22</p>
             <p class="event-location">장소(홀)<br> 예술의전당 콘서트홀</p>
                 </div>
            <button class="action-button">바로가기</button>
        </div>
    </div>
    
    
        <div class="festival-slide">
          <a href="${pageContext.request.contextPath}/Festival/Event3">
        <img src="${pageContext.request.contextPath}/resources/images/Festival_Seoul3.png" alt="Festival Image 2">
          </a>
  <div class="festival-info">
    <h3>[종로문화재단] 음악동화 <br>행복의 파랑새</h3>
    <p class="event-district">종로구</p>
    <div class="event-info">
        <p class="event-period">기간<br>2024-12-12<br>~2024-12-13</p>
        <p class="event-location">장소(홀)<br>종로 아이들극장</p>
    </div>
    <button class="action-button">바로가기</button>
</div> 
    </div>
    </div>


<script>
const slider = document.querySelector('.festival-slider');
const slides = Array.from(document.querySelectorAll('.festival-slide'));

let isDragging = false;
let startX;
let scrollLeft;

// 활성화 상태 업데이트
function activateSlide() {
    const sliderCenter = slider.scrollLeft + slider.offsetWidth / 2;

    slides.forEach(slide => {
        const slideCenter = slide.offsetLeft + slide.offsetWidth / 2;

        // 슬라이드가 중앙에 위치하면 active 클래스를 추가
        if (Math.abs(sliderCenter - slideCenter) < slide.offsetWidth / 2) {
            slide.classList.add('active');
        } else {
            slide.classList.remove('active');
        }
    });
}

// 마우스 드래그로 슬라이드를 이동하는 기능
slider.addEventListener('mousedown', (e) => {
    isDragging = true;
    startX = e.pageX - slider.offsetLeft;
    scrollLeft = slider.scrollLeft;
    slider.classList.add('dragging');
});

slider.addEventListener('mouseleave', () => {
    isDragging = false;
    slider.classList.remove('dragging');
});

slider.addEventListener('mouseup', () => {
    isDragging = false;
    slider.classList.remove('dragging');
    activateSlide(); // 드래그 후 활성화된 슬라이드 업데이트
});

slider.addEventListener('mousemove', (e) => {
    if (!isDragging) return;
    e.preventDefault();
    const x = e.pageX - slider.offsetLeft;
    const walk = (x - startX) * 1.5; // 드래그 이동 속도 조절
    slider.scrollLeft = scrollLeft - walk;
});

// 초기 첫 번째 슬라이드를 중앙에 위치시키기 위해 설정
slider.scrollLeft = slides[0].offsetLeft - (slider.offsetWidth / 2 - slides[0].offsetWidth / 2);

// 초기 활성화 상태 설정
activateSlide();

</script>


<!-- <script src="${pageContext.request.contextPath}/resources/js/festival.js?v=1.0"></script> -->

</body>
</html>
