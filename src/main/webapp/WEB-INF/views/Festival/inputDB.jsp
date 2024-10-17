<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import="java.util.ArrayList, java.util.List, java.util.Map" %>
<%@ page import="com.human.web.jdbc.DBCP" %>
<%@ page import="java.sql.ResultSet" %>

<%
    // 사용자가 선택한 콘텐츠 ID 리스트 가져오기
    String contentIds = request.getParameter("selectedContentIds"); // 콘텐츠ID 가져오기
    if (contentIds == null || contentIds.isEmpty()) { // 없으면 out.println
        out.println("<p>콘텐츠 ID를 선택해 주세요.</p>");
        return;
    }
    String[] contentIdArray = contentIds.split(","); // 쉼표로 구분된 콘텐츠 ID 문자열을 배열(String[]) 로 변환

    // 세션에서 'detailItemList'를 가져옴
    List<Map<String, Object>> detailItemList = (List<Map<String, Object>>) request.getSession().getAttribute("detailItemList");
 	// 세션에서 'detailItemList'라는 이름으로 저장된 데이터(세부 정보 리스트)를 가져오기
    if (detailItemList == null) { // 없으면 out.println
        out.println("<p>세션에서 데이터를 가져올 수 없습니다.</p>");
        return;
    }

    // DBCP 및 DB 연결 초기화
    DBCP dbcp = new DBCP(); // DBCP 객체를 생성, 데이터베이스 연결 초기화
    Connection conn = null; // 데이터베이스 연결 객체 선언
    PreparedStatement pstmt = null; // SQL 쿼리 실행을 위한 PreparedStatement 객체 선언

    try {
        // 데이터베이스 연결
        conn = dbcp.conn;	// DBCP를 통해 Connection 객체 가져오기

        // 테이블 생성 SQL 테이블 이름 = hotplace
        String createTableSQL = "CREATE TABLE IF NOT EXISTS hotplace ("
                + "id INT AUTO_INCREMENT PRIMARY KEY," 	// id는 auto_increment
                + "contentid VARCHAR(255) NOT NULL," 	// 콘텐츠 id
                + "title VARCHAR(255),"					// 제목
                + "addr1 VARCHAR(255),"					// 주소
                + "overview TEXT,"						// 설명
                + "mapx DOUBLE,"						// 경도
                + "mapy DOUBLE,"						// 위도
                + "firstimage TEXT,"					// 이미지 url (TEXT형으로 바꿔서 여러개 저장 가능하게)
                + "areacode VARCHAR(255)"				// 지역 코드
                + ")";

        // 테이블 생성 실행
        pstmt = conn.prepareStatement(createTableSQL);	// createTableSQL 준비!
        pstmt.executeUpdate();							// sql 실행해서 테이블 생성, 있으면 안함
        out.println("<p>테이블 확인!</p>");				// 성공 메세지
        pstmt.close();									// pstmt 닫기(리소스 해제)

        // 선택된 콘텐츠 ID들을 데이터베이스에 삽입하기 위한 SQL
        String insertSQL = "INSERT INTO hotplace (contentid, title, addr1, overview, mapx, mapy, firstimage, areacode) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(insertSQL);		// inserSQL 준비!

        // 사용자가 선택한 콘텐츠 데이터를 삽입
        for (String contentId : contentIdArray) {	// for문으로 반복돌리자 contentIdArray의 각 콘텐츠 ID에 대해 반복
            contentId = contentId.trim();			// 공백을 제거하여 콘텐츠 ID를 정리.

            // detailItemList에서 contentId에 맞는 데이터를 찾기
            for (Map<String, Object> detailData : detailItemList) {	// detailItemList의 각 데이터에 대해 반복
                if (contentId.equals(detailData.get("contentid"))) { // 현재 contentId와 같은 데이터를 찾았을 경우
                    // 추가 이미지들을 쉼표로 구분된 문자열로 변환
                    StringBuilder imageUrls = new StringBuilder((String) detailData.get("firstimage")); // firstimage 추가

                    List<Map<String, String>> images = (List<Map<String, String>>) detailData.get("images");
                    if (images != null && !images.isEmpty()) {
                        for (Map<String, String> imageData : images) {
                            if (imageUrls.length() > 0) {
                                imageUrls.append(",");  // 기존 이미지가 있다면 쉼표 추가
                            }
                            imageUrls.append(imageData.get("originimgurl"));  // 추가 이미지 URL 추가
                        }
                    }

                    // 데이터 삽입 준비
                    pstmt.setString(1, contentId); // 자동 증가 Id값 ? = 1
                    pstmt.setString(2, (String) detailData.get("title")); // 실제 title 데이터 ? = 2
                    pstmt.setString(3, (String) detailData.get("addr1")); // 실제 addr1 데이터 ? = 3
                    pstmt.setString(4, (String) detailData.get("overview")); // 실제 overview 데이터 ? = 4
                    pstmt.setDouble(5, Double.parseDouble((String) detailData.get("mapx"))); // 실제 mapx 데이터 ? = 5
                    pstmt.setDouble(6, Double.parseDouble((String) detailData.get("mapy"))); // 실제 mapy 데이터 ? = 6
                    pstmt.setString(7, imageUrls.toString()); // 쉼표로 구분된 이미지 URL들 ? = 7
                    pstmt.setString(8, (String) detailData.get("areacode")); // 실제 지역 코드 데이터 ? = 8

                    // 데이터 삽입 실행
                    pstmt.executeUpdate();
                    break; // 해당 contentId에 맞는 데이터를 찾으면 루프 종료
                }
            }
        }

        out.println("<p>선택된 공공데이터가 성공적으로 데이터베이스에 저장되었습니다.</p>");

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>데이터베이스 작업 중 오류가 발생! : " + e.getMessage() + "</p>");
    } finally {
        // 자원 반납
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        dbcp.close();
    }
    
    String message = ""; // 성공/실패 메시지 저장 변수
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DB 저장 결과</title>
    <link rel="stylesheet" href="../HotPlace/processDetailApi.css">
</head>
<body>
    <div class="container">
        <h1>DB 저장 결과</h1>
        <p>${message}</p>
        
        <form action="inputApi.jsp" method="get">
            <button type="submit">API 조회로 돌아가기</button>
        </form>
    </div>

    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>
