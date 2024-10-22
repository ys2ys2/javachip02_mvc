$(document).ready(function () {
    console.log(`Resolved context path: ${contextPath}`);
    loadPosts();
    

    // 게시글 목록 불러오기
    function loadPosts() {
        $.ajax({
            type: 'GET',
            url: `${contextPath}/post/list`,
            dataType: 'json',
            success: function (posts) {
                if (!Array.isArray(posts) || posts.length === 0) {
                    $('#postList').html('<p>게시글이 없습니다.</p>');
                    return;
                }

                let postListHtml = '';
                for (let i = 0; i < posts.length; i++) {
                    const post = posts[i];
                    const isLiked = post.isLiked;
                    postListHtml += `<div class="post" data-post-id="${post.id}" data-post-date='${JSON.stringify(post.postDate)}'>
                            <div class="post-user">
                                <span class="username">${post.writer}님</span>
                                <span class="created-time">${new Date(post.postDate).toLocaleString()}</span>
                            </div>
                            <p class="post-content">${post.content}</p>
                            <div class="post-info">
                                <span class="comment-count">댓글: ${(post.commentCount || 0)}</span>
                                <span class="like-count">좋아요: ${(post.likeCount || 0)}</span>
                            </div>
                        </div>`;
                }
                $('#postList').html(postListHtml);

                $('.post').each(function () {
                    const postDateArray = JSON.parse($(this).attr('data-post-date'));
                    const formattedDate = formatDate(postDateArray);
                    $(this).find('.created-time').text(formattedDate);
                });
            },
            error: function (xhr) {
                console.error("게시글 목록 로드 실패:", xhr.responseText);
                alert('게시글 목록을 불러오는 데 실패했습니다.');
            }
        });
    }

    // 게시글 작성 모달 열기
    $('#openPostModal').on('click', function () {
        $('#postWriteModal').fadeIn();
    });

    // 게시글 작성 모달 닫기
    $('#closePostWriteModal').on('click', function () {
        $('#postWriteModal').fadeOut();
        $('#postForm')[0].reset();
    });

    // 게시글 작성
    $('#postForm').on('submit', function (e) {
        e.preventDefault();
        let postContent = $('#modalPostContent').val().trim();
        if (!postContent) {
            alert('내용을 입력해 주세요.');
            return;
        }

        let postData = { writer: 'guest_user', content: postContent };
        $.ajax({
            type: 'POST',
            url: `${contextPath}/post/create`,
            contentType: 'application/json',
            data: JSON.stringify(postData),
            success: function () {
                alert('게시글이 작성되었습니다.');
                $('#postWriteModal').fadeOut();
                loadPosts();
            },
            error: function (xhr) {
                console.error("게시글 작성 중 오류 발생:", xhr.responseText);
                alert('게시글 작성 중 오류가 발생했습니다.');
            }
        });
    });

    // 게시글 클릭 이벤트 (상세 모달 열기)
    $('#postList').on('click', '.post', function () {
        const post_id = this.dataset.postId;
        console.log("클릭된 게시글 ID:", post_id);

        if (!post_id) {
            alert('게시글 ID가 유효하지 않습니다.');
            return;
        }

        // post_id를 모달에 저장합니다.
        $('#postDetailModal').data('post-id', post_id);

        const url = contextPath + "/post/detail/" + post_id;
        console.log("요청 경로:", url);

        openPostDetailModal(url);
    });

    // 상제 모달 열기 함수
    function openPostDetailModal(url) {
        $.ajax({
            type: 'GET',
            url: url,
            dataType: 'json',
            success: function (post) {
                const post_id = post.id; // 게시글 ID 변수에 저장
                const formattedDate = formatDate(post.postDate);

                $('#modal-post-content').html(`
                    <h2>작성자: ${post.writer}</h2>
                    <span> ${formattedDate}</span>
                    <hr>
                    <p>내용: ${post.content}</p>
                `);

                // 좋아요 및 댓글 데이터 로드
                $('#likeButton').data('liked', post.isLiked);
                $('#likeButton').text(post.isLiked ? `좋아요 취소 (${post.likeCount})` : `좋아요 (${post.likeCount})`);
                $('#likeButton').data('post-id', post_id);

                loadComments(post_id); // 댓글 로드 함수
                $('#postDetailModal').fadeIn();
            },
            error: function (xhr) {
                console.error("게시글 상세 로드 실패:", xhr.responseText);
                alert('게시글을 불러오는 데 실패했습니다.');
            }
        });
    }

   // 좋아요 버튼 클릭 이벤트
$(document).on('click', '#likeButton', function () {
    const postId = $(this).data('post-id'); // 모달에 저장된 postId
    const isLiked = $(this).data('liked'); // 현재 좋아요 상태
    const userId = 'guest_user'; // 임시 사용자 ID (실제 사용자 ID로 대체)

    if (!postId || !userId) {
        console.error('postId 또는 userId가 유효하지 않습니다.');
        return;
    }

    $.ajax({
        type: 'POST',
        url: `${contextPath}/post/${postId}/like`,
        contentType: 'application/json',
        data: JSON.stringify({ userId: userId }),  // 서버가 필요로 하는 데이터가 정확한지 확인
        success: function (response) {
            console.log('좋아요 처리 성공:', response);
            const newLikedState = response.isLiked;
            const newLikeCount = response.likeCount;
            $('#likeButton').text(newLikedState ? `좋아요 취소 (${newLikeCount})` : `좋아요 (${newLikeCount})`);
            $('#likeButton').data('liked', newLikedState);
        },
        error: function (xhr) {
            console.error('좋아요 처리 중 오류 발생:', xhr.responseText);
            alert('좋아요 처리 중 오류가 발생했습니다.');
        }
    });
});
   

    // 댓글 목록 불러오기
    function loadComments(post_id) {
        const url = contextPath + "/post/" + post_id + "/comments";
        console.log("댓글 요청 경로:", url);

        $.ajax({
            type: 'GET',
            url: url,
            dataType: 'json',
            success: function (comments) {
                if (!Array.isArray(comments) || comments.length === 0) {
                    $('#commentList').html('<p>댓글이 없습니다.</p>');
                    return;
                }

                let commentHtml = comments.map(comment => `
                    <div class="comment">
                        <span class="comment-writer"> ${comment.commentWriter}</span>
                        <span class="comment-date"> ${formatDateFromString(comment.commentDate)}</span>
                        <p> ${comment.commentContent}</p>
                        <button class="delete-comment-button" data-comment-id="${comment.commentId}">삭제</button>
                    </div>
                `).join('');

                $('#commentList').html(commentHtml); // 기존 목록만 업데이트
            },
            error: function (xhr) {
                console.error("댓글 로드 실패:", xhr.responseText);
                alert('댓글을 불러오는 데 실패했습니다.');
            }
        });
    }

    // 댓글 작성
    $('#commentForm').on('submit', function (e) {
        e.preventDefault();
        const post_id = $('#postDetailModal').data('post-id');
        const commentContent = $('#commentInput').val().trim();

        if (!commentContent) {
            alert('댓글 내용을 입력해 주세요.');
            return;
        }

        const commentData = {
            postId: post_id,
            commentContent: commentContent,
            commentWriter: 'guest_user' // 예시 작성자
        };

        $.ajax({
            type: 'POST',
            url: contextPath + "/post/" + post_id + "/comments/add",
            contentType: 'application/json',
            data: JSON.stringify(commentData),
            success: function () {
                alert('댓글이 작성되었습니다.');
                loadComments(post_id); // 댓글 목록 새로고침
                $('#commentInput').val(''); // 댓글 입력 필드 초기화
            },
            error: function (xhr) {
                console.error('댓글 작성 중 오류:', xhr.responseText);
                alert('댓글 작성 중 오류가 발생했습니다.');
            }
        });
    });

    // 댓글 삭제
    $(document).on('click', '.delete-comment-button', function (event) {
        event.preventDefault();
        const commentId = $(this).data('comment-id');
        const postId = $('#postDetailModal').data('post-id');

        if (!confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
            return; // 삭제 취소
        }

        $.ajax({
            type: 'DELETE',
            url: contextPath + "/post/" + postId + "/comments/" + commentId,
            success: function () {
                alert('댓글이 삭제되었습니다.');
                loadComments(postId); // 댓글 목록 새로고침
            },
            error: function (xhr) {
                console.error('댓글 삭제 중 오류 발생:', xhr.responseText);
                alert('댓글 삭제 중 오류가 발생했습니다.');
            }
        });
    });

    // 문자열 날짜 형식 변환 함수
    function formatDateFromString(dateString) {
        if (!dateString) return "유효하지 않은 날짜";
        const date = new Date(dateString.replace(' ', 'T'));
        if (isNaN(date)) return "유효하지 않은 날짜";

        return date.toLocaleString('ko-KR', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        });
    }
    // 날짜 형식 변환 함수 추가
function formatDate(dateArray) {
    if (Array.isArray(dateArray) && dateArray.length >= 3) {
        const [year, month, day, hour = 0, minute = 0] = dateArray;
        // UTC 시간으로 날짜 생성
        const utcDate = new Date(Date.UTC(year, month - 1, day, hour, minute));
        // UTC + 9 시간(한국 표준시)로 변환
        const kstDate = new Date(utcDate.getTime() + (9 * 60 * 60 * 1000));
        // 유효한 날짜인지 확인
        if (!isNaN(kstDate.getTime())) {
            return kstDate.toLocaleString('ko-KR', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                hour12: false
            });
        }
    }
    return "유효하지 않은 날짜";
}
    
    
    

    // 상세 모달 닫기
    $('#closeDetailModal').on('click', function () {
        $('#postDetailModal').fadeOut();
        loadPosts(); // 게시글 목록 새로고침
    });
});
