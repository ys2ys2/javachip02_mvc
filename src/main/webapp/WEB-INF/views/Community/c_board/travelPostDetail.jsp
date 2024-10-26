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
    <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
    <div class="overlay"></div>

    <!-- contextPath를 담은 숨겨진 필드 추가 -->
    <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />

    <!-- Header -->
      <header>
    <div class="header-container">
      <div class="logo">
        <a href="${pageContext.request.contextPath}/HomePage/mainpage">BBOL BBOL BBOL</a>
      </div>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/HomePage/mainpage">홈</a></li>
          <li><a href="${pageContext.request.contextPath}/Community/c_main">커뮤니티</a></li>
          <li><a href="${pageContext.request.contextPath}/HotPlace/hotplace2">여행지</a></li>
          <li><a href="${pageCOntext.request.contextPath}/TravelSpot/TravelSpot">여행뽈뽈</a></li>
          <li><a href="${pageContext.request.contextPath}/TripSched/tripSched">여행일정</a></li>
        </ul>
      </nav>
      <div class="member">
        <c:choose>
          <c:when test="${not empty member}">
            <!-- 로그인 성공 시, 마이페이지와 로그아웃 표시 -->
            <div class="welcome">
            	<span class="userprofile"><img src="${member.m_profile}" alt="user-profile"></span>
            	${member.m_nickname}님 환영합니다!
            </div>
            <span><a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지</a></span>
            <form action="${pageContext.request.contextPath}/Member/logout" method="post" style="display:inline;">
              <button type="submit">로그아웃</button>
            </form>
          </c:when>
          <c:otherwise>
            <!-- 로그인 실패 시, 로그인과 회원가입 표시 -->
            <span><a href="${pageContext.request.contextPath}/Member/login">로그인</a></span>
            <span><a href="${pageContext.request.contextPath}/Member/joinmain">회원가입</a></span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>

    <!-- 여행기 상세보기 페이지 -->
    <div class="container">
        <div class="post-detail" id="post-detail" data-tp-idx="${post.tp_idx}">
            <!-- 여행기 제목 -->
            <h2>${post.title}</h2>

            <!-- 작성자 및 작성일 + 좋아요/댓글 수 -->
            <div class="post-header">
                <!-- 작성자 및 작성일 -->
                <div class="post-meta">
                    <span class="writer">by: ${post.writer}</span>
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
            <c:if test="${currentUser == comment.commentWriter}">
                <button class="edit-comment" data-comment-id="${comment.commentId}">수정</button>
                <button class="delete-comment" data-comment-id="${comment.commentId}">삭제</button>
            </c:if>
        </div>
    </c:forEach>
</div>
       
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/travelpostdetail.js"></script>
</body>
</html>
