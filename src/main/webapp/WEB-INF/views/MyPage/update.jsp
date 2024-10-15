<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 변경</title>
</head>
<body>

<!-- useBean 액션태그를 이용해서 DAO객체 생성하기 -->
<jsp:useBean id="dao" class="com.human.web.repository.M_MemberDAO" />
<!-- DAO의 getMember()메소드를 이용해서 DTO를 반환받고 이것을 dto로 page영역에 저장하기 -->
<c:set var="dto" value="${dao.getM_Member(member)}" />

<h1>회원정보 변경</h1>
    <form method="post" action="updateProcess.jsp">
        <input type="text" name="m_nickname" value="${dto.m_nickname}"><br>
        <input type="text" name="m_email" value="${dto.m_email}" readonly><br>
        <input type="submit" value="변경하기">
        <input type="button" value="취소하기" onclick="location.href='../index.jsp'">
    </form>
    <br>
    <p>
    	<a href="javascript:cancel()">회원 탈퇴</a>
    </p>
    
    
	<!-- 회원정보 변경 실패 시 오류 메시지 출력 -->
	<c:if test="${not empty param.msg}">
		<p> ${param.msg} </p>
	</c:if>

	<script>
		function cancel(){
			const answer = confirm("정말 회원탈퇴 하겠습니까?");
			if(answer){
				location.href = "cancelProcess.jsp";
			}
		}
	
	</script>



</body>
</html>