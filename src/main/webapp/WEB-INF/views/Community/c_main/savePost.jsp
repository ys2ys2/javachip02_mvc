<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.human.notice.repository.PostDAO,com.human.notice.vo.PostVO" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<%
// JSP 페이지에서 Multipart 데이터를 처리할 수 있도록 설정
    request.setCharacterEncoding("UTF-8");
    
    // 게시글 내용을 읽어오는 코드 수정 (Multipart 처리)
    Part contentPart = request.getPart("content");  // Multipart로 content 데이터를 가져옴

    // content가 제대로 읽혔는지 확인
    String content = null;
    if (contentPart != null) {
        content = new String(contentPart.getInputStream().readAllBytes(), "UTF-8");
    }

    String username = "test_user";  // 사용자 이름 (테스트용)

    // 디버깅: 전달된 값이 null인지 확인
    System.out.println("전달된 게시글 내용: " + content);

    // 만약 content 값이 null이거나 빈 값이라면 에러 메시지 출력 후 종료
    if (content == null || content.trim().equals("")) {
        response.getWriter().write("게시글 내용이 비어 있습니다.");
        return;
    }

    // PostDAO 객체 생성 및 데이터베이스에 게시글 저장
    PostDAO postDAO = new PostDAO();
    PostVO post = new PostVO();  // 기본 생성자로 객체 생성
    post.setUsername(username);  // 사용자 이름 설정
    post.setContent(content);    // 게시글 내용 설정

    postDAO.savePost(post);  // DAO를 통해 데이터베이스에 저장
    // 저장이 완료되었다는 메시지 출력
    response.getWriter().write("게시글이 성공적으로 저장되었습니다.");
%>
