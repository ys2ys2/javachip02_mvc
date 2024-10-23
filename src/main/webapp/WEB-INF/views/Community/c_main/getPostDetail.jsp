<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.human.web.repository.PostDAO,com.human.web.vo.PostVO" %>
<%
String postId = request.getParameter("postId");
    PostDAO postDAO = new PostDAO();
    PostVO post = postDAO.getPostById(Integer.parseInt(postId));

    if (post != null) {
%>
    <h3>작성자: <%= post.getUsername() %></h3>
    <p><%= post.getContent() %></p>
    <p>작성 시간: <%= post.getCreatedAt() %></p>
    <p>좋아요 수: <%= post.getLikeCount() %></p>
    <p>댓글 수: <%= post.getCommentCount() %></p>
<%
    } else {
        out.print("게시글을 찾을 수 없습니다.");
    }
%>
