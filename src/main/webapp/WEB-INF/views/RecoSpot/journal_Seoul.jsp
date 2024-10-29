<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/journal.css?v=1.0">
<!-- jQuery를 사용하기 위한 API 추가 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>

<script>

	//맛집을 클릭했을 때 famous.jsp를 호출할 수 있도록 함
	$(".image-item3").on("click", function(){
		
		//famous.jsp를 호출하는 url: /aaa
		location.href = "${pageContext.request.contextPath}/Matzip/famous";
		
	});


</script>




</head>
<body>

<div class="main-container">

<!-- 뜨고 있는 장소 섹션 -->
<div class="hot-spot-section">
    <div class="section2-title">지금 뜨고있는<br>핫플 장소가 궁금해?</div>
    <div class="image-container">
        <c:forEach var="hotplace" items="${hotplaceDetails}" varStatus="status">
            <c:if test="${status.index < 4}">
                <div class="image-item2">
                    <a href="${pageContext.request.contextPath}/HotPlace/${hotplace.contentid}">
                        <img src="${hotplace.firstimage}" alt="${hotplace.title}">
                    </a>
                    <div class="image-description">
                        <div class="image-title">${hotplace.title}</div>
                        <div class="location">${hotplace.addr1}</div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

    <!-- 맛집 섹션 -->
    <div class="restaurant-section">
        <div class="section3-title">우리 동네 <br> 맛집이 궁금해?</div>
        <div class="image-container">
        <c:forEach var="matzip" items="${matzipList}" varStatus="status">
        	<c:if test="${status.index < 4}">
        	<div class="image-item3">
        		<a href="${pageContext.request.contextPath}/matzip/${matzip.contentid}">            
                <img src="${matzip.firstimage}" alt="${matzip.title}"/>
                </a>
                <div class="image-description">
                    <div class="image-title">${matzip.title}</div>
                    <div class="location">${matzip.addr1}</div>
                </div>
                </div>
             </c:if>
        </c:forEach>
        </div>
    </div>
</div>



<jsp:include page="Festival_Seoul.jsp" />

<!-- FontAwesome 스크립트 추가 -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

</body>
</html>
