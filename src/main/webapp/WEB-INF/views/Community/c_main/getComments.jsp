<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.CommentDAO, dto.CommentDTO" %>
<%@ page import="java.util.List" %>
<%
int postId = Integer.parseInt(request.getParameter("postId"));
    CommentDAO commentDAO = new CommentDAO();
    List<CommentVO> comments = commentDAO.getCommentsByPostId(postId);

    for (CommentVO comment : comments) {
%>
    <div class="comment">
        <span><%= comment.getUsername() %></span> : <%= comment.getContent() %> (<%= comment.getCreatedAt() %>)
    </div>
<%
    }
%>