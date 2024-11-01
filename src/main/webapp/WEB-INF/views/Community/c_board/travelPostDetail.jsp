<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setTimeZone value="UTC" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행기 상세보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/travelpostdetail.css">
   
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
   

    <!-- contextPath를 담은 숨겨진 필드 추가 -->
    <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
	<!-- 로그인한 사용자 정보 hidden input으로 전달 -->
    <input type="hidden" id="loggedUserIdx" value="${member.m_idx}">
    <input type="hidden" id="loggedUserNickname" value="${member.m_nickname}">
    <input type="hidden" id="post-detail" data-tp-idx="${post.tp_idx}">
    
    <!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />
    

    <!-- 여행기 상세보기 페이지 -->
    <div class="container">
        <div class="post-detail" id="post-detail" data-tp-idx="${post.tp_idx}">
            <!-- 여행기 제목 -->
            <h2>${post.title}</h2>

            <!-- 작성자 및 작성일 + 좋아요/댓글 수 -->
            <div class="post-header">
                <!-- 작성자 및 작성일 -->
                <div class="post-meta">
                    <span class="writer">by:${post.writer}</span>
                    <span class="date">
                        <fmt:formatDate value="${post.post_date}" pattern="yyyy.MM.dd. HH:mm" />
                    </span>
                </div>
            </div>

            <hr>

            <!-- 여행기 본문 내용 -->
            <div class="post-content">
                <p>${post.content}</p>
            </div>

            <!-- 첨부 이미지가 있는 경우 보여주기 -->
            <div class="post-images">
                <c:forEach var="media" items="${post.mediaList}">
                    <img src="${pageContext.request.contextPath}/resources/uploads/${media.save_filename}" alt="첨부 이미지" />
                </c:forEach>
            </div>

            <!-- 좋아요 버튼 섹션 -->
            <div class="like-section" style="text-align: center; margin-bottom: 20px;">
                <button id="likeButton" data-tp-idx="${post.tp_idx}" data-liked="${post.liked}" data-like-count="${likeCount}">
                    <i class="heart-icon"></i> <span class="like-count">(${likeCount})</span>
                </button>
            </div>
            
             <div class="post-tags">
                <c:if test="${not empty post.tags}">
                    <ul style="list-style: none; padding: 0;">
                        <c:forEach var="tag" items="${post.tags}">
                            <li style="display: inline-block; margin-right: 10px;">#${tag}</li>
                        </c:forEach>
                    </ul>
                </c:if>
            </div>
        </div>

        <!-- 댓글 입력 영역 -->
        <div class="comments-section">
            <h3>댓글</h3>
            <textarea id="comment-text" placeholder="댓글을 입력하세요"></textarea>
        </div>

        <!-- 버튼 그룹 및 댓글 작성 섹션을 한 줄로 배치 -->
        <div class="button-comment-group">
            <!-- 댓글 작성 버튼 -->
            <button id="submit-comment" class="comment-btn">댓글 작성</button>
            <div class="right-buttons">
                <!-- 목록으로 돌아가기 버튼 -->
                <a href="${pageContext.request.contextPath}/Community/travelPostList" class="btn-back">목록</a>
                <!-- 여행기 쓰기 버튼 -->
                <a href="${pageContext.request.contextPath}/Community/travelWrite" class="btn-write">여행기 쓰기</a>
            </div>
        </div>

       <!-- 댓글 리스트가 AJAX로 동적으로 추가될 영역 -->
<div class="comment-list" id="comment-list">
    <c:forEach var="comment" items="${commentList}">
        <div class="comment-item" data-comment-id="${comment.commentId}">
            <p class="comment-writer">${comment.commentWriter}</p>
            <p class="comment-content">${comment.commentContent}</p>
            <p class="comment-date">${comment.commentDate}</p>

            <!-- 수정 및 삭제 버튼 추가 (댓글 작성자에게만 표시) -->
          <c:if test="${member.m_idx == comment.commentWriterId}">
   				 <button class="edit-comment" data-comment-id="${comment.commentId}">수정</button>
    			 <button class="delete-comment" data-comment-id="${comment.commentId}">삭제</button>
		 	</c:if>
        </div> 
    </c:forEach>
</div>
       
    </div>
	<!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/resources/js/travelpostdetail.js"></script>
</body>
</html>
