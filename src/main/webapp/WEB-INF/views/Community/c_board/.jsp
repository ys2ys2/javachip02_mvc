<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.TravelPostDAO, dto.TravelPostDTO" %>
<%
// JSP 페이지에서 topic 파라미터 값 확인
    String topic = request.getParameter("topic");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String tags = request.getParameter("tags");
    String imagePath = "";

    // 디버그용으로 값을 출력하여 확인합니다.
    System.out.println("Topic: " + topic);  // null 값인지 확인
    System.out.println("Title: " + title);
    System.out.println("Content: " + content);
    System.out.println("Tags: " + tags);

    // topic이 null인지 체크
    if (topic == null || topic.trim().equals("")) {
        out.println("<h3>토픽 값이 null이거나 비어 있습니다. 폼을 정확히 작성해 주세요.</h3>");
        return;
    }

    Part imagePart = request.getPart("imageUpload");
    if (imagePart != null && imagePart.getSize() > 0) {
        imagePath = imagePart.getSubmittedFileName();
        String uploadPath = application.getRealPath("/") + "uploadedImages/";
        imagePart.write(uploadPath + imagePath);
    }

    // DTO 객체 생성 및 데이터 설정
    TravelPostVO post = new TravelPostVO();
    post.setTopic(topic);  // topic 값이 null이면 여기서 문제가 발생합니다.
    post.setTitle(title);
    post.setContent(content);
    post.setTags(tags);
    post.setImagePath(imagePath);

    // DAO 객체 사용하여 데이터베이스에 삽입
    TravelPostDAO dao = new TravelPostDAO();
    boolean isInserted = dao.insertTravelPost(post);

    if (isInserted) {
        response.sendRedirect("c_main.jsp"); // 성공 시 메인 페이지로 이동
    } else {
        out.println("<h3>여행기 저장에 실패했습니다. 다시 시도해 주세요.</h3>");
    }
%>
