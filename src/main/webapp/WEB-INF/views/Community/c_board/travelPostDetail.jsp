<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행기 상세보기</title>
</head>
<body>
    <h2>여행기 상세보기</h2>

    <!-- 여행기 제목 -->
    <div>
        <h3>${travelPostVO.title}</h3>
    </div>

    <!-- 여행기 본문 내용 -->
    <div>
        <p>${travelPostVO.content}</p>
    </div>

    <!-- 여행기 파일 목록 출력 -->
    <div>
        <h4>첨부파일</h4>
        <c:forEach var="file" items="${travelPostVO.attachedFiles}">
            <p>
                <a href="${pageContext.request.contextPath}/resources/uploads/${file.save_filename}" target="_blank">
                    ${file.origin_filename}
                </a> (${file.file_size} bytes)
            </p>
        </c:forEach>
    </div>

    <!-- 목록으로 돌아가기 버튼 -->
    <div>
        <button onclick="location.href='${pageContext.request.contextPath}/community/c_board/travelPostList.do'">목록으로</button>
    </div>
</body>
</html>
