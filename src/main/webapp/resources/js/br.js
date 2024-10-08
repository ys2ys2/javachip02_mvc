// 공유하기 팝업 열기/닫기
function toggleSharePopup() {
    const popup = document.getElementById("sharePopup");
    const overlay = document.querySelector(".overlay");
    
    if (popup.style.display === "block") {
        popup.style.display = "none";
        overlay.style.display = "none";
    } else {
        // 현재 페이지 URL을 동적으로 설정
        const currentUrl = window.location.href;
        document.getElementById("shareUrl").value = currentUrl;

        popup.style.display = "block";
        overlay.style.display = "block";
    }
}

// URL 복사 기능
function copyUrl() {
    const shareUrlInput = document.getElementById("shareUrl");
    shareUrlInput.select();
    document.execCommand("copy");
    alert("URL이 복사되었습니다.");
}

// 현재 페이지 URL 가져오기
function getCurrentUrl() {
    return window.location.href;
}


// 페이스북에 공유
function shareToFacebook() {
    const url = encodeURIComponent(getCurrentUrl());
    const facebookUrl = `https://www.facebook.com/sharer/sharer.php?u=${url}`;
    window.open(facebookUrl, '_blank');
}

// 트위터 (X)에 공유
function shareToX() {
    const url = encodeURIComponent(getCurrentUrl());
    const text = encodeURIComponent("핫플 여행지를 공유합니다!"); // 트위터에 공유할 메시지
    const twitterUrl = `https://twitter.com/intent/tweet?url=${url}&text=${text}`;
    window.open(twitterUrl, '_blank');
}


// 카카오톡에 공유 (카카오 JavaScript SDK 필요)
function shareToKakao() {
    if (!Kakao.isInitialized()) {
        Kakao.init('3b3d23217cda81f7da7823b70119f483'); // 카카오 SDK 초기화 (내 카카오 디벨로퍼 앱키->javascript 키)
    }
    Kakao.Link.sendDefault({
        objectType: 'feed',
        content: {
            title: '핫플 여행지를 공유합니다!',
            description: '핫플 여행지를 확인하세요!',
			imageUrl: 'https://example.com/path/to/valid/image.jpg', // 이미지URL
            link: {
                mobileWebUrl: getCurrentUrl(),
                webUrl: getCurrentUrl(),
            },
        },
    });
}

// 밴드에 공유
function shareToBand() {
    const url = encodeURIComponent(getCurrentUrl());
    const title = encodeURIComponent("핫플 여행지를 공유합니다!");
    const bandUrl = `https://band.us/plugin/share?body=${title}&route=${url}`;
    window.open(bandUrl, '_blank');
}
 




/*document.addEventListener("DOMContentLoaded", function() {
    // description-text 요소 가져오기
    var descriptionElement = document.getElementById("description-text");

    // 텍스트 가져오기
    var descriptionText = descriptionElement.innerText;

    // 점('.')을 기준으로 텍스트를 분할하고, 각 문장 끝에 <br> 추가
    var formattedText = descriptionText.split('.').map(function(sentence) {
      return sentence.trim() + ' '; // 각 문장에 '.' 포함
    }).join('<br><br>'); // 문장마다 줄바꿈 추가

    // HTML로 다시 삽입
    descriptionElement.innerHTML = formattedText;
  });*/
  
  
  
  document.addEventListener("DOMContentLoaded", function() {
      // description-text 요소 가져오기
      var descriptionElement = document.getElementById("description-text");

      // 텍스트 가져오기
      var descriptionText = descriptionElement.innerText;

      // 점('.')을 기준으로 텍스트를 분할하고, 각 문장을 트림하여 배열로 변환
      var sentences = descriptionText.split('.').map(function(sentence) {
          return sentence.trim();
      });

      // 배열을 돌면서 두 번째 문장마다 줄바꿈을 추가
      var formattedText = "";
      sentences.forEach(function(sentence, index) {
          if (sentence !== "") { // 빈 문장은 무시
              formattedText += sentence;
              if ((index + 1) % 2 === 0) {
                  formattedText += ".<br>"; // 두 번째 문장마다 줄바꿈 추가
              } else if (index < sentences.length - 1) {
                  formattedText += ". "; // 그 외에는 그냥 점 추가
              }
          }
      });

      // HTML로 다시 삽입
      descriptionElement.innerHTML = formattedText;
  });



  // 자바스크립트로 섹션 이동 구현
