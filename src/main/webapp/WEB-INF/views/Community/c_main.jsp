<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Travel Community</title>
    <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/c_mainstyles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/post_modal.css" rel="stylesheet">
    <!-- <link href="${pageContext.request.contextPath}/resources/css/travelList.css" rel="stylesheet"> -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
    <div class="overlay"></div>

    <header>
        <div class="header-container">
            <div class="logo">BBOL BBOL BBOL</div>
            <nav>
                <ul>
                    <li><a href="#">홈</a></li>
                    <li><a href="#">커뮤니티</a></li>
                    <li><a href="#">여행지</a></li>
                    <li><a href="#">여행뽈뽈</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <!-- 왼쪽 컨텐츠 (게시글 목록) -->
        <div class="left-content">
            <div class="post-header">
                <h2>게시글 목록</h2>
                <button id="openPostModal" class="modal-button">게시글 작성</button>
            </div>
            <div id="postList" class="post-list"></div>
        </div>
        

       <!-- 오른쪽 컨텐츠 (여행기 목록 포함) -->
         <div class="right-content">
           <jsp:include page="/WEB-INF/views/Community/c_board/travelPostList.jsp" flush="true" />
        </div> 

        <div id="postWriteModal" class="modal">
            <div class="modal-content">
                <span class="close" id="closePostWriteModal">&times;</span>
                <h2>게시글 작성</h2>
                <form id="postForm">
                    <textarea id="modalPostContent" placeholder="내용을 입력하세요" minlength="5" required></textarea>
                    <button type="submit" class="modal-button">작성 완료</button>
                </form>
            </div>
        </div>

        <div id="postDetailModal" class="modal">
   			 <div class="modal-content">
        	 <span class="close" id="closeDetailModal">&times;</span>
        	 
        	 <!-- 게시글 내용이 동적으로 삽입되는 부분 -->
        	 <div id="modal-post-content"></div>
			 <!-- 좋아요 버튼 섹션 추가 -->
       		 <div class="like-section">
            	<button id="likeButton">좋아요</button>
        	 </div>
        	 
        	 <!-- 댓글 섹션 -->
        	<div id="commentSection">
            	<h3>댓글</h3>
            <div id="commentList"></div> <!-- 댓글 목록이 로드되는 부분 -->
				
            	<!-- 댓글 입력 필드와 작성 버튼 -->
            	<form id="commentForm">
            	<textarea id="commentInput" placeholder="댓글을 작성하세요" required></textarea>
            	<button type="submit" id="submitComment">댓글 작성</button>
            	</form>
        	</div>
    	</div>
	</div>
        

<script>
    // JSP의 contextPath를 JavaScript 변수에 저장
    const contextPath = "${pageContext.request.contextPath}";
