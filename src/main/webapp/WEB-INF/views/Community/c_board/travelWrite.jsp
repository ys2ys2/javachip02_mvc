<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행기 작성</title>
    <link href="${pageContext.request.contextPath}/resources/css/travelWrite.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
	<!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />

<div class="write-container">
    <h2>여행기 작성하기</h2>
    
    <!-- 게시글 작성 폼 -->
    <form class="write"name="frmTravelWrite" action="${pageContext.request.contextPath}/Community/travel/writeProcess" method="post" enctype="multipart/form-data">
        <!-- hidden 필드를 이용해 tp_idx에 기본값 설정 -->
       <input type="hidden" id="tp_idx" name="tp_idx" value="${travelPost != null ? travelPost.tp_idx : 0}">

        <div class="form-group">
            <label for="topic">토픽</label>
            <select id="topic" name="topic" required>
                <option value="" disabled selected>토픽을 선택해주세요.</option>
                <option value="도시여행">도시여행</option>
                <option value="자연여행">자연여행</option>
                <option value="힐링여행">힐링여행</option>
                <option value="관광여행">관광여행</option>
                <option value="가족과함께">가족과함께</option>
                <option value="연인과함께">연인과함께</option>
                <option value="친구와함께">친구와함께</option>
            </select>
        </div>

        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" placeholder="제목을 입력해주세요." required>
        </div>

        <div class="form-group">
            <label for="tags">태그</label>
            <input type="text" id="tagsInput" placeholder="태그를 쉼표로 구분해서 입력하세요.">
            <div id="tagsContainer"></div> <!-- 실시간으로 태그를 보여줄 컨테이너 -->
            <input type="hidden" id="tags" name="tags"> <!-- 서버로 전송할 실제 태그 -->
        </div>

        <div class="form-group">
            <label for="content">본문</label>
            <textarea id="content" name="content" placeholder="내용을 입력해주세요." required></textarea>
        </div>

        <div class="form-group">
            <label for="imageUpload">이미지 업로드</label>
            <div class="file-upload-wrapper">
                <label class="file-upload-button" for="imageUpload" id="span-file-btn">파일 선택</label>
                <input type="file" id="imageUpload" name="uploadFiles" accept="image/*" multiple>
                <div id="file-name" style="white-space: pre-wrap;">선택된 파일 없음</div>
            </div>
        </div>

        <div class="button-group">
            <button type="submit" class="submit-button">작성 완료</button>
            <input type="button" class="back-button" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/Community/travelPostList'">
        </div>
    </form>
</div>
 	<!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />
<script>
$(document).ready(function() {
    let tags = [];

    // 태그 입력 처리
    $("#tagsInput").on("keypress", function(event) {
        if (event.key === ",") {
            event.preventDefault();
            const tagValue = $(this).val().trim().replace(",", "");
            if (tagValue && !tags.includes(tagValue)) {
                tags.push(tagValue);
                renderTags();
                $(this).val(""); // 입력란 초기화
            }
        }
    });

 	// 태그 삭제 처리 (이벤트 위임 방식)
    $("#tagsContainer").on("click", ".tag-remove", function() {
        const tagValue = $(this).data("tag");  // 클릭한 태그의 데이터를 가져옵니다.
        $(this).parent().remove();  // 부모 요소인 .tag 전체를 삭제합니다.
        tags = tags.filter(tag => tag !== tagValue);  // 배열에서 해당 태그를 제거합니다.
        $("#tags").val(tags.join(","));  // 숨겨진 필드에 태그 리스트 업데이트
    });

    function renderTags() {
        const tagsContainer = $("#tagsContainer");
        tagsContainer.empty();
        tags.forEach(tag => {
            const tagElement = `<span class="tag">\${tag} <span class="tag-remove" data-tag="${tag}">&times;</span></span>`;
            tagsContainer.append(tagElement);
        });
        $("#tags").val(tags.join(",")); // 숨겨진 필드에 태그 저장
    }

    // 파일 선택 시 파일명 표시
    $("#imageUpload").on("change", function() {
        let fileNames = "";
        for (let i = 0; i < this.files.length; i++) {
            fileNames += this.files[i].name + " (" + Math.round(this.files[i].size / 1000000) + " MB)<br>";
        }
        if (fileNames === "") {
            fileNames = "선택된 파일 없음";
        }
        $("#file-name").css("margin-top", "10px").html(fileNames);
    });
    
    // 새로 입력 시 태그 배열 초기화
    $("#tagsInput").on("focus", function() {
        if (tags.length === 0) {  // 입력된 태그가 없는 경우에만 초기화
            renderTags();
        }
    });
    
});

</script>

</body>
</html>