document.addEventListener("DOMContentLoaded", function() {
  const navItems = document.querySelectorAll('.h_nav-item a');

  navItems.forEach(item => {
    item.addEventListener('click', function(event) {
      event.preventDefault(); // 기본 동작 방지 (페이지 상단 이동 방지)

      const targetId = this.getAttribute('data-target');
      const targetSection = document.getElementById(targetId);

      if (targetSection) {
        targetSection.scrollIntoView({ behavior: 'smooth' }); // 부드럽게 해당 섹션으로 스크롤
      }
    });
  });
});


// 댓글 작성하기
document.addEventListener("DOMContentLoaded", function() {
    const submitButton = document.getElementById('submitButton');

    if (submitButton) {
        submitButton.addEventListener('click', function() {
            const commentText = document.getElementById('commentText');
            if (commentText) {
                const commentValue = commentText.value.trim();
                if (commentValue) {
                    // 서버로 데이터 전송 (POST 방식)
                    fetch('submitTalk.jsp', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'talkText=' + encodeURIComponent(commentValue) // talkText로 수정
                    })
                    .then(response => response.text())
                    .then(result => {
                        if (result.trim() === 'success') {
                            alert('댓글이 성공적으로 등록되었습니다.');
                            window.location.reload(); // 페이지 새로고침으로 댓글 갱신
                        } else {
                            alert('댓글 등록에 실패했습니다.');
							window.location.reload(); // 페이지 새로고침으로 댓글 갱신
                        }
                    })
                    .catch(error => {
                        console.error('댓글 등록 중 오류:', error);
                    });
                } else {
                    alert('댓글을 입력해주세요.');
                }
            }
        });
    }
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
                const talkIdx = this.getAttribute("data-talk-id");
                
                if (!talkIdx) {
                    return;
                }
                
                // 서버로 데이터 전송 (POST 방식)
                fetch('deleteTalk.jsp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'talkIdx=' + encodeURIComponent(talkIdx)
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error("네트워크 응답이 올바르지 않습니다.");
                    }
                    return response.text();
                })
                .then(result => {
                    if (result.trim() === 'success') {
                        alert('댓글이 삭제되었습니다.');
                        window.location.reload(); // 페이지 새로고침으로 댓글 갱신
                    } else {
                        alert('댓글이 삭제되었습니다.');
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

//댓글 수정하기

document.addEventListener("DOMContentLoaded", function() {
    // 수정 버튼에 이벤트 추가
    const editButtons = document.querySelectorAll('.editbtn');
    const saveButtons = document.querySelectorAll('.savebtn');
    const cancelButtons = document.querySelectorAll('.cancelbtn');

    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            const talkIdx = this.getAttribute("data-talk-id");
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
            const talkIdx = this.getAttribute("data-talk-id");
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
                fetch('updateTalk.jsp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'talkIdx=' + encodeURIComponent(talkIdx) + '&updatedText=' + encodeURIComponent(updatedText)
                })
                .then(response => response.text())
                .then(result => {
                    if (result.trim() === 'success') {
                        alert('수정 완료!');
                        window.location.reload(); // 페이지 새로고침으로 댓글 갱신
                    } else {
                        alert('수정이 완료되었습니다.');
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

$(document).ready(function () {
    // 페이지네이션 버튼 클릭 시
    $('.pagination').on('click', '.pagination-link', function (e) {
        e.preventDefault(); // 기본 이벤트 막기 (페이지 새로고침 방지)

        var pageNumber = $(this).data('page'); // 클릭한 페이지 번호 가져오기

        // Ajax 요청을 통해 댓글 가져오기
        $.ajax({
            url: 'hotplace2.jsp', // 요청할 서버 측 URL
            type: 'GET',
            data: { page: pageNumber },
            success: function (response) {
                // 서버에서 가져온 HTML로 댓글 섹션 업데이트
                var newCommentsSection = $(response).find('.comments-section').html();
                $('.comments-section').html(newCommentsSection);

                // 페이지 번호도 업데이트
                var newPagination = $(response).find('.pagination').html();
                $('.pagination').html(newPagination);

                // 페이지 위치를 이동하지 않음 (단순히 화면을 원하는 위치로 스크롤)
                $('html, body').animate({
                    scrollTop: $("#section-talk").offset().top
                }, 500);
            },
            error: function (xhr, status, error) {
                console.error('댓글 가져오기 오류:', error);
            }
        });
    });
});











