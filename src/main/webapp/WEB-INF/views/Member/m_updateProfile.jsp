<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 변경</title>
</head>
<body>

<h1>회원정보 변경</h1>

<!-- enctype을 추가하여 파일 업로드 가능하도록 설정 enctype="multipart/form-data"-->
<form method="post" action="updateProcess" >

<%--     <!-- 프로필 이미지 표시 및 변경 -->
    <div class="profile-image-section">
        <img src="${member.m_profile}" alt="프로필 사진" class="profile-image" style="width:150px;height:150px;border-radius:50%;"><br>
        <label for="m_profileImage">프로필 이미지 변경:</label>
        <input type="file" id="m_profile" name="m_profile"><br>
    </div>
 --%>
    <!-- 회원 식별 정보 -->
    <input type="hidden" name="m_idx" value="${member.m_idx}">
    
    <!-- 이메일 (읽기 전용) -->
    <label for="m_email">이메일:</label>
    <input type="text" id="m_email" name="m_email" value="${member.m_email}" readonly><br>
    
    <!-- 비밀번호 -->
    <label for="m_password">비밀번호:</label>
    <input type="password" id="m_password" name="m_password" value="${member.m_password}"><br>
    
    <!-- 닉네임 -->
    <label for="m_nickname">닉네임:</label>
    <input type="text" id="m_nickname" name="m_nickname" value="${member.m_nickname}"><br>
    <!-- 중복된 닉네임 메시지를 표시 -->
    <c:if test="${not empty msg}">
        <p style="color:red;">${msg}</p> <!-- 오류 메시지 빨간색으로 표시 -->
    </c:if>
    <!-- 제출 버튼 -->
    <input type="submit" value="변경하기">
    
    <!-- 취소 버튼 -->
    <input type="button" value="취소하기" onclick="location.href='../index.do'">
</form>
<br>

<!-- 회원 탈퇴 -->
<p>
    <a href="javascript:cancel()">회원 탈퇴</a>
</p>

<!-- 회원정보 변경 실패 시 오류 메시지 출력 -->
<c:if test="${not empty msg}">
    <p> ${msg} </p>
</c:if>

<script>
    // 회원 탈퇴 확인
    function cancel(){
        const answer = confirm("정말 회원탈퇴 하겠습니까?");
        if(answer){
            location.href = "cancelProcess.do";
        }
    }
</script>

</body>
</html>
