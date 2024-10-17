<%@ page import="com.human.notice.vo.TravelPostVO,com.human.notice.repository.TravelPostDAO,com.human.notice.vo.MediaVO,com.human.notice.repository.MediaDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> <!-- JSP 파일에서 EL(Expression Language)을 사용하지 않도록 설정 -->
<%@ page import="java.io.File" %>


<%
try {
    	String topic = request.getParameter("topic");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String tags = request.getParameter("tags");
        
        // 파라미터 확인
        System.out.println("Topic: " + topic);   // Topic 값이 null인지 확인
        System.out.println("Title: " + title);
        System.out.println("Content: " + content);
        System.out.println("Tags: " + tags);
        
        if (topic == null || topic.isEmpty()) {
            out.println("<script>alert('토픽을 선택해주세요.'); history.back();</script>");
            return;
        }

        // 이미지 파일 처리
        String fileName = "";
        javax.servlet.http.Part filePart = request.getPart("imageUpload");  // 파일 파트를 가져오기
        if (filePart != null) {
            fileName = filePart.getSubmittedFileName();
        }
        String filePath = "uploads/" + fileName;

        // 여행기 저장
        TravelPostVO travelPost = new TravelPostVO();
        travelPost.setTopic(topic);
        travelPost.setTitle(title);
        travelPost.setContent(content);
        travelPost.setTags(tags);

        TravelPostDAO travelPostDAO = new TravelPostDAO();
        int postId = travelPostDAO.savePost(travelPost);

        // 이미지 정보 저장
        if (postId > 0 && fileName != null && !fileName.isEmpty()) {
            MediaVO media = new MediaVO();
            media.setPostId(postId);
            media.setFileName(fileName);
            media.setFilePath(filePath);

            MediaDAO mediaDAO = new MediaDAO();
            mediaDAO.saveMedia(media);

            // 업로드한 파일 저장 경로 설정 및 파일 저장
            String uploadDir = application.getRealPath("/") + "uploads/";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdir();
            }
            filePart.write(uploadDir + fileName);  // 파일을 서버에 저장
        }

        // 저장 후 커뮤니티 메인 페이지로 리디렉션
        response.sendRedirect("../c_main/c_main.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('업로드 중 오류가 발생했습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>
