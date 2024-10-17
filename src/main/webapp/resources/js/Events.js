// 로그인 상태 확인 함수
function isLoggedIn() {
    return isLoggedIn; // JSP에서 전달받은 전역 변수 사용
}


/*
function submitComment() {

    if (!isLoggedIn()) {//로그인이 안된 경우
    
        alert("로그인 후 댓글을 작성할 수 있습니다.");
        redirectToLogin();
        return;
    }

    const commentContent = document.getElementById('commentContent').value;

    if (commentContent.trim() === "") {
        alert("댓글을 입력하세요.");
        return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open("POST", `${contextPath}/Festival/comments`, true); // JSP에서 전달받은 전역 변수 사용
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onload = function() {
        if (xhr.status === 200) {
            alert("댓글이 등록되었습니다.");
            document.getElementById('commentContent').value = '';
            loadComments(); // 댓글 목록 새로고침
        } else {
            alert("댓글 등록에 실패했습니다.");
        }
    };

    // 요청 본문에 필요한 데이터 필드를 맞춰 전송
    xhr.send(JSON.stringify({
        eventId: eventId, 
        memberId: memberId, 
        t_comment_content: commentContent 
    }));
}
*/


// 로그인 페이지로 리디렉션
function redirectToLogin() {
    window.location.href = `${contextPath}/Login/login`;
}

// 댓글 목록을 불러오는 함수
function loadComments() {
    const xhr = new XMLHttpRequest();
    xhr.open("GET", `${contextPath}/Festival/comments?eventId=${eventId}`, true);

    xhr.onload = function() {
        if (xhr.status === 200) {
            const comments = JSON.parse(xhr.responseText);
            const commentsSection = document.getElementById('commentsSection');
            commentsSection.innerHTML = '';

            comments.forEach(comment => {
                const commentDiv = document.createElement('div');
                commentDiv.className = 'comment';
                commentDiv.innerHTML = `
                    <div class="user-info">
                        <span class="username">${comment.t_comment_author_id}</span>
                        <span class="date">${comment.t_comment_created_at}</span>
                    </div>
                    <p>${comment.t_comment_content}</p>
                    <div class="comment-actions">
                        <i class="fa-solid fa-thumbs-up"></i> 좋아요 <span>${comment.t_comment_likes}</span>
                        <i class="fa-solid fa-comment-dots"></i> 답글
                    </div>
                `;
                commentsSection.appendChild(commentDiv);
            });
        } else {
            alert("댓글 목록을 불러오는 데 실패했습니다.");
        }
    };

    xhr.send();
}
