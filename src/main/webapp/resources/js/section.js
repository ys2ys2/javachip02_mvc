document.querySelectorAll('.h_navbar a').forEach(anchor => {
  anchor.addEventListener('click', function(event) {
    event.preventDefault(); // 섹션 ID가 URL에 표시 안되게 방지
	
    //data-target으로 href 사용 안하기(href 사용하면 URL에 section ID가 찍혀서 지저분함)
    const targetId = this.getAttribute('data-target');
    const targetElement = document.getElementById(targetId); // 해당 ID의 섹션 요소 가져오기
    
    // 해당 섹션으로 부드럽게 스크롤
    targetElement.scrollIntoView({
      behavior: 'smooth' // 부드러운 스크롤 애니메이션
    });
  });
});
