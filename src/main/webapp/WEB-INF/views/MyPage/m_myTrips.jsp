<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/m_myTrips.css"> 
<title>마이페이지 메인</title>
</head>
<body>
  <!-- 어두운 배경 -->
  <div class="overlay"></div>
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
            <span><a href="${pageContext.request.contextPath}/Member/joinmain">회원가입</a></span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>
  <div class="navigation">
   	<a href="${pageContext.request.contextPath}/MyPage/myPageMain">마이페이지 홈</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myTrips">내 여행</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_myJourneys">내 게시글</a>
     <a href="${pageContext.request.contextPath}/MyPage/m_savedList">저장목록</a>
   	
</div>

<div class="container">

    <!-- 왼쪽 프로필 영역 -->
       <div class="profile-section">
    <h4>My BBOL BBOL BBOL</h4>
        <div class="profile-card">
               <img src="${pageContext.request.contextPath}${member.m_profile}" alt="프로필 사진" class="profile-image">
        
        <h3>${member.m_nickname}</h3>
         
<a href="${pageContext.request.contextPath}/Member/m_updateProfile">
    <button>프로필 편집</button>
</a>

   <!-- 오른쪽 콘텐츠 영역 (내 여행) -->
<div class="content-section">
  
    <!-- 다가오는 여행 섹션 -->
    <div class="section">
        <div class="section-header">
            <h3>다가오는 여행</h3>
        </div>
        <div class="section-content">
            <c:choose>
                <c:when test="${not empty upcomingTrips}">
                    <table>
                        <thead>
                            <tr>
                                <th>여행 시작 날짜</th>
                                <th>여행 끝 날짜</th>
                                <th>여행기 제목</th>
                                <th>도시 이름</th>
                                <th>여행 장소</th>
                                <th>주소</th>
                            </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="trip" items="${upcomingTrips}">
    <!-- 배열에서 데이터를 순환하여 표시 -->
    <tr>
        <td><fmt:formatDate value="${trip.period_start}" pattern="yyyy-MM-dd" /></td>
        <td><fmt:formatDate value="${trip.period_end}" pattern="yyyy-MM-dd" /></td>
        <td>${trip.t_title}</td>
        <td>${trip.city_name}</td>
        <td>${trip.place_name}</td>
        <td>${trip.place_address}</td>
    </tr>
</c:forEach>

                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>다가오는 여행 일정이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 지난 여행 섹션 -->
    <div class="section">
        <div class="section-header">
            <h3>지난 여행</h3>
        </div>
        <div class="section-content">
            <c:choose>
                <c:when test="${not empty pastTrips}">
                    <table>
                        <thead>
                            <tr>
                                <th>여행 시작 날짜</th>
                                <th>여행 끝 날짜</th>
                                <th>여행기 제목</th>
                                <th>도시 이름</th>
                                <th>여행 장소</th>
                                <th>주소</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="trip" items="${pastTrips}">
    <!-- 배열에서 데이터를 순환하여 표시 -->
    <tr>
        <td><fmt:formatDate value="${trip.period_start}" pattern="yyyy-MM-dd" /></td>
        <td><fmt:formatDate value="${trip.period_end}" pattern="yyyy-MM-dd" /></td>
        <td>${trip.t_title}</td>
        <td>${trip.city_name}</td>
        <td>${trip.place_name}</td>
        <td>${trip.place_address}</td>
    </tr>
</c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>지난 여행 기록이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

</body>
</html>