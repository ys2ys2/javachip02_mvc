$(document).ready(function() {
    // 필터 버튼 클릭 이벤트
    $('.filter-button').click(function() {
        var filter = $(this).data('filter'); // 버튼의 data-filter 속성값을 가져옴
        loadPostsByFilter(filter); // 필터에 따라 게시글 목록 불러오기
    });

    // 검색 버튼 클릭 이벤트
    $('#search-button').click(function() {
        var query = $('#search-query').val(); // 검색어 가져오기
        loadPostsByFilter(currentFilter, 1, query); // 검색어와 함께 게시글 필터링
    });

    // 페이지 로드 시 기본적으로 "전체" 필터를 적용
    loadPostsByFilter('전체');
});

let currentFilter = '전체'; // 현재 필터 값을 저장하는 전역 변수

// 필터에 맞는 게시글을 가져와서 렌더링하는 함수
function loadPostsByFilter(filter, page = 1, query = '') {
    currentFilter = filter; // 현재 필터를 저장해둠

    $.ajax({
        url: contextPath + '/Community/filterPosts',
        type: 'GET',
        data: { filter: filter, page: page, pageSize: 9, query: query },  // 페이지 번호, 사이즈, 검색어 전달
        dataType: 'json',
        success: function(response) {
            var posts = response.posts;  // 현재 페이지의 게시글 리스트
            var postList = $('.post-list');
            postList.empty();  // 기존 게시글 목록 초기화

            if (posts && posts.length > 0) {
                posts.forEach(function(post) {
    var imageUrl = (post.mediaList && post.mediaList.length > 0) ? 
        contextPath + '/resources/uploads/' + post.mediaList[0].save_filename : 
        contextPath + '/resources/images/default-thumbnail.png';

    var postItem = `
    <a href="${contextPath}/Community/travelPostDetail/${post.tp_idx}" class="post-item">
        <img src="${imageUrl}" alt="게시글 이미지" class="post-image">
        <div class="post-content">
            <h5 class="post-title">${post.title}</h5>
            <div class="post-stats">
                <div class="stat-item">
                    👍 좋아요: ${post.likeCount}
                </div>
                <div class="stat-item">
                    📝 댓글: ${post.commentCount}
                </div>
            </div>
        </div>
    </a>
`;
    
    
    
    postList.append(postItem);
});
                

                // 페이지네이션 버튼 생성
                createPagination(response.totalPostCount, page);
            } else {
                postList.append('<p>게시글이 없습니다.</p>');
            }
        },
        error: function(xhr, status, error) {
            console.error('Error fetching posts:', error);
        }
    });
}

// 페이지네이션 버튼 생성 함수
function createPagination(totalPosts, currentPage) {
    var totalPages = Math.ceil(totalPosts / 9);  // 전체 페이지 수 계산 (페이지당 9개)
    var pagination = $('.pagination');  // 페이지네이션을 표시할 영역
    pagination.empty();  // 기존 페이지 버튼 초기화

    // 이전 페이지 버튼
    if (currentPage > 1) {
        pagination.append(`<button class="page-btn" data-page="${currentPage - 1}">이전</button>`);
    }

    // 페이지 번호 버튼 생성
    for (var i = 1; i <= totalPages; i++) {
        var activeClass = (i === currentPage) ? 'active' : '';
        var pageButton = `<button class="page-btn ${activeClass}" data-page="${i}">${i}</button>`;
        pagination.append(pageButton);
    }

    // 다음 페이지 버튼
    if (currentPage < totalPages) {
        pagination.append(`<button class="page-btn" data-page="${currentPage + 1}">다음</button>`);
    }

    // 페이지 번호 클릭 시 해당 페이지 게시글 불러오기
    $('.page-btn').click(function() {
        var selectedPage = $(this).data('page');
        loadPostsByFilter(currentFilter, selectedPage);  // 해당 페이지의 게시글 불러오기
    });
}
