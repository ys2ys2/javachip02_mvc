<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ page import="dto.TalkDTO" %>
<%@ page import="dao.TalkDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%
	request.setCharacterEncoding("UTF-8");

    // 댓글 내용 가져오기
    String talkText = request.getParameter("talkText"); // talkText로 수정
    String talkNickname = (String) session.getAttribute("memberNickname"); // 세션에서 닉네임 가져오기
    String talkEmail = (String) session.getAttribute("memberEmail"); // 세션에서 이메일 가져오기


    // TalkDTO 객체 생성
    TalkDTO talk = new TalkDTO();
    talk.setTalkNickname(talkNickname);  // 세션에서 가져온 닉네임
    talk.setTalkEmail(talkEmail);        // 세션에서 가져온 이메일
    talk.setTalkText(talkText);          // 입력된 댓글 내용

    // TalkDAO 객체 생성 및 댓글 저장
    TalkDAO talkDAO = new TalkDAO();
    int result = talkDAO.insertTalk(talk);

    if (result > 0) {
        out.print("success");
    } else {
        out.print("failure");
    }
%>