</script>
	
    <script>
    let likeRequestInProgress = false; // 이 변수를 전역에 선언하여 어디서든 접근 가능하게 합니다.
    
    $(document).ready(function () {
    	console.log(`Resolved context path: ${pageContext.request.contextPath}`);
        loadPosts();
        
     // 댓글 작성 이벤트 - 폼 submit 이벤트를 막고 Ajax 호출
        $('#commentForm').on('submit', function (e) {
            e.preventDefault(); // 기본 폼 제출 동작 막기
            
            const post_id = $('#postDetailModal').data('post-id'); // 모달에서 post_id 가져오기
            console.log("댓글 작성 - post_id:", post_id); // 디버그용 로그
            
            if (!post_id) {
                alert('게시글 ID를 가져올 수 없습니다.');
                return;
            }
            
            submitComment(post_id);
        });
        //게시글 목록 불러오기
        function loadPosts() {
            $.ajax({
                type: 'GET',
                url: `${pageContext.request.contextPath}/post/list`,
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
                        postListHtml += '<div class="post" data-post-id="' + post.id + '" data-post-date=\'' + JSON.stringify(post.postDate) + '\'>' 
                            + '<div class="post-user">'
                            + '<span class="username">' + post.writer + '님</span>'
                            + '<span class="created-time">' + new Date(post.postDate).toLocaleString() + '</span>'
                            + '</div>'
                            + '<p class="post-content">' + post.content + '</p>'
                            + '<div class="post-info">'
                            + '<span class="comment-count">댓글: ' + (post.commentCount || 0) + '</span>'
                            + '<span class="like-count">좋아요: ' + (post.likeCount || 0) + '</span>'
                            + '</div>'
                            + '</div>';
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
        //날짜 형식 변환
	function formatDate(dateArray) {
    if (Array.isArray(dateArray) && dateArray.length >= 3) {
        const [year, month, day, hour = 0, minute = 0] = dateArray;
        // UTC 시간으로 날짜 생성
        const utcDate = new Date(Date.UTC(year, month - 1, day, hour, minute));
        // 한국 표준시(KST)로 변환 (UTC + 9 시간) 지금서버 또는 데이터베이스가 UTC+3 시간대 그래서 +6을함
        const kstDate = new Date(utcDate.getTime() + (6 * 60 * 60 * 1000)); // UTC + 9시간
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
		// 새롭게 추가된 formatDateFromString 함수 (댓글의 문자열 날짜 변환)
		function formatDateFromString(dateString) {
	    	if (!dateString) return "유효하지 않은 날짜";
	    	const date = new Date(dateString.replace(' ', 'T')); // " " -> "T"로 변환

	    	if (isNaN(date)) {
	        	return "유효하지 않은 날짜";
	    	}

	    	return date.toLocaleString('ko-KR', {
	        	year: 'numeric',
	        	month: '2-digit',
	        	day: '2-digit',
	        	hour: '2-digit',
	        	minute: '2-digit',
	        	hour12: false
	   		});
		}

		//게시글 작성 모달 열기
        $('#openPostModal').on('click', function () {
            $('#postWriteModal').fadeIn();
        });
		
		
		// 예슬 추가 코드 
    	 // 로그인한 사용자만 글을 쓸 수 있게 하기 위해 로그인 여부를 확인하는 부분 추가
        $('#postForm').on('submit', function (e) {
            e.preventDefault();
            
            let postContent = $('#modalPostContent').val().trim();
            if (!postContent) {
                alert('내용을 입력해 주세요.');
                return;
            }

            // 서버에서 로그인한 사용자의 정보를 JSP 페이지로 전달받은 경우를 가정
            let writer = '${member != null ? member.m_nickname : ""}';  // JSP에서 로그인한 사용자의 m_idx 전달

            // 로그인하지 않은 사용자는 경고 메시지 표시
            if (!writer) {
                alert('로그인한 사용자만 글을 작성할 수 있습니다.');
                return;
            }

            // 로그인한 사용자의 m_idx 값과 게시글 데이터를 함께 전달
            let postData = { writer: writer, content: postContent };

            $.ajax({
                type: 'POST',
                url: `${pageContext.request.contextPath}/post/create`,
                contentType: 'application/json',
                data: JSON.stringify(postData),
                success: function () {
                    alert('게시글이 작성되었습니다.');
                    $('#postWriteModal').fadeOut();
                    loadPosts();  // 게시글 리스트를 새로 불러오는 함수
                },
                error: function (xhr) {
                    console.error("게시글 작성 중 오류 발생:", xhr.responseText);
                    alert('게시글 작성 중 오류가 발생했습니다.');
                }
            });
        });

		
		
		
		/* 영준이 코드 
		
		//게시글 작성
		
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
                url: `${pageContext.request.contextPath}/post/create`,
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
        }); */
      //게시글 작성 모달 닫기
        $('#closePostWriteModal').on('click', function () {
            $('#postWriteModal').fadeOut();
            $('#postForm')[0].reset();
        });
		
		//게시글 클릭 이벤트 (상세 모달 열기)
        $('#postList').on('click', '.post', function () {
            const post_id = this.dataset.postId;  
            console.log("클릭된 게시글 ID:", post_id);

            if (!post_id) {
                alert('게시글 ID가 유효하지 않습니다.');
                return;
            }
			
         	// post_id를 모달에 저장합니다.
            $('#postDetailModal').data('post-id', post_id);	
         	
         	// 좋아요 상태 초기화 (이전 상태가 남지 않도록)
            $('#likeButton').data('liked', false);
            //$('#likeButton').text('좋아요 (0)'); // 초기 텍스트 설정 (필요하면 기본값 설정)
            
         	const url = contextPath + "/post/detail/" + post_id;
            console.log("요청 경로:", url);

            openPostDetailModal(url);
        });

        //상세 모달 열기 함수
        function openPostDetailModal(url) {
    	$.ajax({
        	type: 'GET',
        	url: url,
        	dataType: 'json',
        	success: function (post) {
            		 const post_id = post.id; // 게시글 ID 변수에 저장
            		 const formattedDate = formatDate(post.postDate);
            		 //const isLiked = post.isLiked; // 서버에서 받아온 좋아요 상태
                     //const likeCount = post.likeCount; // 서버에서 받아온 좋아요 개수
					 const likeCount = post.likeCount || 0;
                     const isLiked = post.isLiked;
            // 기존에 정의된 HTML을 활용하고, 추가 삽입을 방지합니다.
            $('#modal-post-content').html(`
                <h2>작성자: \${post.writer}</h2>
                <span> \${formattedDate}</span>
                <hr>
                <p>내용: \${post.content}</p> 
            `);
            
         // 좋아요 상태에 따른 버튼 텍스트 설정
            $('#likeButton').text(isLiked ? `좋아요 취소 (\${likeCount})` : `좋아요 (\${likeCount})`);
            $('#likeButton').data('liked', isLiked); // 좋아요 상태를 저장
            $('#likeButton').data('post-id', post_id); // 현재 게시글의 postId 저장
            // 댓글 목록 로드 및 입력 UI는 한 번만 삽입됩니다.
            loadComments(post_id); 

            $('#postDetailModal').fadeIn();
        },
        error: function (xhr) {
            console.error("게시글 상세 로드 실패:", xhr.responseText);
            alert('게시글을 불러오는 데 실패했습니다.');
        }
    });
}
        // 댓글 목록 불러오기
        function loadComments(post_id) {
    	const url = contextPath + "/post/" + post_id + "/comments";
    		console.log("댓글 요청 경로:", url);

    		$.ajax({
        		type: 'GET',
        		url: url,
        		dataType: 'json',
        		success: function (comments) {
        			console.log("받아온 댓글:", comments);  // 디버그용 로그
            		
        			 // 댓글이 없을 경우 처리
                    if (!Array.isArray(comments) || comments.length === 0) {
                        $('#commentList').html('<p>댓글이 없습니다.</p>');
                        return;
                    }
        			
        			let commentHtml = comments.map(comment => `
                	<div class="comment">
                    <span class="comment-writer"> \${comment.commentWriter}</span>
                    <span class="comment-date"> \${formatDateFromString(comment.commentDate)}</span>
                    <p> \${comment.commentContent}</p>
                    <button class="delete-comment-button" data-comment-id="${comment.comment_id}">삭제</button>
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
        // 댓글 작성 함수 정의
		function submitComment(post_id) {
			const commentContent = $(`#commentInput`).val().trim();

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
        		//dataType: 'json',
        		data: JSON.stringify(commentData),
        		success: function (response) {
        			console.log('댓글 작성 성공: ', response);
            		alert('댓글이 작성되었습니다.');
            		loadComments(post_id); // 해당 게시글의 댓글 목록 새로고침
            		loadPosts(); // 게시글 목록 다시 불러오기
            		$('#commentInput').val('');  // 댓글 입력 필드 초기화
        	},
        		error: function (xhr, status, error) {
        			 console.error(`댓글 작성 중 오류: \${xhr.status} - \${xhr.statusText}`);
        	            console.error(`서버 응답: \${xhr.responseText}`);
        	            console.error(`응답 데이터 타입: \${xhr.getResponseHeader('Content-Type')}`);
        	            alert(`댓글 작성 중 오류가 발생했습니다: \${xhr.statusText}`);
        	}
    	});
	}
        // 댓글 삭제
        function deleteComment(post_id, comment_id) {
            const url = contextPath + "/post/" + post_id + "/comment/" + comment_id;

            $.ajax({
                type: 'DELETE',
                url: url,
                success: function () {
                    alert('댓글이 삭제되었습니다.');
                    loadComments(post_id);
                },
                error: function (xhr) {
                    console.error("댓글 삭제 중 오류 발생:", xhr.responseText);
                    alert('댓글 삭제 중 오류가 발생했습니다.');
                }
            });
        }
        //const url = contextPath + "/post/" + postId + "/like";
        // 좋아요 버튼 클릭 이벤트
    $(document).on('click', '#likeButton', function (event) {
        //event.preventDefault();
        //event.stopPropagation(); // 이벤트 전파 방지
        if (likeRequestInProgress) return; // 요청 중이면 중복 요청 방지
            likeRequestInProgress = true;
        
        const $button = $(this); // 버튼 참조
        //if ($button.prop('disabled') || likeRequestInProgress) return; // 이미 요청 중이면 종료
        
        const postId = $('#postDetailModal').data('post-id'); // 모달에 저장된 postId
        const isLiked = $button.data('liked'); // 현재 좋아요 상태
        const userId = 'guest_user'; // 임시 사용자 ID

       /*  if (!postId || !userId) {
            console.error('postId 또는 userId가 유효하지 않습니다.');
            return;
        } */
     	// 만약 userId가 제대로 설정되지 않는다면 기본 값을 설정
       /*  if (!userId) {
            console.error('userId가 유효하지 않습니다.');
            userId = 'default_user'; // 기본 값으로 설정 (임시)
        }  */

       /*  console.log('좋아요 처리 시작 - postId:', postId, 'isLiked:', isLiked, 'userId:', userId);

        $button.prop('disabled', true); // 즉시 비활성화
        likeRequestInProgress = true; // 요청 진행 플래그 활성화
        
        toggleLike(postId, userId, isLiked, $button); // AJAX 호출 */
        const url = contextPath + "/post/" + postId + "/like";
        const method = 'POST'; // 좋아요 추가/취소는 POST로 처리
    //});
    
         // 좋아요 추가/취소 함수
    //function toggleLike(postId, userId, isLiked, $button) {
        //const url = contextPath + "/post/" + postId + "/like";
        //const method = isLiked ? 'DELETE' : 'POST';
		//const method = 'POST'; // POST 요청으로 좋아요 추가/취소를 모두 처리
        //likeRequestInProgress = true; // 요청 진행 플래그 활성화
        //$button.prop('disabled', true); // 버튼 비활성화

        $.ajax({
            type: method,
            url: url,
            contentType: 'application/json',
            data: JSON.stringify({ userId: userId }),
            success: function (response) {
                //console.log('좋아요 처리 성공:', response);
                //alert(response.isLiked ? '좋아요가 취소되었습니다.' : '좋아요가 추가되었습니다.');

                // 좋아요 상태 업데이트
                //const newLikedState = !isLiked;
                //$button.data('liked', newLikedState);

                const newLikedState = response.isLiked; // 서버 응답에서 받아온 새로운 liked 상태
    			const newLikeCount = response.likeCount; // 서버 응답에서 받아온 새로운 좋아요 개수
                
                // 좋아요 개수 업데이트
                //const buttonText = $button.text();  // 버튼의 현재 텍스트
                //console.log('현재 버튼 텍스트:', buttonText);  // 텍스트 확인용 로그
				
                 // 좋아요 상태 업데이트
       			$button.data('liked', newLikedState);	
                
                //const likeTextMatch = buttonText.match(/\d+/); // 좋아요 개수 추출 (숫자 찾기)
                //const currentLikeCount = likeTextMatch ? parseInt(likeTextMatch[0], 10) : 0; // 숫자가 없으면 0으로 처리
                //console.log('현재 좋아요 수:', currentLikeCount);  // 좋아요 수 로그

                //const newLikeCount = newLikedState ? currentLikeCount + 1 : currentLikeCount - 1;
                //$button.text(`좋아요 (\${newLikeCount})`);
       		// 좋아요 개수 텍스트 업데이트 - 서버 응답의 좋아요 개수를 바로 사용
       		 $button.text(newLikedState ? `좋아요 취소 (\${newLikeCount})` : `좋아요 (\${newLikeCount})`);
       		// 게시글 목록을 새로고침하여 좋아요 상태 반영
             loadPosts();
            },
            error: function (xhr) {
                console.error('좋아요 처리 중 오류:', xhr.responseText);
                alert('좋아요 처리 중 오류가 발생했습니다.');
            },
           /*  complete: function () {
                likeRequestInProgress = false; // 플래그 해제
                $button.prop('disabled', false); // 버튼 재활성화 */
            //}
            
            complete: function () {
                likeRequestInProgress = false;
            }// 요청 완료 후 플래그 해제
        });
    });
    
        
		//상세 모달 닫기
        $('#closeDetailModal').on('click', function () {
            $('#postDetailModal').fadeOut();
            // 게시글 목록을 다시 불러와 좋아요 상태 반영
            loadPosts(); // 게시글 목록 새로고침
            
        });
    });
    </script>
</body>
</html>
