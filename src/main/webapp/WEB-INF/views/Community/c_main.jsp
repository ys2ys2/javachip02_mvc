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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- jQuery 로드 -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
    
    <!-- contextPath를 JavaScript 전역 변수로 설정 -->
    <script type="text/javascript">
        var contextPath = "${pageContext.request.contextPath}";
    </script>
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
        
        <div class="travel-header">
        	<h3>여행기 게시글 목록</h3>
        	<div class="travel-buttons">
            	<button class="write-btn" onclick="location.href='${pageContext.request.contextPath}/Community/travelWrite'">여행기 작성하기</button>
            	<button class="view-all-btn" onclick="location.href='${pageContext.request.contextPath}/Community/travelPostList'">여행기 전체보기</button>
        	</div>
    	</div>
            <div id="travelPostList">
                <div class="tag-section" id="tag-seoul">
                    <h4>#서울</h4>
                    <div class="post-list"></div>
                </div>
                <div class="tag-section" id="tag-busan">
                    <h4>#부산</h4>
                    <div class="post-list"></div>
                </div>
                <div class="tag-section" id="tag-jeju">
                    <h4>#제주</h4>
                    <div class="post-list"></div>
                </div>
                <div class="tag-section" id="tag-incheon">
                    <h4>#인천</h4>
                    <div class="post-list"></div>
                </div>
            </div>
        </div>
            

           

        <!-- 게시글 작성 모달 -->
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

        <!-- 게시글 상세 모달 -->
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
    </div>

   

    <script src="${pageContext.request.contextPath}/resources/js/post.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/travelpost.js"></script>
    
</body>
</html>
