$(document).ready(function() {
    // 각 태그별로 게시글을 로드
    loadTravelPostsByTag('서울', '#tag-seoul');
    loadTravelPostsByTag('부산', '#tag-busan');
    loadTravelPostsByTag('제주', '#tag-jeju');
    loadTravelPostsByTag('인천', '#tag-incheon');
});

function loadTravelPostsByTag(tag, containerId) {
    $.ajax({
        url: contextPath + "/Community/travelPostListData",
        type: "GET",
        dataType: "json",
        success: function(response) {
            console.log("Data for " + tag + ": ", response);  // 데이터를 콘솔에 출력
            
            var posts = response[tag];
            var section = $(containerId + ' .post-list');
            section.empty();  // 기존 목록 초기화
            
            if (posts && posts.length > 0) {
                posts.forEach(function(post) {
                    // 이미지가 있는지 확인하고, 없으면 기본 이미지를 사용
                    var imageUrl = (post.mediaList && post.mediaList.length > 0) ? 
                                   contextPath + '/resources/uploads/' + post.mediaList[0].save_filename : 
                                   contextPath + '/resources/images/default-thumbnail.png';

                    // 게시글 항목 HTML 생성 (이미지 상단, 제목 하단)
                    var postItem = '<div class="post-item">' +
                                       '<img src="' + imageUrl + '" alt="게시글 이미지" class="post-image">' +
                                       '<div class="post-title">' + post.title + '</div>' +
                                   '</div>';
                    section.append(postItem);
                });
            } else {
                section.append('<p>게시글이 없습니다.</p>');
            }
        },
        error: function(xhr, status, error) {
            console.error("Error fetching posts:", error);
        }
    });
}
