<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">

<title>footer</title>
</head>

<body>
<!-- 푸터 부분 -->
<footer>

<div class="footer-container">
  <div class="footer-section">
    <h4>회사소개</h4>
    <ul>
      <li><a href="${pageContext.request.contextPath}/FooterPage/introduce" target="_blank">'뽈뽈뽈' 회사소개</a></li>

      
    </ul>
  </div>

<!-- 고객지원 -->
  <div class="footer-section">
    <h4>고객지원</h4>
    <ul>
      <!-- <li><a href="#">공지사항</a></li> -->
      <li><a href="${pageContext.request.contextPath}/HomePage/FAQ" target="_blank">자주묻는 질문</a></li>
      <li><a href="${pageContext.request.contextPath}/Matzip/MatzipApi"target="_blank">맛집 공공데이터 API</a></li>
      <li><a href="${pageContext.request.contextPath}/HotPlace/inputApi"target="_blank">여행지 공공데이터 API</a></li>
      <!-- <li><a href="#">문의하기</a></li> -->
    </ul>
  </div>

  <!-- 이용약관 -->
  <div class="footer-section">
    <h4>이용약관</h4>
    <ul>
      <li><a href="${pageContext.request.contextPath}/FooterPage/clause" target="_blank">이용약관</a></li>
      <li><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank">개인정보처리방침</a></li>
      <li><a href="${pageContext.request.contextPath}/FooterPage/marketing" target="_blank">광고성 정보 수신동의</a></li>
    </ul>
  </div>

  <!-- 회사 정보 -->
  <div class="footer-company-info">
    <p>상호: (주)BBOL | 대표: 박예슬 | 사업자등록번호: 123-45-67890 | 통신판매업 신고번호: 2024-충남천안-00000 | 개인정보관리 책임자: 수수옥</p>
    <p>주소: 충청남도 천안시 동남구 123 | 이메일: support@BBOL3.com | 대표전화: 02-1234-5678</p>
    <p>© 2024 BBOLBBOLBBOL. All Rights Reserved.</p>
  </div>

  <!-- 소셜 미디어 -->
  <div class="footer-social">
    <a href="#"><i class="fab fa-instagram"></i></a>
    <a href="#"><i class="fab fa-facebook-f"></i></a>
    <a href="#"><i class="fab fa-twitter"></i></a>
  </div>
</div>
  
</footer>

</body>
</html>