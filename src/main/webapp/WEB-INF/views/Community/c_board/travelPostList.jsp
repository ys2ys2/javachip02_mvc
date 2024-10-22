<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행기 목록</title>
    <link href="${pageContext.request.contextPath}/resources/css/list.css" rel="stylesheet">
</head>
<body>

<h3>여행기 게시글 목록</h3>


<!-- taggedPosts 데이터가 제대로 들어왔는지 확인 -->
<c:if test="${not empty taggedPosts}">
    <c:out value="${taggedPosts}" />
</c:if>
<c:if test="${empty taggedPosts}">
    <p>태그별 게시물이 없습니다.</p>
</c:if>

<!-- 지역 태그별로 나눠서 게시글 출력 -->
<div class="tag-section">
    <h4>#서울</h4>
    <div class="post-list">
        <c:forEach var="post" items="${taggedPosts['서울']}">
            <div class="post-item">
                <a href="${pageContext.request.contextPath}/Community/travelPostDetail?tp_idx=${post.tp_idx}">
                    <c:if test="${not empty post.mediaList}">
                        <img src="${pageContext.request.contextPath}/resources/uploads/thumbnail-${post.mediaList[0].save_filename}" alt="게시물 이미지">
                    </c:if>
                    <p>${post.title}</p>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<div class="tag-section">
    <h4>#부산</h4>
    <div class="post-list">
        <c:forEach var="post" items="${taggedPosts['부산']}">
            <div class="post-item">
                <a href="${pageContext.request.contextPath}/Community/travelPostDetail?tp_idx=${post.tp_idx}">
                    <c:if test="${not empty post.mediaList}">
                        <img src="${pageContext.request.contextPath}/resources/uploads/thumbnail-${post.mediaList[0].save_filename}" alt="게시물 이미지">
                    </c:if>
                    <p>${post.title}</p>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<div class="tag-section">
    <h4>#제주</h4>
    <div class="post-list">
        <c:forEach var="post" items="${taggedPosts['제주']}">
            <div class="post-item">
                <a href="${pageContext.request.contextPath}/Community/travelPostDetail?tp_idx=${post.tp_idx}">
                    <c:if test="${not empty post.mediaList}">
                        <img src="${pageContext.request.contextPath}/resources/uploads/thumbnail-${post.mediaList[0].save_filename}" alt="게시물 이미지">
                    </c:if>
                    <p>${post.title}</p>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<div class="tag-section">
    <h4>#인천</h4>
    <div class="post-list">
        <c:forEach var="post" items="${taggedPosts['인천']}">
            <div class="post-item">
                <a href="${pageContext.request.contextPath}/Community/travelPostDetail?tp_idx=${post.tp_idx}">
                    <c:if test="${not empty post.mediaList}">
                        <img src="${pageContext.request.contextPath}/resources/uploads/thumbnail-${post.mediaList[0].save_filename}" alt="게시물 이미지">
                    </c:if>
                    <p>${post.title}</p>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 추가 태그 섹션을 원할 경우 여기에 더 추가하세요 -->

</body>
</html>
