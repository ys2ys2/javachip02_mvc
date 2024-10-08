<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.human.web.repository.PostDAO, com.human.web.vo.PostVO" %>
<%@ page import="com.human.web.repository.TravelPostDAO, com.human.web.vo.TravelPostVO" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><fmt:setTimeZone value="UTC" />
<%@ page import="java.util.List" %>

<%
// DAO 객체 생성 및 게시글 목록 불러오기
    PostDAO postDAO = new PostDAO();
    List<PostVO> postList = postDAO.getAllPosts();

    // postList를 request 객체에 바인딩하여 JSTL 태그에서 접근 가능하도록 설정
    request.setAttribute("postList", postList);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Travel Community</title>
  	<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css"> <!-- header.css -->
	<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css"> <!-- footer.css -->
	<link href="${pageContext.request.contextPath}/resources/css/c_mainstyles.css" rel="stylesheet" type="text/css"> <!-- c_mainstyles.css -->
    <link href="${pageContext.request.contextPath}/resources/css/post_modal.css" rel="stylesheet" type="text/css"> <!-- post_modal.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<div class="overlay"></div>

    <header>
        <div class="header-container">
            <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
            <nav>
                <ul>
                    <li><a href="#" data-ko="홈" data-en="Home">홈</a></li>
                    <li><a href="#" data-ko="커뮤니티" data-en="Community">커뮤니티</a></li>
                    <li><a href="#" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
                    <li><a href="#" data-ko="여행뽈뽈" data-en="BBOL BBOL BBOL">여행뽈뽈</a></li>
                    <button class="search-btn">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
          			<button class="user-btn" onclick="location.href='${pageContext.request.contextPath}/Login/login'">
                        <i class="fa-solid fa-user"></i>
                    </button>
                    <button class="earth-btn">
                        <i class="fa-solid fa-earth-americas"></i>
                    </button>
                    <button class="korean" id="lang-btn" data-lang="ko">English</button>
                </ul>
            </nav>
        </div>
    </header>
	
	
    <div class="container">
        <!-- 게시글 목록 영역 -->
        <div class="left-content">
            <div class="post-header">
                <h2>게시글 목록</h2>
                <button class="modal-button" id="openPostModal">게시글 작성</button>
            </div>

            <!-- 게시글 목록 -->
            <div id="postList">
                <c:forEach var="post" items="${postList}">
                    <div class="post" data-post-id="${post.postId}">
                           <div class="post-user">
                           <span class="username">${post.username}</span> · <span class="follow">팔로우</span>
                            <!-- 게시글 작성 시간 표시 -->
                          <span class="created-time">
                              <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                          </span>
                    </div>
                        <p class="post-content">${post.content}</p>
                        <div class="post-footer">
                            <span class="like-count">❤️ 좋아요: ${post.likeCount}</span>
                            <span class="comment-count">💬 댓글: ${post.commentCount}</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        
     <!-- 게시글 상세 보기 모달 -->
<div id="postDetailModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeDetailModal">&times;</span>
        <div id="modal-post-content">
            <!-- 게시글 상세 내용 표시 -->
            <c:forEach var="post" items="${postDetail}">
                <div class="post-detail-header">
                    <h2>작성자: ${post.username}</h2>
                    <span class="created-time">
                        <!-- 게시글 작성 시간 표시 (소수점 제거) -->
                        <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </span>
                </div>
                <div class="post-detail-content">
                    <p>${post.content}</p>
                </div>
                <div class="post-detail-footer">
                    <span class="like-count">좋아요 수: ${post.likeCount}</span>
                    <span class="comment-count">댓글 수: ${post.commentCount}</span>
                </div>
            </c:forEach>
        </div>

        <!-- 댓글 목록 -->
        <div id="modal-comments">
            <c:forEach var="comment" items="${commentList}">
                <div class="comment">
                    <div class="comment-header">
                        <span class="comment-username">${comment.username}</span>
                        <span class="comment-created-time">
                            <!-- 댓글 작성 시간 표시 -->
                            <fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                    </div>
                    <div class="comment-content">
                        ${comment.content}
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 댓글 입력 영역 -->
        <div class="comment-input">
            <textarea id="modalCommentContent" placeholder="댓글을 입력하세요..."></textarea>
            <div class="button-group">
                <button class="modal-button" id="submitComment">댓글 작성</button>
                <button class="modal-button" id="likeBtn">좋아요</button>
            </div>
        </div>
    </div>
