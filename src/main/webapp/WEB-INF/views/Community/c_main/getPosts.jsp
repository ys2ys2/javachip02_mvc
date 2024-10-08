<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.PostDAO" %>
<%@ page import="dto.PostDTO" %>

<%
PostDAO dao = new PostDAO(); 
    List<PostVO> posts = dao.getAllPosts(); // List 타입 변수 사용

    for (PostVO post : posts) {
%>
    <div class="post">
        <p>게시글 ID: <%= post.getPostId() %></p>
        <p><%= post.getContent() %></p>
        <p>작성 시간: <%= post.getCreatedAt() %></p>
    </div>
<%
    }
%>
