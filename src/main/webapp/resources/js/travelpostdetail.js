$(document).ready(function () {
    const tp_idx = $('#post-detail').data('tp-idx'); // 여행기 ID
    const contextPath = $('#contextPath').val();  // contextPath 가져오기

    // 좋아요 수를 가져오고 초기화
    let initialLikeCount = $('#likeButton').data('like-count'); 
    initialLikeCount = (typeof initialLikeCount !== 'undefined' && initialLikeCount !== null) ? initialLikeCount : 0;

    // 좋아요 상태를 가져오고 초기화
    let isLiked = $('#likeButton').data('liked');

    // 좋아요 알림을 보여주는 함수
    function showLikeAlert(message) {
        const alertBox = $('<div class="like-alert"></div>').text(message);
        $('body').append(alertBox);
        alertBox.fadeIn(400).delay(1500).fadeOut(400, function() {
            $(this).remove();
        });
    }

    // 페이지 로드 시 좋아요 상태에 따른 아이콘 설정
    function initializeLikeButton() {
        if (isLiked) {
            $('#likeButton .heart-icon').css('background-image', `url('${contextPath}/resources/images/heart_filled.png')`);
        } else {
            $('#likeButton .heart-icon').css('background-image', `url('${contextPath}/resources/images/heart_empty.png')`);
        }
        $('#likeButton .like-count').text(`(${initialLikeCount})`);
    }

    // 페이지 로드 시 좋아요 버튼 초기화
    initializeLikeButton();

    // 좋아요 버튼 클릭 이벤트
    $('#likeButton').click(function () {
        const currentLikedState = $(this).data('liked');  // 현재 좋아요 상태
        const userId = 'guest_user';  // 임시 사용자 ID (로그인 시스템이 있을 경우 교체)

        // tp_idx가 제대로 설정되어 있는지 확인
        if (!tp_idx) {
            console.error('Error: tp_idx is missing!');
            return;
        }

        $.ajax({
            url: `${contextPath}/Community/travelPost/${tp_idx}/like`,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ userId: userId }),
            success: function (response) {
                const newLikedState = response.isLiked;
                const newLikeCount = response.likeCount;

                // 좋아요 상태에 따라 알림 표시
                showLikeAlert(newLikedState ? "좋아요!" : "좋아요를 취소했습니다.");

                // 좋아요 상태에 따라 아이콘 변경 및 좋아요 수 업데이트
                $('#likeButton').data('liked', newLikedState);
                $('#likeButton').data('like-count', newLikeCount);  // 새로운 좋아요 수를 데이터 속성에 업데이트
                if (newLikedState) {
                    $('#likeButton .heart-icon').css('background-image', `url('${contextPath}/resources/images/heart_filled.png')`);
                } else {
                    $('#likeButton .heart-icon').css('background-image', `url('${contextPath}/resources/images/heart_empty.png')`);
                }
                $('#likeButton .like-count').text(`(${newLikeCount})`);
            },
            error: function (xhr, status, error) {
                console.error('좋아요 처리 중 오류 발생:', error);
                alert('좋아요 처리 중 오류가 발생했습니다.');
            }
        });
    });

    // 여행기 댓글 불러오기
    function loadTravelComments() {
        $.ajax({
            url: `${contextPath}/Community/travelPost/${tp_idx}/comments`,
            type: 'GET',
            dataType: 'json',
            success: function (comments) {
                let commentListHtml = '';

                if (comments.length > 0) {
                    comments.forEach(function (comment) {
                        commentListHtml += `
                            <div class="comment-item" data-comment-id="${comment.commentId}">
                                <span class="comment-writer">${comment.commentWriter}</span>
                                <span class="comment-date">${comment.commentDate}</span>
                                <p class="comment-content">${comment.commentContent}</p>
                                <button class="edit-comment" data-comment-id="${comment.commentId}">수정</button>
                                <button class="delete-comment" data-comment-id="${comment.commentId}">삭제</button>
                            </div>
                        `;
                    });
                } else {
                    commentListHtml = '<p>댓글이 없습니다.</p>';
                }

                $('#comment-list').html(commentListHtml);
            },
            error: function (xhr, status, error) {
                console.error('댓글 로딩 실패:', error);
                alert('댓글을 불러오는 데 실패했습니다.');
            }
        });
    }

    // 댓글 작성 처리
    $('#submit-comment').click(function () {
        const commentContent = $('#comment-text').val().trim();
        if (commentContent === '') {
            alert('댓글 내용을 입력해 주세요.');
            return;
        }

        const commentData = {
            tp_idx: tp_idx, // 여행기 ID
            commentWriter: 'guest_user', // 임시 작성자
            commentContent: commentContent
        };

        $.ajax({
            url: `${contextPath}/Community/travelPost/${tp_idx}/comments/add`,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(commentData),
            success: function () {
                alert('댓글이 작성되었습니다.');
                $('#comment-text').val(''); // 댓글 입력 필드 초기화
                loadTravelComments(); // 댓글 다시 로드
            },
            error: function (xhr, status, error) {
                console.error('댓글 작성 중 오류 발생:', error);
                alert('댓글 작성 중 오류가 발생했습니다.');
            }
        });
    });

    // 댓글 수정 처리
    $(document).on('click', '.edit-comment', function () {
        const commentId = $(this).data('comment-id');
        const newContent = prompt('댓글을 수정하세요:');
        if (newContent) {
            $.ajax({
                url: `${contextPath}/Community/travelPost/${tp_idx}/comments/${commentId}/edit`,
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({ commentContent: newContent }),
                success: function () {
                    alert('댓글이 수정되었습니다.');
                    loadTravelComments();
                },
                error: function (xhr, status, error) {
                    console.error('댓글 수정 중 오류 발생:', error);
                    alert('댓글 수정 중 오류가 발생했습니다.');
                }
            });
        }
    });

    // 댓글 삭제 처리
    $(document).on('click', '.delete-comment', function () {
        const commentId = $(this).data('comment-id');
        if (confirm('댓글을 삭제하시겠습니까?')) {
            $.ajax({
                url: `${contextPath}/Community/travelPost/${tp_idx}/comments/${commentId}/delete`,
                type: 'DELETE',
                success: function () {
                    alert('댓글이 삭제되었습니다.');
                    loadTravelComments();
                },
                error: function (xhr, status, error) {
                    console.error('댓글 삭제 중 오류 발생:', error);
                    alert('댓글 삭제 중 오류가 발생했습니다.');
                }
            });
        }
    });

    // 페이지 로드 시 댓글 불러오기
    loadTravelComments();
});
