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
                fetch('/BBOL/HotPlace/update', {
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
                const talkIdx = this.getAttribute("data-talk-id");

                if (!talkIdx) {
                    console.error("talkIdx를 찾을 수 없습니다.");
                    return;
                }

                // 서버로 데이터 전송 (POST 방식)
                fetch('/BBOL/HotPlace/delete', {
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




//페이지네이션
$(document).ready(function() {
    // 페이지네이션 버튼 클릭 시 AJAX 요청
    $('.pagination').on('click', '.pagination-link', function(e) {
        e.preventDefault(); // 기본 이벤트 방지 (페이지 새로고침 방지)

        var page = $(this).data('page'); // 버튼의 data-page 속성에서 페이지 번호 가져오기
        
        $.ajax({
            url: '/BBOL/HotPlace/' + contentid + '/comments', // 서버의 올바른 URL
            type: 'GET',
            data: { page: page }, // 페이지 번호 전달
            dataType: 'json', // JSON으로 받음
            success: function(data) {
                console.log("서버에서 받은 data: ", data); // 서버에서 반환된 데이터 출력

                var talkList = data.talkList || []; // talkList 배열 가져오기
                console.log("talkList 데이터: ", talkList);

                if (talkList.length > 0) {
                    // 서버에서 반환된 데이터로 페이지 내용 업데이트
                    $('.comments-section').html(talkList.map(talk => 
                        `<div class="comment" data-talk-id="${talk.talkIdx}">
                            <div class="user-info">
                                <img src="${talk.talkProfile}" alt="user-profile">
                                <span class="username">${talk.talkNickname}</span>
                                <span class="date">${talk.talkUpdatedAt ? talk.talkUpdatedAt : talk.talkCreatedAt}</span>
                            </div>
                            <p class="comment-text">${talk.talkText}</p>
                            <textarea class="edit-comment-text" style="display:none;">${talk.talkText}</textarea>
                            <div class="comment-actions">
                                ${memberEmail == talk.talkEmail ? `
                                    <button class="delbtn" data-talk-id="${talk.talkIdx}">삭제하기</button>
                                    <button class="editbtn" data-talk-id="${talk.talkIdx}">수정하기</button>
                                ` : ''}
                                <button class="cancelbtn" data-talk-id="${talk.talkIdx}" style="display:none;">취소하기</button>
                                <button class="savebtn" data-talk-id="${talk.talkIdx}" style="display:none;">저장하기</button>
                            </div>
                        </div>`).join('')); // 댓글 리스트 업데이트
                } else {
                    console.log("talkList가 비어 있습니다."); // 비어있는 경우 로그 출력
                    $('.comments-section').html('<p>댓글이 없습니다.</p>');  // 댓글이 없을 때 처리
                }

                // 페이지네이션 업데이트
                var currentPageNumber = data.currentPageNumber;
                var totalPages = data.totalPages;
                $('.pagination').html(createPagination(parseInt(totalPages), parseInt(currentPageNumber))); // 페이지네이션 업데이트
            },
            error: function(xhr, status, error) {
                console.log("댓글 가져오기 오류: " + error);
            }
        });
    });
});

//페이지네이션 추가 페이지 생성
function createPagination(totalPages, currentPage) {
    let paginationHtml = '';
    for (let i = 1; i <= totalPages; i++) {
        if (i === currentPage) {
            paginationHtml += `<span class="current-page">${i}</span>`;
        } else {
            paginationHtml += `<button class="pagination-link" data-page="${i}">${i}</button>`;
        }
    }
    return paginationHtml;
}

