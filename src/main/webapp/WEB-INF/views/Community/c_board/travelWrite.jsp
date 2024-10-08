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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="overlay"></div>

    <header>
        <div class="header-container">
            <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
            <nav>
                <ul>
                    <li><a href="#" data-ko="홈" data-en="Home">홈</a></li>
                    <li><a href="#" data-ko="커뮤니티" data-en="Community">커뮤니티</a></li>
                    <li><a href="#" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
                    <li><a href="#" data-ko="여행뽈뽈" data-en="BBOL BBOL BBOL">여행뽈뽈</a></li>
                    <button class="search-btn">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
          			<button class="user-btn" onclick="location.href='${pageContext.request.contextPath}/Login/login'">
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

    <div class="write-container">
        <h1>여행기 작성하기</h1>
        <!-- 게시글 작성 폼 -->
        <form id="travelWriteForm" action="${pageContext.request.contextPath}/Community/c_board/savetravelWrite" method="POST" enctype="multipart/form-data">
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
                <div id="tagContainer" class="tag-container">
                    <input type="text" id="tagsInput" name="tags" placeholder="태그를 쉼표로 구분해서 입력하세요.">
                </div>
            </div>
            <div class="form-group">
                <label for="content">본문</label>
                <textarea id="content" name="content" placeholder="내용을 입력해주세요." required></textarea>
            </div>
            <div class="form-group">
                <label for="imageUpload">이미지 업로드</label>
                <div class="file-upload-wrapper">
                    <label class="file-upload-button" for="imageUpload">파일 선택</label>
                    <input type="file" id="imageUpload" name="imageUpload" accept="image/*">
                    <span id="file-name">선택된 파일 없음</span>
                </div>
            </div>
            <div class="button-group">
                <button type="submit" class="submit-button">게시글 작성 완료</button>
            </div>
        </form>
    </div>

    <!-- 푸터 부분 -->
    <footer>
        <div class="footer-container">
            <div class="footer-section">
                <h4>회사소개</h4>
                <ul>
                    <li><a href="#">회사소개</a></li>
                    <li><a href="#">브랜드 이야기</a></li>
                    <li><a href="#">채용공고</a></li>
                </ul>
            </div>

            <!-- 고객지원 -->
            <div class="footer-section">
                <h4>고객지원</h4>
                <ul>
                    <li><a href="#">공지사항</a></li>
                    <li><a href="#">자주묻는 질문</a></li>
                    <li><a href="#">문의하기</a></li>
                </ul>
            </div>

            <!-- 이용약관 -->
            <div class="footer-section">
                <h4>이용약관</h4>
                <ul>
                    <li><a href="#">이용약관</a></li>
                    <li><a href="#">개인정보처리방침</a></li>
                    <li><a href="#">저작권 보호정책</a></li>
                </ul>
            </div>

            <!-- 회사 정보 -->
            <div class="footer-company-info">
                <p>상호: (주)BBOL | 대표: 박예슬 | 사업자등록번호: 123-45-67890 | 통신판매업 신고번호: 2024-충남천안-00000 | 개인정보관리 책임자: 수수옥</p>
                <p>주소: 충청남도 천안시 동남구 123 | 이메일: support@BBOL3.com | 대표전화: 02-1234-5678</p>
                <p>© 2024 BBOLBBOLBBOL. All Rights Reserved.</p>
            </div>

            <!-- 소셜 미디어 -->
            <div class="footer-social">
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </footer>

    <!-- 파일 업로드 시 파일 이름 표시 스크립트 -->
    <script>
        document.getElementById('imageUpload').onchange = function () {
            var fileName = this.value.split('\\').pop(); // 파일 이름만 가져오기
            document.getElementById('file-name').textContent = fileName || "선택된 파일 없음";
        };
    </script>
</body>
</html>
