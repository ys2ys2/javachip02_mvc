<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPageMain.css"> 
<title>마이페이지 메인</title>
</head>
<body>
 <div class="overlay"></div>

  <header>
    <div class="header-container">
      <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
      <nav>
        <ul>
          <li><a href="#" data-ko="홈" data-en="Home">홈홈</a></li>
          <li><a href="#" data-ko="커뮤니티" data-en="Community">커뮤니티</a></li>
          <li><a href="#" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
          <li><a href="#" data-ko="여행뽈뽈" data-en="BBOL BBOL BBOL">여행뽈뽈</a></li>
          <button class="search-btn">
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
          <button class="user-btn">
            <i class="fa-solid fa-user"></i>
          </button>
          <button class="earth-btn">
            <i class="fa-solid fa-earth-americas"></i>
          </button>
          <button class="korean" id="lang-btn" data-lang="ko">English</button>
        </ul>
      </nav>
    </div>
  </header>
  <!-- 상단 네비게이션 -->
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

    <!-- 오른쪽 콘텐츠 영역 -->
    <div class="content-section">

        <!-- 다가오는 여행과 내 여행기 (두 개가 나란히 위치) -->
        <div class="top-content">
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
            <!-- 내 여행기 -->
            <div id="my-journeys" class="my-journeys">
                <h2>내 게시글</h2>
                <button class="black-button">글쓰기</button>
                <div class="content-box">
                 <div class="saved-post-list">
            <c:if test="${not empty savedPostList}">
                <c:forEach var="post" items="${savedPostList}" begin="0" end="1"> <!-- 게시글 2개만 출력 -->
                    <div class="post-item">
                        <!-- 게시글 상단: 작성자와 작성 날짜 -->
                        <div class="post-header">
                            <div class="post-writer">${post.postWriter}</div>
                            <div class="post-date">${post.postDate}</div>
                        </div>
                        
                        <!-- 게시글 내용 -->
                        <div class="post-content">
                            ${post.postContent}
                        </div>
                        
                        <!-- 게시글 하단: 좋아요 수와 댓글 수 -->
                        <div class="post-footer">
                            <span><i class="fa fa-heart"></i> ${post.likeCount}</span>
                            <span><i class="fa fa-comment"></i> ${post.commentCount}</span>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
                
                </div>
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

	<div class="m_content-section-header">
            <!-- 나의 저장목록 -->
          <c:if test="${not empty savedList}">
          <div class="m_saved-list">
          	<c:forEach var="item" items="${savedList}">
          	<div class="m_saved-item">
			<img src="${item.firstimage}" alt="${item.title}" class="m_saved-image">   	
          	<div class="m_saved-info">
          		 <h4>${item.title}</h4>
                    <p>❤ ${item.likes}</p>
                    <p>${item.addr1}</p>
          	</div>
          	</div>
          	<hr>         	
          	</c:forEach>
          </div>
          </c:if>
          </div>
          
      	<!-- 추천 핫플레이스 섹션 -->
			<div class="m_hotplaces">
		    <h2>BBOL BBOL BBOL 추천 핫플레이스</h2>
		
		    <!-- 콘텐츠를 보여줄 content-box -->
		    <div class="m_content-box">
		        <!-- c:forEach를 사용하여 m_mypageList를 반복 처리 -->
		        <c:forEach var="hotplace" items="${hotplaceList}">
		            <div class="m_hotplace-item">
		                <!-- 이미지 출력 (firstimage) -->
		                <img src="${hotplace.firstimage}" alt="${hotplace.title}">
		
		                <!-- 제목 출력 (title) -->
		                <h3>${hotplace.title}</h3>
		            </div>
		        </c:forEach>
		        
		    </div>
		</div>
</div>
</div>
</div>
</body>
</html>