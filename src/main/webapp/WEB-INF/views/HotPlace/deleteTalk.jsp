<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.human.web.repository.TalkDAO" %>

<%
    String talkIdxStr = request.getParameter("talkIdx");
    
    if (talkIdxStr != null) {
        try {
            int talkIdx = Integer.parseInt(talkIdxStr); // `talkIdx`를 정수형으로 변환

            TalkDAO talkDAO = new TalkDAO(); // TalkDAO 객체 생성
            int result = talkDAO.deleteTalk(talkIdx); // 댓글 삭제 실행
            
            if (result == 1) {
                out.print("댓글이 삭제되었습니다.");
            } else {
                out.print("댓글 삭제에 실패하였습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("댓글 삭제 중 오류가 발생하였습니다.");
        }
    } else {
        out.print("잘못된 요청입니다.");
    }
%>
