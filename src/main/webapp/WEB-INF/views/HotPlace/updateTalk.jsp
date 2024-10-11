<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.human.web.repository.TalkDAO" %>


<%
    String talkIdxStr = request.getParameter("talkIdx");
    String updatedText = request.getParameter("updatedText");

    if (talkIdxStr != null && updatedText != null) {
        try {
            int talkIdx = Integer.parseInt(talkIdxStr);
            TalkDAO talkDAO = new TalkDAO();
            int result = talkDAO.updateTalk(talkIdx, updatedText);
            
            if (result == 1) {
            } else {
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
 --%>