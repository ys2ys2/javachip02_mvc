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
	<script type="text/javascript">
    // 로그인 체크 함수
    function checkLoginAndRedirect(targetUrl) {
        // 로그인 사용자 정보를 hidden input으로 확인
        const m_idx = document.getElementById('loggedUserIdx').value;

        if (!m_idx) { // m_idx가 없으면 로그인 상태가 아님
            alert("로그인이 필요합니다.");
            window.location.href = `\${contextPath}/Member/login`; // 로그인 페이지로 리다이렉트
            return false;
        } else {
            // 로그인 상태이면 지정된 URL로 이동
            window.location.href = targetUrl;
            return true;
        }
    }
</script>

</head>
<body>
		<!-- 로그인한 사용자 정보 hidden input으로 전달 -->
<input type="hidden" id="loggedUserIdx" value="${member.m_idx}">
<input type="hidden" id="loggedUserNickname" value="${member.m_nickname}">
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
	
	<!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />

   

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
            	<button class="write-btn" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/Community/travelWrite')">여행기 작성하기</button>
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
                <div id="modal-post-content"></div>
				
                <!-- 댓글 섹션 -->
                <div id="commentSection">
                    <h3>댓글</h3>
                    <div id="commentList"></div> <!-- 댓글 목록이 로드되는 부분 -->
                    <form id="commentForm">
                        <div class="comment-input-container">
                            <textarea id="commentInput" placeholder="댓글을 작성하세요" required></textarea>
                            <div class="button-group">
                                <button type="submit" id="submitComment">댓글 작성</button>
                                <button id="likeButton">좋아요 (${likeCount})</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />

    <script src="${pageContext.request.contextPath}/resources/js/post.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/travelpost.js"></script>
    
  
    
</body>
</html>
