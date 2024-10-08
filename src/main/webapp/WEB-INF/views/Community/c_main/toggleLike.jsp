<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.LikeDAO, dao.PostDAO, dto.LikeDTO" %>

<%
request.setCharacterEncoding("UTF-8");

    // 파라미터로 전달된 postId와 username 읽기
    String postIdStr = request.getParameter("postId");
    String username = "test_user";  // 현재 사용자는 test_user로 가정 (테스트용)

    int postId = Integer.parseInt(postIdStr);

    LikeDAO likeDAO = new LikeDAO();
    PostDAO postDAO = new PostDAO();

    // 현재 사용자가 해당 게시글에 좋아요를 눌렀는지 확인
    boolean isLiked = likeDAO.checkIfUserLiked(postId, username);

    int updatedLikeCount;

    if (isLiked) {
        likeDAO.removeLike(postId, username);
        postDAO.updateLikeCount(postId, -1);  // 좋아요 수 감소
        updatedLikeCount = postDAO.getPostById(postId).getLikeCount();
        response.getWriter().write("좋아요가 취소되었습니다. 현재 좋아요 수: " + updatedLikeCount);
    } else {
        LikeVO like = new LikeVO();
        like.setPostId(postId);
        like.setUsername(username);
        likeDAO.saveLike(like);
        postDAO.updateLikeCount(postId, 1);  // 좋아요 수 증가
        updatedLikeCount = postDAO.getPostById(postId).getLikeCount();
        response.getWriter().write("좋아요가 추가되었습니다. 현재 좋아요 수: " + updatedLikeCount);
    }
%>
