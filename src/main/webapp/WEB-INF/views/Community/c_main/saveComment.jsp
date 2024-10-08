<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.CommentDAO, dto.CommentDTO" %>
<%
// 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 파라미터 값 읽기
    String postIdStr = request.getParameter("postId");
    String content = request.getParameter("content");
    String username = "test_user";  // 현재 사용자는 test_user로 설정 (테스트용)

    // 디버깅 로그 출력
    System.out.println("전달된 postId: " + postIdStr);
    System.out.println("전달된 댓글 내용: " + content);

    // 파라미터 유효성 검사
    if (postIdStr == null || content == null || content.trim().equals("")) {
        response.getWriter().write("댓글 내용이 비어 있거나 잘못된 요청입니다.");
        return;
    }

    // postId를 Integer로 변환
    int postId = Integer.parseInt(postIdStr);

    // 댓글 DTO 생성 및 데이터 설정
    CommentVO comment = new CommentVO();
    comment.setPostId(postId);
    comment.setUsername(username);
    comment.setContent(content);

    // CommentDAO 객체 생성 및 데이터베이스에 댓글 저장
    CommentDAO commentDAO = new CommentDAO();
    commentDAO.saveComment(comment);

    // 저장이 완료되었다는 메시지 출력
    response.getWriter().write("댓글이 성공적으로 저장되었습니다.");
%>
