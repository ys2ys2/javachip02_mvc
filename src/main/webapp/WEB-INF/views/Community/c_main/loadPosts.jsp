<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.human.web.repository.PostDAO, com.human.web.vo.PostVO" %>
<%@ page import="java.util.List" %>

<%
// DAO 객체 생성 및 게시글 목록 불러오기
    PostDAO postDAO = new PostDAO();
    List<PostVO> postList = postDAO.getAllPosts();

    // postList를 request 객체에 바인딩하여 JSP에서 사용할 수 있도록 설정
    request.setAttribute("postList", postList);
%>

<!-- 게시글 목록을 출력 -->
<div id="postList">
    <c:forEach var="post" items="${postList}">
        <div class="post" data-post-id="${post.postId}">
            <div class="post-user">
                <span class="username">${post.username}</span> · <span class="follow">팔로우</span>
            </div>
            <p class="post-content">${post.content}</p>
            <div class="post-footer">
                <span>댓글 수: ${post.commentCount}</span>
                <span>좋아요 수: ${post.likeCount}</span>
            </div>
        </div>
    </c:forEach>
</div>
