<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ page import="java.io.PrintWriter,com.human.web.vo.M_MemberVO,com.human.web.repository.M_MemberDAO" %>

<!-- useBean 액션태그를 이용해서 MemberDAO 객체 생성하기 -->
<jsp:useBean id="dao" class="com.human.web.repository.M_MemberDAO" />

<!-- DAO의 cancel()메소드를 실행시키고 결과값을 result 변수에 저장하기 -->
<c:set var="result" value="${dao.cancel(member)}" />

<!-- 요청 처리 성공시 세션에 저장된 member를 삭제하고 메인페이지로 재요청함 -->
<c:choose>
	<c:when test="${result eq 1}">
		<c:remove var="member" scope="session" />
		<c:redirect url="/index.jsp" context="${pageContext.request.contextPath}" />
	</c:when>
	<c:otherwise>
		<jsp:forward page="update.jsp">
			<jsp:param name="msg" value="시스템 오류가 발생했습니다. 빠른 시일 내에 시스템을 정상화하도록 하겠습니다" />
		</jsp:forward>	
	</c:otherwise>
</c:choose>


