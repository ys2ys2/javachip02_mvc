<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행기 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/travelpostlist.css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
    <script>
        var contextPath = '${pageContext.request.contextPath}';
    </script>
</head>
<body>
<!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />

<!-- 전체 레이아웃을 컨트롤하는 컨테이너 -->
<div class="container">
    <!-- 태그/토픽 섹션 -->
    <div class="tag-section">
        <h4>#태그/토픽 선택</h4>
        <div class="tags">
            <button class="filter-button" data-filter="전체">#전체</button>
            <button class="filter-button" data-filter="서울">#서울</button>
            <button class="filter-button" data-filter="부산">#부산</button>
            <button class="filter-button" data-filter="제주">#제주</button>
            <button class="filter-button" data-filter="인천">#인천</button>
            <button class="filter-button" data-filter="도시여행">#도시여행</button>
            <button class="filter-button" data-filter="자연여행">#자연여행</button>
            <button class="filter-button" data-filter="해외여행">#해외여행</button>
        </div>
    </div>

    <!-- 여행기 목록 및 페이지네이션을 묶음 -->
    <div class="post-list-container">
    	 <!-- 검색 입력 필드를 우측 상단으로 이동 -->
        <div class="search-section">
            <input type="text" id="search-query" placeholder="검색어를 입력하세요" />
            <button id="search-button">검색</button>
        </div>
        <div class="post-list">
            <!-- 필터링된 여행기들이 여기에 AJAX로 동적으로 추가됩니다 -->
        </div>
        
        <!-- 페이지네이션을 게시글 목록 바로 밑에 배치 -->
        <div class="pagination">
            <!-- 페이지네이션 버튼이 여기에 동적으로 추가됩니다 -->
        </div>
    </div>
</div>

   <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />
    
<script src="${pageContext.request.contextPath}/resources/js/travelpostlist.js"></script>
</body>
</html>
