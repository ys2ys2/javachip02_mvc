<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행기 목록</title>
    <link href="${pageContext.request.contextPath}/resources/css/travelList.css" rel="stylesheet" type="text/css">
    <style>
        .table-container {
            max-width: 1000px;
            margin: 30px auto;
            border-collapse: collapse;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 18px;
            text-align: left;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f4f4f4;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin: 20px 0;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-align: center;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="table-container">
        <h2>여행기 목록</h2>
        
        <!-- 검색 및 글 작성 버튼 -->
        <div class="button-group">
            <form method="get" action="${pageContext.request.contextPath}/community/c_board/travelPostList.do">
                <select name="searchField">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                </select>
                <input type="text" name="searchWord" placeholder="검색어를 입력하세요">
                <button type="submit" class="btn">검색</button>
            </form>
            
            <!-- 글 작성 버튼 -->
            <a href="${pageContext.request.contextPath}/Community/c_board/travelWrite">
                <button class="btn">여행기 작성</button>
            </a>
        </div>

        <!-- 여행기 목록 테이블 -->
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>조회수</th>
                    <th>첨부파일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty travelPosts}">
                        <tr>
                            <td colspan="5" style="text-align:center;">등록된 여행기가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="post" items="${travelPosts}" varStatus="vs">
                            <tr>
                                <!-- 번호 -->
                                <td>${vs.count}</td>
                                
                                <!-- 제목: 상세보기 페이지로 이동 -->
                                <td>
                                    <a href="${pageContext.request.contextPath}/community/c_board/travelPostDetail.do?tp_idx=${post.tp_idx}">
                                        ${post.title}
                                    </a>
                                </td>
                                
                                <!-- 작성일 -->
                                <td>
                                    <fmt:formatDate value="${post.post_date}" type="date" pattern="yyyy-MM-dd" />
                                </td>
                                
                                <!-- 조회수 -->
                                <td>${post.read_cnt}</td>
                                
                                <!-- 첨부파일 아이콘 표시 -->
                                <td>
                                    <c:if test="${not empty post.attachedFiles}">
                                        <i class="fa fa-paperclip"></i>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <!-- 목록 끝 -->
</body>
</html>
