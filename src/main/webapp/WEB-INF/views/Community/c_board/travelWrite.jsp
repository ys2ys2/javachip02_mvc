<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행기 작성</title>
    <link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/travelWrite.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>

<div class="overlay"></div>

  <header>
    <div class="header-container">
      <div class="logo">
        <a href="${pageContext.request.contextPath}/HomePage/mainpage">BBOL BBOL BBOL</a>
      </div>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/HomePage/mainpage">홈</a></li>
          <li><a href="${pageContext.request.contextPath}/Community/c_main">커뮤니티</a></li>
          <li><a href="${pageContext.request.contextPath}/HotPlace/hotplace2">여행지</a></li>
          <li><a href="${pageCOntext.request.contextPath}/TravelSpot/TravelSpot">여행뽈뽈</a></li>
          <li><a href="${pageContext.request.contextPath}/TripSched/tripSched">여행일정</a></li>
        </ul>
      </nav>
      <div class="member">
        <c:choose>
          <c:when test="${not empty member}">
            <!-- 로그인 성공 시, 마이페이지와 로그아웃 표시 -->
            <div class="welcome">
            	<span class="userprofile"><img src="${member.m_profile}" alt="user-profile"></span>
            	${member.m_nickname}님 환영합니다!
            </div>
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

<div class="write-container">
    <h2>여행기 작성하기</h2>
    
    <!-- 게시글 작성 폼 -->
    <form name="frmTravelWrite" action="${pageContext.request.contextPath}/Community/travel/writeProcess" method="post" enctype="multipart/form-data">
        <!-- hidden 필드를 이용해 tp_idx에 기본값 설정 -->
       <input type="hidden" id="tp_idx" name="tp_idx" value="${travelPost != null ? travelPost.tp_idx : 0}">

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
            <button type="submit" class="submit-button">게시글 작성 완료</button>
            <input type="reset" value="다시입력">
            <input type="button" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/Community/travelPostList'">
        </div>
    </form>
</div>

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

    // 태그 삭제 처리
    $("#tagsContainer").on("click", ".tag-remove", function() {
        const tagValue = $(this).data("tag");
        tags = tags.filter(tag => tag !== tagValue);
        renderTags();
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
});

</script>

</body>
</html>