</div>
     

        <!-- 오른쪽 태그 및 여행기 목록 영역 -->
        <div class="right-content">
            <!-- 여행기 작성 버튼 -->
		<button class="modal-button travel-write-button" onclick="location.href='${pageContext.request.contextPath}/Community/c_board/travelWrite'">여행기 작성</button>

            <!-- 서울 여행기 목록 -->
            <div class="tag-section" id="seoul-section">
                <h3>#서울 여행</h3>
                <div class="tag-travel-posts" id="seoulPostList">
                    <c:forEach var="travelPost" items="${seoulPosts}">
                        <div class="travel-post-card">
                            <img src="../${travelPost.imagePath}" alt="${travelPost.title}" class="travel-post-image"/>
                            <p class="travel-post-title">${travelPost.title}</p>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 부산 여행기 목록 -->
            <div class="tag-section" id="busan-section">
                <h3>#부산 여행</h3>
                <div class="tag-travel-posts" id="busanPostList">
                    <c:forEach var="travelPost" items="${busanPosts}">
                        <div class="travel-post-card">
                            <img src="../${travelPost.imagePath}" alt="${travelPost.title}" class="travel-post-image"/>
                            <p class="travel-post-title">${travelPost.title}</p>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 제주 여행기 목록 -->
            <div class="tag-section" id="jeju-section">
                <h3>#제주 여행</h3>
                <div class="tag-travel-posts" id="jejuPostList">
                    <c:forEach var="travelPost" items="${jejuPosts}">
                        <div class="travel-post-card">
                            <img src="../${travelPost.imagePath}" alt="${travelPost.title}" class="travel-post-image"/>
                            <p class="travel-post-title">${travelPost.title}</p>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 인천 여행기 목록 -->
            <div class="tag-section" id="incheon-section">
                <h3>#인천 여행</h3>
                <div class="tag-travel-posts" id="incheonPostList">
                    <c:forEach var="travelPost" items="${incheonPosts}">
                        <div class="travel-post-card">
                            <img src="../${travelPost.imagePath}" alt="${travelPost.title}" class="travel-post-image"/>
                            <p class="travel-post-title">${travelPost.title}</p>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <!-- 게시글 작성 모달 -->
    <div id="postWriteModal" class="modal">
        <div class="modal-content">
            <span class="close" id="closePostWriteModal">&times;</span>
            <h2>게시글 작성</h2>
            <form id="postForm">
                <label for="modalPostContent">내용*</label>
                <textarea id="modalPostContent" placeholder="여행 질문이나 정보를 공유해보세요!" minlength="5" maxlength="1000" required></textarea>
                <p>(최소 5자 이상 / 최대 1,000자 이내)</p>

                <!-- 파일 업로드 선택 영역 -->
                <div class="form-group">
                    <label for="file-upload" class="custom-file-upload">파일 선택</label>
                    <input id="file-upload" type="file" style="display:none;">
                    <span id="file-selected">선택된 파일 없음</span>
                </div>

                <!-- 모달 하단 버튼 영역 -->
                <div class="modal-footer">
                    <button class="modal-button" type="submit" id="submitPostModal">게시글 작성 완료</button>
                </div>
            </form>
        </div>
    </div>
    <!-- 푸터 부분 -->
    <footer>
        <div class="footer-container">
            <div class="footer-section">
                <h4>회사소개</h4>
                <ul>
                    <li><a href="#">회사소개</a></li>
                    <li><a href="#">브랜드 이야기</a></li>
                    <li><a href="#">채용공고</a></li>
                </ul>
            </div>

            <!-- 고객지원 -->
            <div class="footer-section">
                <h4>고객지원</h4>
                <ul>
                    <li><a href="#">공지사항</a></li>
                    <li><a href="#">자주묻는 질문</a></li>
                    <li><a href="#">문의하기</a></li>
                </ul>
            </div>

            <!-- 이용약관 -->
            <div class="footer-section">
                <h4>이용약관</h4>
                <ul>
                    <li><a href="#">이용약관</a></li>
                    <li><a href="#">개인정보처리방침</a></li>
                    <li><a href="#">저작권 보호정책</a></li>
                </ul>
            </div>

            <!-- 회사 정보 -->
            <div class="footer-company-info">
                <p>상호: (주)BBOL | 대표: 박예슬 | 사업자등록번호: 123-45-67890 | 통신판매업 신고번호: 2024-충남천안-00000 | 개인정보관리 책임자: 수수옥</p>
                <p>주소: 충청남도 천안시 동남구 123 | 이메일: support@BBOL3.com | 대표전화: 02-1234-5678</p>
                <p>© 2024 BBOLBBOLBBOL. All Rights Reserved.</p>
            </div>

            <!-- 소셜 미디어 -->
            <div class="footer-social">
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </footer>

    <script>
    $(document).ready(function () {
    	
    	// 게시글 작성 모달 열기
        $('#openPostModal').on('click', function () {
            $('#postWriteModal').css('display', 'block');
        });

        // 게시글 작성 모달 닫기
        $('#closePostWriteModal').on('click', function () {
            $('#postWriteModal').css('display', 'none');
        });

        // 게시글 작성 폼 제출 처리
        $('#postForm').on('submit', function (event) {
            event.preventDefault();

            var content = $('#modalPostContent').val();
            var imageFile = $('#file-upload').prop('files')[0];

            if (content.trim() === "") {
                alert("내용을 입력해주세요!");
                return;
            }

            var formData = new FormData();
            formData.append('content', content);
            if (imageFile) {
                formData.append('image', imageFile);
            }

            $.ajax({
                type: 'POST',
                url: 'savePost.jsp',
                data: formData,
                processData: false,
                contentType: false,
                success: function () {
                    alert("게시글이 등록되었습니다.");
                    $('#postWriteModal').css('display', 'none');
                    $('#modalPostContent').val('');
                    $('#file-upload').val('');
                    loadPosts();  // 게시글 목록 갱신
                },
                error: function () {
                    alert("게시글 등록에 실패했습니다.");
                }
            });
        });

        // 게시글 목록 새로고침 함수
        function loadPosts() {
            $.ajax({
                type: 'GET',
                url: 'loadPosts.jsp',
                success: function (response) {
                    $('#postList').html(response);
                },
                error: function () {
                    alert("게시글 목록을 불러오는 데 실패했습니다.");
                }
            });
        }


        // 게시글 클릭 시 상세 모달 열기
        $('#postList').on('click', '.post', function () {
            var postId = $(this).data('post-id');
            openPostDetailModal(postId);
        });

        // 게시글 상세 모달 열기 함수
        function openPostDetailModal(postId) {
            $.ajax({
                type: 'GET',
                url: 'getPostDetail.jsp',
                data: { postId: postId },
                success: function (response) {
                    $('#modal-post-content').html(response);
                    updateComments(postId);
                    $('#postDetailModal').css('display', 'block');
                    setCommentAndLikeHandlers(postId);
                },
                error: function () {
                    alert("게시글을 불러오는 데 실패했습니다.");
                }
            });
        }

        // 댓글 및 좋아요 핸들러 설정
        function setCommentAndLikeHandlers(postId) {
            // 댓글 작성 이벤트
            $('#submitComment').off('click').on('click', function () {
                var commentContent = $('#modalCommentContent').val();
                if (commentContent.trim() === '') {
                    alert("댓글 내용을 입력하세요!");
                    return;
                }

                $.ajax({
                    type: 'POST',
                    url: 'saveComment.jsp',
                    data: { postId: postId, content: commentContent },
                    success: function () {
                        $('#modalCommentContent').val('');
                        updateComments(postId);
                    },
                    error: function () {
                        alert("댓글 작성에 실패했습니다.");
                    }
                });
            });

            // 좋아요 클릭 이벤트
            $('#likeBtn').off('click').on('click', function () {
                $.ajax({
                    type: 'POST',
                    url: 'toggleLike.jsp',
                    data: { postId: postId },
                    success: function () {
                        updateLikeCount(postId);
                    },
                    error: function () {
                        alert("좋아요 처리에 실패했습니다.");
                    }
                });
            });
        }

        // 댓글 목록을 업데이트하는 함수
        function updateComments(postId) {
            $.ajax({
                type: 'GET',
                url: 'getComments.jsp',
                data: { postId: postId },
                success: function (response) {
                    $('#modal-comments').html(response);
                },
                error: function () {
                    alert("댓글 목록을 불러오는 데 실패했습니다.");
                }
            });
        }

        // 좋아요 수를 업데이트하는 함수
        function updateLikeCount(postId) {
            $.ajax({
                type: 'GET',
                url: 'getPostDetail.jsp',
                data: { postId: postId },
                success: function (response) {
                    $('#modal-post-content').html(response);
                },
                error: function () {
                    alert("좋아요 수 업데이트 실패");
                }
            });
        }

        // 모달 닫기 버튼
        $('#closeDetailModal').on('click', function () {
            $('#postDetailModal').css('display', 'none');
        });
    });
    </script>
    
   
    
</body>
</html>
