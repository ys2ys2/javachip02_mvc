document.addEventListener('DOMContentLoaded', () => {
    const swiper = new Swiper('.swiper', {
        slidesPerView: 9, // 한번에 표시할 슬라이드 수
        spaceBetween: 10, // 슬라이드 간 간격
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        loop: true, // 반복 모드 활성화
        initialSlide: 0, // 첫 슬라이드를 항상 "서울"로 설정
    });

    // 원활한 반복을 위해 슬라이드를 복제하고 추가
    const slides = Array.from(document.querySelectorAll('.swiper-slide'));
    const slideCount = slides.length;

    // 반복 모드가 활성화된 경우 추가 복제 방지
    if (!swiper.params.loop) {
        slides.forEach(slide => {
            const cloneSlide = slide.cloneNode(true);
            swiper.appendSlide(cloneSlide);
        });
    }

    // 초기화 시 "서울"로 정확히 이동 (서울이 첫 번째 슬라이드인 것을 보장)
    swiper.on('init', () => {
        const seoulIndex = slides.findIndex(slide => slide.querySelector('img').alt === "서울");
        swiper.slideToLoop(seoulIndex, 0); // '0'은 전환 애니메이션 없이 이동
    });

    swiper.init(); // 슬라이더 초기화
});
