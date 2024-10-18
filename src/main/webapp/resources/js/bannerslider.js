document.addEventListener("DOMContentLoaded", function () {
  var swiper = new Swiper(".swiper", {
    slidesPerView: 2,
    spaceBetween: 30,
    pagination: {
      el: ".swiper-pagination",
      clickable: true,
    },
    loop: true,
    autoplay: {
      delay: 3000,
      disableOnInteraction: false,
    },
    speed: 400,
    navigation: {
      nextEl: ".next-btn",
      prevEl: ".prev-btn",
    },
  });
  
  	//배경색 배열주기
	const backgroundColors = [
	  "rgb(214, 240, 255)", // 첫 번째 슬라이드 배경색
	  "rgb(255, 225, 125)", // 두 번째 슬라이드 배경색
	  "rgb(227, 201, 238)", // 세 번째 슬라이드 배경색
	  "rgb(255, 240, 201)", // 네 번째 슬라이드 배경색
	  "rgb(255, 219, 221)", // 다섯 번째 슬라이드 배경색
	  "rgb(157, 206, 240)", // 여섯 번째 슬라이드 배경색
	  "rgb(210, 199, 255)"  // 일곱 번째 슬라이드 배경색
	];
  
  

  // 전체 슬라이드 수 구하기 (복사된 슬라이드를 제외한 실제 슬라이드만 계산)
  var totalSlides = document.querySelectorAll('.swiper-wrapper .swiper-slide:not(.swiper-slide-duplicate)').length;
  document.querySelector('.total-slides').textContent = String(totalSlides).padStart(2, '0');
  document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');

  // 설명과 "자세히 보기" 링크 업데이트 함수
  function updateDescription(index) {
    const description = descriptions[index % descriptions.length]; // 슬라이드 인덱스 순환 처리
    document.getElementById('description-title').innerHTML = description.title;
    document.getElementById('description-text').innerHTML = description.overview;

    // "자세히 보기" 링크 업데이트 (contextPath 변수를 사용하여 경로 설정)
    document.querySelector('.detail-link').setAttribute('href', contextPath + '/BannerPlace/' + description.contentid);
  }

  // 슬라이드 변경 시 설명 및 링크 업데이트
  swiper.on('slideChange', function () {
    document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');
    
    const newColor = backgroundColors[swiper.realIndex % backgroundColors.length]; //index값에 맞는 backgroundColor
    document.querySelector('.swiper-container').style.backgroundColor = newColor;
    document.querySelector('.description-box').style.backgroundColor = newColor;
    
    
    updateDescription(swiper.realIndex); // 설명 및 링크 업데이트
  });

  // 초기 로드 시 첫 번째 슬라이드에 맞는 설명 및 링크 표시
  updateDescription(swiper.realIndex);

  // 자동 슬라이드 일시 정지/재개 버튼
  const pauseBtn = document.querySelector('.pause-btn');
  let isPaused = false;
  pauseBtn.addEventListener('click', function () {
    if (isPaused) {
      swiper.autoplay.start();
      pauseBtn.querySelector('img').src = contextPath + '/resources/images/btn_slidem_stop02.png';
    } else {
      swiper.autoplay.stop();
      pauseBtn.querySelector('img').src = contextPath + '/resources/images/btn_curation_play.png';
    }
    isPaused = !isPaused;
  });
});
