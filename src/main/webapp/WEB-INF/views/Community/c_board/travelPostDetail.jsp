<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${travelPostVO.title} - 상세보기</title>
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>

<h1>${travelPostVO.title}</h1>

<p><strong>작성일:</strong> ${travelPostVO.post_date}</p>
<p><strong>조회수:</strong> ${travelPostVO.read_cnt}</p>

<h3>내용</h3>
<p>${travelPostVO.content}</p>

<h3>태그</h3>
<ul>
    <c:forEach var="tag" items="${travelPostVO.tags}">
        <li>${tag}</li>
    </c:forEach>
</ul>

<h3>첨부파일</h3>
<ul>
    <c:forEach var="file" items="${travelPostVO.attachedFiles}">
        <li><a href="${pageContext.request.contextPath}/resources/uploads/${file.save_filename}" download="${file.origin_filename}">${file.origin_filename}</a></li>
    </c:forEach>
</ul>

<a href="${pageContext.request.contextPath}/Community/travel/travelPostList">목록으로 돌아가기</a>

</body>
</html>
