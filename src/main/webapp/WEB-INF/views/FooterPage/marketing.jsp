<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>

	<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
  	<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
  	<link href="${pageContext.request.contextPath}/resources/css/clause.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<title>광고성 정보 수신동의</title>
</head>
<body>

  <header>
    <div class="header-container">
      <div class="logo">
        <a href="${pageContext.request.contextPath}/HomePage/mainpage">BBOL BBOL BBOL</a>
      </div>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/HomePage/mainpage">홈</a></li>
          <li><a href="#">커뮤니티</a></li>
          <li><a href="${pageContext.request.contextPath}/HotPlace/hotplace2">여행지</a></li>
          <li><a href="#">여행뽈뽈</a></li>
        </ul>
      </nav>
      <div class="member">
        <c:choose>
          <c:when test="${not empty sessionScope.member}">
            <!-- 로그인 성공 시, 마이페이지와 로그아웃 표시 -->
            <div class="welcome">${sessionScope.member.m_nickname}님 환영합니다!</div>
            <span><a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지</a></span>
            <form action="${pageContext.request.contextPath}/Member/logout" method="post" style="display:inline;">
              <button type="submit">로그아웃</button>
            </form>
          </c:when>
          <c:otherwise>
            <!-- 로그인 실패 시, 로그인과 회원가입 표시 -->
            <span><a href="${pageContext.request.contextPath}/Member/login">로그인</a></span>
            <span><a href="${pageContext.request.contextPath}/Member/join">회원가입</a></span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>
  
  
  <div class="clause">
  
  	<div class="introimg"
		style="background-image:url('${pageContext.request.contextPath}/resources/images/clausemain.jpg');">
		<h2>뽈뽈뽈 약관</h2>
		<h1>광고성 정보 수신동의</h1>
	</div>
	
	<!-- 네비바 부분 -->
    <div class="c_section-container">
      <ul class="c_navbar">
        <li class="c_nav-item"><a href="${pageContext.request.contextPath}/FooterPage/clause" >이용약관</a></li>
        <li class="c_nav-item"><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank" >개인정보 수집 및 이용 동의</a></li>
        <li class="c_nav-item"><a href="${pageContext.request.contextPath}/FooterPage/thirdparty" target="_blank">개인정보 제3자 제공 동의</a></li>
        <li class="c_nav-item"><a href="${pageContext.request.contextPath}/FooterPage/marketing">광고성 정보 수신동의</a></li>
      </ul>
  	</div>
  
  <div class="marketing_text">
  광고성 정보 수신동의
  <br><br>
  ㈜뽈뽈뽈은 개인정보보호법 및 정보통신망 이용촉진 및 정보보호 등에 관한법률 등 관계법령에 따라 광고성 정보를 전송하기 위해 수신자의 사전 수신동의를 받고 있으며, 광고성 정보 수신자의 수신동의여부를 정기적으로 확인합니다.
  <br><br>
  1. 전송방법<br>
  회원의 모바일 APP Push, 휴대폰 문자메세지(SMS), 카카오톡, E-mail 등을 통해 전달될 수 있습니다.<br><br>
  2. 전송내용<br>
  발송되는 마케팅 정보는 수신자에게 ㈜뽈뽈뽈과 관련하여 제공하는 혜택(포인트, 쿠폰 등) 정보, 각종 이벤트 정보 등 광고성 정보로 관련 법의 규정을 준수하여 발송됩니다. 단, 광고성 정보 이외 의무적으로 안내되어야 하는 정보성 내용은 수신동의 여부와 무관하게 제공됩니다.
  <br><br>
  3. 동의거부권<br>
  본 수신동의는 거부할 수 있으며 수신을 동의하지 않아도 회사가 제공하는 기본적인 서비스를 이용할 수 있습니다.<br><br>
  4. 철회안내<br>
  회원은 수신 동의 이후라도 의사에 따라 동의를 철회할 수 있으며, 수신을 동의하지 않아도 회사가 제공하는 기본적인 서비스를 이용할 수 있으나, 당사의 마케팅 정보를 수신하지 못할 수 있습니다.<br><br>
  5. 수신동의 변경<br>
  뽈뽈뽈 고객센터 또는 마이페이지를 통해 수신동의를 변경(동의/철회) 할 수 있습니다.<br><br>
  6. 개인정보 이용 상세내용<br>
  이용하는 개인정보 항목	보유 이용 목적<br>
  휴대전화번호, 이메일 주소	혜택 정보, 각종 이벤트 정보 등 광고성 정보 제공<br><br>
  7. 개인정보 보유 및 이용 기간<br>
  광고성 정보 수신 동의일로부터 회원 탈퇴 또는 광고성 정보 수신 동의 철회 시까지 보유 및 이용<br><br>
  
  
  </div>
 
  
  
  </div>
  

<!-- 푸터 부분 -->
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h4>회사소개</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/introduce" target="_blank">회사소개</a></li>
        <li><a href="${pageContext.request.contextPath}/HotPlace/inputApi"target="_blank">공공데이터 API</a></li>
        <li><a href="#">채용공고</a></li>
      </ul>
    </div>

    <!-- 고객지원 -->
    <div class="footer-section">
      <h4>고객지원</h4>
      <ul>
        <li><a href="#">공지사항</a></li>
        <li><a href="#">자주묻는 질문</a></li>
        <li><a href="#">문의하기</a></li>
      </ul>
    </div>

    <!-- 이용약관 -->
    <div class="footer-section">
      <h4>이용약관</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/FooterPage/clause" target="_blank">이용약관</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/privacy" target="_blank">개인정보처리방침</a></li>
        <li><a href="${pageContext.request.contextPath}/FooterPage/marketing">광고성 정보 수신동의</a></li>
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