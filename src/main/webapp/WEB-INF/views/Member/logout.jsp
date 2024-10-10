<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 현재 세션을 완전히 무효화하여 모든 세션 데이터를 삭제
    if (session != null) {
        session.invalidate();
    }
%>


<!-- 로그아웃 후 메인 페이지로 리다이렉트 -->
<c:redirect url="/HomePage/mainpage" />