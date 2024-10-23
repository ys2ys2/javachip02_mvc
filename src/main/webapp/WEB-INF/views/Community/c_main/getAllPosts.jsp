<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.human.web.repository.PostDAO,com.human.web.vo.PostVO" %>
<%@ page import="java.util.List" %>
<%
PostDAO postDAO = new PostDAO();
    List<PostVO> posts = postDAO.getAllPosts();

    for (PostVO post : posts) {
%>
    <div class="post" data-post-id="<%= post.getPostId() %>">
        <div class="post-user">
            <span class="username"><%= post.getUsername() %></span> · <span class="follow">팔로우</span>
        </div>
        <p><%= post.getContent() %></p>
        <div class="post-footer">
            <span>댓글 수: <%= post.getCommentCount() %></span>
            <span>좋아요 수: <%= post.getLikeCount() %></span>
        </div>
    </div>
<%
    }
%>
