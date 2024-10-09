<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<!-- 액션태그를 이용해서 기존의 소스코드 변경하기 -->
<jsp:useBean id="vo" class="com.human.web.vo.M_MemberVO" scope="page"/>
<jsp:setProperty name="dto" property="*" />
<jsp:useBean id="dao" class="com.human.web.repository.M_MemberDAO" scope="page"/>

<!-- dao를 이용해서 dto를 입력하고 결과값을 result 변수에 저장하기 -->
<c:set var="result" value="${dao.updateM_Member(dto)}" />

<c:choose>
	<c:when test="${result eq 1}"><!-- 회원정보 변경이 정상적으로 이루어진 경우 -->
		<c:redirect url="/index.jsp" context="${pageContext.request.contextPath}" />
	</c:when>
	<c:otherwise>
		<!-- 회원정보 변경이 실패한 경우 : forward 액션태그 다음에 주석 처리를 할 경우 param 액션태그를 제대로 인식하지 못함 -->
		<jsp:forward page="update.jsp">
			<jsp:param name="msg" value="회원정보 변경이 정상적으로 이루어지지 않았습니다." />
		</jsp:forward>	
	</c:otherwise>
</c:choose>

