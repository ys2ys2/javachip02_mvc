let currentPage = 0; // 현재 페이지 인덱스 (0으로 시작)

function scrollCalendar(direction) {
    // 방향에 따라 페이지 인덱스 변경
    if (direction === 1) {
        currentPage = (currentPage + 1) % 2; // 오른쪽 화살표 클릭, 0 -> 1, 1 -> 0
    } else if (direction === -1) {
        currentPage = (currentPage - 1 + 2) % 2; // 왼쪽 화살표 클릭, 0 -> 1, 1 -> 0
    }

    // 보이는 숫자만 업데이트
    updateCalendarDisplay();
}

function updateCalendarDisplay() {
    const items = document.querySelectorAll('.calendar-item');
    const totalItems = items.length;

    // 모든 숫자 숨김
    items.forEach(item => item.classList.add('hidden'));

    // 현재 페이지에서 15개 숫자 보이기
    const startIndex = currentPage * 15; // 시작 인덱스 계산
    for (let i = 0; i < 15; i++) {
        const index = startIndex + i; // 해당 페이지의 인덱스
        if (index < totalItems) {
            items[index].classList.remove('hidden'); // 해당 숫자 표시
        }
    }
}

// 숫자를 클릭하면 색상이 변하도록
document.querySelectorAll('.calendar-item').forEach(item => {
    item.addEventListener('click', function() {

    });
});

// 초기 표시 업데이트
updateCalendarDisplay();

