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

  // 전체 슬라이드 수 구하기 (복사된 슬라이드를 제외한 실제 슬라이드만 계산)
  var totalSlides = document.querySelectorAll('.swiper-wrapper .swiper-slide:not(.swiper-slide-duplicate)').length;
  document.querySelector('.total-slides').textContent = String(totalSlides).padStart(2, '0');
  document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');

  // 설명 업데이트 함수
  function updateDescription(index) {
    const description = descriptions[index % descriptions.length]; // 슬라이드 인덱스 순환 처리
    document.getElementById('description-title').innerHTML = description.title;
    document.getElementById('description-text').innerHTML = description.overview;
  }

  // 슬라이드 변경 시 설명 업데이트
  swiper.on('slideChange', function () {
    document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');
    updateDescription(swiper.realIndex); // 설명 박스 업데이트
  });

  // 초기 로드 시 첫 번째 슬라이드에 맞는 설명 표시
  updateDescription(swiper.realIndex);

  const pauseBtn = document.querySelector('.pause-btn');
  let isPaused = false;
  pauseBtn.addEventListener('click', function () {
    if (isPaused) {
      swiper.autoplay.start();
      pauseBtn.querySelector('img').src = '../images/btn_slidem_stop02.png';
    } else {
      swiper.autoplay.stop();
      pauseBtn.querySelector('img').src = '../images/btn_curation_play.png';
    }
    isPaused = !isPaused;
  });
});
