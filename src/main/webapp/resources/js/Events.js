document.addEventListener("DOMContentLoaded", function() {
    // 수정 버튼에 이벤트 추가
    const editButtons = document.querySelectorAll('.editbtn');
    const saveButtons = document.querySelectorAll('.savebtn');
    const cancelButtons = document.querySelectorAll('.cancelbtn');

    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            const t_ec_idx = this.getAttribute("data-t_ec_idx");
            const commentDiv = this.closest('.comment');

            if (!commentDiv) {
                console.error("commentDiv 요소를 찾을 수 없습니다.");
                return;
            }

            const commentText = commentDiv.querySelector('.comment-text');
            const editCommentText = commentDiv.querySelector('.edit-comment-text');
            const saveButton = commentDiv.querySelector('.savebtn');
            const cancelButton = commentDiv.querySelector('.cancelbtn');
            const deleteButton = commentDiv.querySelector('.delbtn'); // 삭제 버튼 선택

            // 요소가 null인지 확인 후 처리
            if (!commentText || !editCommentText || !saveButton || !cancelButton || !deleteButton) {
                console.error("필수 요소 중 하나를 찾을 수 없습니다. 수정 작업을 중단합니다.");
                return;
            }

            // 기존 텍스트 숨기고 수정용 텍스트 에어리어 표시
            commentText.style.display = 'none';
            editCommentText.style.display = 'block';
            this.style.display = 'none'; // 수정 버튼 숨기기
            saveButton.style.display = 'inline'; // 저장 버튼 표시
            cancelButton.style.display = 'inline'; // 취소 버튼 표시
            deleteButton.style.display = 'none'; // 삭제 버튼 숨기기
        });
    });

    // 저장 버튼에 이벤트 추가
    saveButtons.forEach(button => {
        button.addEventListener('click', function() {
            const t_ec_idx = this.getAttribute("data-t_ec_idx");
            const commentDiv = this.closest('.comment');

            if (!commentDiv) {
                console.error("commentDiv 요소를 찾을 수 없습니다.");
                return;
            }

            const editCommentText = commentDiv.querySelector('.edit-comment-text');
            if (!editCommentText) {
                console.error("editCommentText 요소를 찾을 수 없습니다.");
                return;
            }

            const updatedText = editCommentText.value.trim();

            if (updatedText) {
                // 서버로 데이터 전송 (POST 방식)
                fetch('/Festival/updateComment', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 't_ec_idx=' + encodeURIComponent(t_ec_idx) + '&updatedText=' + encodeURIComponent(updatedText)
                })
                .then(response => response.text())
                .then(result => {
                    if (result.trim() === 'SUCCESS') {
                        alert('수정 완료!');
                        window.location.reload(); // 페이지 새로고침으로 댓글 갱신
                    } else {
                        alert('수정 실패!');
						window.location.reload();
                    }
                })
                .catch(error => {
                    console.error('수정 중 오류:', error);
					window.location.reload();
                });
            } else {
                alert('댓글 내용을 입력해주세요.');
            }
        });
    });

    // 취소 버튼에 이벤트 추가
    cancelButtons.forEach(button => {
        button.addEventListener('click', function() {
            const commentDiv = this.closest('.comment');
            if (!commentDiv) {
                console.error("commentDiv 요소를 찾을 수 없습니다.");
                return;
            }

            const commentText = commentDiv.querySelector('.comment-text');
            const editCommentText = commentDiv.querySelector('.edit-comment-text');
            const editButton = commentDiv.querySelector('.editbtn');
            const saveButton = commentDiv.querySelector('.savebtn');
            const cancelButton = commentDiv.querySelector('.cancelbtn');
            const deleteButton = commentDiv.querySelector('.delbtn'); // 삭제 버튼 선택

            if (!commentText || !editCommentText || !editButton || !saveButton || !cancelButton || !deleteButton) {
                console.error("필수 요소 중 하나를 찾을 수 없습니다. 수정 작업을 취소합니다.");
                return;
            }

            // 기존 텍스트 다시 표시
            commentText.style.display = 'block';
            editCommentText.style.display = 'none';
            editButton.style.display = 'inline';
            saveButton.style.display = 'none';
            cancelButton.style.display = 'none';
            deleteButton.style.display = 'inline'; // 삭제 버튼 다시 표시
        });
    });
});

// 댓글 삭제하기

document.addEventListener("DOMContentLoaded", function() {
    // 모든 삭제 버튼에 이벤트 추가
    const deleteButtons = document.querySelectorAll('.delbtn');

    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 삭제 확인 경고창 표시
            const confirmDelete = confirm("정말 삭제하시겠습니까?");

            if (confirmDelete) {
                // 삭제할 댓글의 ID 가져오기
                const t_ec_idx = this.getAttribute("data-t_ec_idx"); // t_ec_idx 가져오기

                if (!t_ec_idx) {
                    console.error("t_ec_idx를 찾을 수 없습니다.");
                    return;
                }

                // 서버로 데이터 전송 (POST 방식)
                fetch('/Festival/deleteComment', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 't_ec_idx=' + encodeURIComponent(t_ec_idx)
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error("네트워크 응답이 올바르지 않습니다.");
                    }
                    return response.text();
                })
                .then(result => {
                    if (result.trim() === 'SUCCESS') {
                        alert('댓글이 삭제되었습니다.');
                        window.location.reload(); // 페이지 새로고침으로 댓글 갱신
                    } else {
                        alert('댓글 삭제에 실패했습니다.');
                        window.location.reload(); // 페이지 새로고침으로 댓글 갱신
                    }
                })
                .catch(error => {
                    console.error('삭제 중 오류:', error); // 삭제 중 발생한 오류 출력
                    window.location.reload(); // 페이지 새로고침으로 댓글 갱신
                });
            } else {
                console.log("삭제 취소됨"); // 사용자가 삭제를 취소했는지 확인
                return;
            }
        });
    });
});
