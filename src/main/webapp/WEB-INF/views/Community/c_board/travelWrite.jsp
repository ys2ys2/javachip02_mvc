<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행기 작성</title>
    <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css"> <!-- header.css -->
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css"> <!-- footer.css -->
    <link href="${pageContext.request.contextPath}/resources/css/travelWrite.css" rel="stylesheet" type="text/css"> <!-- travelWrite.css -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
    <script>
    $(document).ready(function(){
        // 파일 선택 이벤트 핸들러 바인딩
        $("#imageUpload").on("change", function(){
            let fileNames = "";
            for(let i = 0; i < this.files.length; i++){
                fileNames += this.files[i].name + " (" + Math.round(this.files[i].size / 1000000) + " MB)<br>";
            }
            if(fileNames === "") {
                fileNames = "선택된 파일 없음";
            }
            $("#file-name").css("margin-top", "10px").html(fileNames);
        });
    });
    </script>
</head>
<body>

<div class="overlay"></div>

    <header>
        <div class="header-container">
            <div class="logo">BBOL BBOL BBOL</div>
            <nav>
                <ul>
                    <li><a href="#">홈</a></li>
                    <li><a href="#">커뮤니티</a></li>
                    <li><a href="#">여행지</a></li>
                    <li><a href="#">여행뽈뽈</a></li>
                </ul>
            </nav>
        </div>
    </header>


    <div class="write-container">
        <h2>여행기 작성하기</h2>
        <!-- 게시글 작성 폼 -->
        <form name="frmTravelWrite" action="${pageContext.request.contextPath}/community/c_board/writeProcess.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="topic">토픽</label>
                <select id="topic" name="topic" required>
                    <option value="" disabled selected>토픽을 선택해주세요.</option>
                    <option value="도시여행">도시여행</option>
                    <option value="자연여행">자연여행</option>
                    <option value="해외여행">해외여행</option>
                </select>
            </div>
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" placeholder="제목을 입력해주세요." required>
            </div>
            <div class="form-group">
                <label for="tags">태그</label>
                <input type="text" id="tagsInput" name="tags" placeholder="태그를 쉼표로 구분해서 입력하세요.">
            </div>
            <div class="form-group">
                <label for="content">본문</label>
                <textarea id="content" name="content" placeholder="내용을 입력해주세요." required></textarea>
            </div>
            <div class="form-group">
                <label for="imageUpload">이미지 업로드</label>
                <div class="file-upload-wrapper">
                    <label class="file-upload-button" for="imageUpload" id="span-file-btn">파일 선택</label>
                    <input type="file" id="imageUpload" name="uploadFiles[]" accept="image/*" multiple>
                    <div id="file-name" style="white-space: pre-wrap;">선택된 파일 없음</div>
                </div>
            </div>
            <div class="button-group">
                <button type="submit" class="submit-button">게시글 작성 완료</button>
                <input type="reset" value="다시입력">
                <input type="button" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/web/Community/travelPostList'">
            </div>
        </form>
    </div>
</body>
</html>
