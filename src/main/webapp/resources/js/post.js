$(document).ready(function () {
    // contextPath와 로그인한 사용자 ID를 숨겨진 input 필드에서 가져오기
    const contextPath = $('#contextPath').val();
    const m_idx = $('#loggedUserIdx').val();
    
	$('#postDetailModal').hide();
	$('#postWriteModal').hide();
	
    console.log(`Resolved context path: ${contextPath}`);
    loadPosts();

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
                posts.forEach(post => {
                    postListHtml += `<div class="post" data-post-id="${post.id}" data-post-date='${JSON.stringify(post.postDate)}'>
                        <div class="post-user">
                            <span class="username">${post.post_writer}님</span>
                            <span class="created-time">${formatDate(post.postDate)}</span>
                        </div>
                        <p class="post-content">${post.content}</p>
                        <div class="post-info">
                            <span class="comment-count">📝댓글: ${(post.commentCount || 0)}</span>
                            <span class="like-count">👍좋아요: ${(post.likeCount || 0)}</span>
                        </div>
                    </div>`;
                });
                $('#postList').html(postListHtml);
            },
            error: function (xhr) {
                console.error("게시글 목록 로드 실패:", xhr.responseText);
                alert('게시글 목록을 불러오는 데 실패했습니다.');
            }
        });
    }

    $('#openPostModal').on('click', function () {
        $('#postWriteModal').fadeIn();
    });

    $('#closePostWriteModal').on('click', function () {
        $('#postWriteModal').fadeOut();
        $('#postForm')[0].reset();
    });

    $('#postForm').on('submit', function (e) {
        e.preventDefault();
        let postContent = $('#modalPostContent').val().trim();
        if (!postContent) {
            alert('내용을 입력해 주세요.');
            return;
        }

let postData = { m_idx: m_idx, content: postContent };
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
            if (xhr.status === 401) {
                alert('로그인이 필요합니다.');
            } else {
                console.error("게시글 작성 중 오류 발생:", xhr.responseText);
                alert('게시글 작성 중 오류가 발생했습니다.');
            }
        }
    });
});
    $('#postList').on('click', '.post', function () {
        const post_id = this.dataset.postId;
        console.log("클릭된 게시글 ID:", post_id);

        if (!post_id) {
            alert('게시글 ID가 유효하지 않습니다.');
            return;
        }

        $('#postDetailModal').data('post-id', post_id);

        const url = `${contextPath}/post/detail/${post_id}`;
        console.log("요청 경로:", url);

        openPostDetailModal(url);
    });

    function openPostDetailModal(url) {
    $.ajax({
        type: 'GET',
        url: url,
        dataType: 'json',
        success: function (post) {
            const post_id = post.id;
            const formattedDate = formatDate(post.postDate);

            // HTML 구조를 수정하여 post-date 클래스를 추가
            $('#modal-post-content').html(`
                <h2>by: <span class="post-writer">${post.post_writer}</span></h2>
                <span class="post-date">${formattedDate}</span> <!-- 여기에 클래스 추가 -->
                <hr>
                <p>${post.content}</p>
            `);

            $('#likeButton').data('liked', post.isLiked);
            $('#likeButton').text(post.isLiked ? `좋아요 취소 (${post.likeCount})` : `좋아요 (${post.likeCount})`);
            $('#likeButton').data('post-id', post_id);

            loadComments(post_id);
            $('#postDetailModal').fadeIn();
        },
        error: function (xhr) {
            console.error("게시글 상세 로드 실패:", xhr.responseText);
            alert('게시글을 불러오는 데 실패했습니다.');
        }
    });
}

    $(document).on('click', '#likeButton', function () {
        const postId = $(this).data('post-id');
        
        if (!m_idx) {
            alert('로그인이 필요합니다.');
            return;
        }

        $.ajax({
            type: 'POST',
            url: `${contextPath}/post/${postId}/like`,
            contentType: 'application/json',
            data: JSON.stringify({ m_idx: m_idx }),
            success: function (response) {
                console.log('좋아요 처리 성공:', response);
                const newLikedState = response.isLiked;
                const newLikeCount = response.likeCount;
                $('#likeButton').text(`좋아요 (${newLikeCount})`);
            	$('#likeButton').data('liked', newLikedState);
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert('로그인이 필요합니다.');
                } else {
                    console.error('좋아요 처리 중 오류 발생:', xhr.responseText);
                    alert('좋아요 처리 중 오류가 발생했습니다.');
                }
            }
        });
    });

    function loadComments(post_id) {
        const url = `${contextPath}/post/${post_id}/comments`;
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

                $('#commentList').html(commentHtml);
            },
            error: function (xhr) {
                console.error("댓글 로드 실패:", xhr.responseText);
                alert('댓글을 불러오는 데 실패했습니다.');
            }
        });
    }

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
        };

        $.ajax({
            type: 'POST',
            url: `${contextPath}/post/${post_id}/comments/add`,
            contentType: 'application/json',
            data: JSON.stringify(commentData),
            success: function () {
                alert('댓글이 작성되었습니다.');
                loadComments(post_id);
                $('#commentInput').val('');
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert('로그인이 필요합니다.');
                } else {
                    console.error('댓글 작성 중 오류:', xhr.responseText);
                    alert('댓글 작성 중 오류가 발생했습니다.');
                }
            }
        });
    });

    $(document).on('click', '.delete-comment-button', function (event) {
        event.preventDefault();
        const commentId = $(this).data('comment-id');
        const postId = $('#postDetailModal').data('post-id');

        if (!confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
            return;
        }

        $.ajax({
            type: 'DELETE',
            url: `${contextPath}/post/${postId}/comments/${commentId}`,
            success: function () {
                alert('댓글이 삭제되었습니다.');
                loadComments(postId);
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert('로그인이 필요합니다.');
                } else if (xhr.status === 403) {
                    alert('본인이 작성한 댓글만 삭제할 수 있습니다.');
                } else {
                    console.error('댓글 삭제 중 오류 발생:', xhr.responseText);
                    alert('댓글 삭제 중 오류가 발생했습니다.');
                }
            }
        });
    });

    function formatDate(dateString) {
        if (typeof dateString === "string") {
            const localDate = new Date(dateString);
            if (!isNaN(localDate.getTime())) {
                return localDate.toLocaleString('ko-KR', {
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

    $('#closeDetailModal').on('click', function () {
        $('#postDetailModal').fadeOut();
        loadPosts();
    });
});
