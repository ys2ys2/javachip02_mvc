<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행 일정 리스트</title>
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/TripList.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
    <style>
        /* "작성하기" 버튼 스타일 */
        .create-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            margin-left: 8px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }
        .create-button:hover {
            background-color: #45a049;
        }
        .search-container {
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</head>
<body>
<!-- header -->
<jsp:include page="/WEB-INF/views/Components/header.jsp" />

<div class="trip-list-container">
    <!-- 필터 부분 -->
    <div class="filter-container">
        <select id="travel-period" onchange="filterTrips()">
            <option value="all">여행기간</option>
            <option value="1">1월</option>
            <option value="2">2월</option>
            <option value="3">3월</option>
            <option value="4">4월</option>
            <option value="5">5월</option>
            <option value="6">6월</option>
            <option value="7">7월</option>
            <option value="8">8월</option>
            <option value="9">9월</option>
            <option value="10">10월</option>
            <option value="11">11월</option>
            <option value="12">12월</option>
        </select>
        <select id="duration" onchange="filterTrips()">
            <option value="all">1일 이상 전체</option>
            <option value="5">5일 이하</option>
            <option value="6">6일 이상</option>
        </select>
        <select id="sort" onchange="filterTrips()">
            <option value="latest">최신순</option>
            <option value="popular">인기순</option>
        </select>
        
        <!-- 검색창과 버튼들 -->
	    <div class="search-container">
	        <input type="text" id="search" placeholder="검색어를 입력하세요" oninput="filterTrips()">
	        <button class="search-button" onclick="filterTrips()">
	       	<span class="material-icons">search</span>
	       	</button>
	        <!-- 깔끔하게 디자인된 "작성하기" 버튼 -->
	        <a href="http://localhost:9090/BBOL/TripSchedule/TripSchedule" class="create-button">작성하기</a>
	    </div>
        
        
    </div>
    
    <!-- 여행 일정 리스트 -->
    <div class="trip_List" id="tripList">
        <c:forEach var="trip" items="${tripList}" varStatus="status">
            <c:if test="${status.first || tripList[status.index - 1].post_id != trip.post_id}">
                <div class="trip-item" data-post-id="${trip.post_id}" data-period-start="${trip.period_start}" data-period-end="${trip.period_end}" data-title="${trip.title.toLowerCase()}" data-duration="${fn:length(trip.dayNumbers)}">
                    <div class="trip-info">
                        <a href="${pageContext.request.contextPath}/TripSchedule/TripPage?post_id=${trip.post_id}">
                            <p class="plan-text">PLAN · ${trip.period_start} ~ ${trip.period_end}</p>
                            <h2>${trip.title}</h2>
                        </a>
                        <p class="location"><span class="location-icon">📍</span>${trip.city_name}</p>
                        <p class="nickname">by ${trip.m_nickname}</p>
                    </div>
                    <div class="map-thumbnail">
                        <c:choose>
                            <c:when test="${trip.thumbnail != null}">
                                <a href="${pageContext.request.contextPath}/TripSchedule/TripPage?post_id=${trip.post_id}">
                                    <img src="${trip.thumbnail}" alt="Map Thumbnail" />
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/TripSchedule/TripPage?post_id=${trip.post_id}">
                                    <img src="${pageContext.request.contextPath}/resources/images/default-thumbnail.png" alt="Default Thumbnail" />
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

<!-- footer -->
<jsp:include page="/WEB-INF/views/Components/footer.jsp" />

<script>
    function filterTrips() {
        const searchKeyword = document.getElementById("search").value.toLowerCase();
        const travelPeriod = document.getElementById("travel-period").value;
        const duration = document.getElementById("duration").value;
        const sortOption = document.getElementById("sort").value;

        const tripItems = document.querySelectorAll(".trip-item");

        tripItems.forEach(item => {
            const title = item.getAttribute("data-title");
            const periodStart = new Date(item.getAttribute("data-period-start"));
            const periodEnd = new Date(item.getAttribute("data-period-end"));
            const tripDuration = parseInt(item.getAttribute("data-duration"));

            let matchesSearch = title.includes(searchKeyword);
            let matchesPeriod = travelPeriod === "all" || (periodStart.getMonth() + 1 === parseInt(travelPeriod));
            let matchesDuration = duration === "all" ||
                (duration === "5" && tripDuration <= 5) ||
                (duration === "6" && tripDuration > 5);

            item.style.display = (matchesSearch && matchesPeriod && matchesDuration) ? "flex" : "none";
        });

        sortTrips(sortOption);
    }

    function sortTrips(sortOption) {
        const tripList = document.getElementById("tripList");
        const tripItems = Array.from(document.querySelectorAll(".trip-item"));

        if (sortOption === "latest") {
            tripItems.sort((a, b) => new Date(b.getAttribute("data-period-start")) - new Date(a.getAttribute("data-period-start")));
        } else if (sortOption === "popular") {
            // 인기순 정렬 로직이 필요한 경우 추가 가능
        }

        tripItems.forEach(item => tripList.appendChild(item));
    }
</script>



</body>
</html>
