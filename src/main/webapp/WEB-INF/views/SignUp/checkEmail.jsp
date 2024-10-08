<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%
	//중복된 이메일 찾기(메일이 존재하는지 확인)
	
    String email = request.getParameter("email"); //클라이언트가 요청한 이메일 주소 가져옴
    boolean exists = false; //중복되는지 여부를 저장할 변수, 초기값은 false

    try {
        Context initCtx = new InitialContext(); //리소스(DataSource)를 검색하기 위한 초기 컨텍스트 객체 생성
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/mysql_dbcp"); //DataSource 객체를 JNDI에서 검색하여 가져옴 (jdbc/mysql_dbcp라는 이름으로 등록된 DB 연결 풀)
        Connection conn = ds.getConnection(); //DataSource를 통해 데이터베이스 연결을 획득

        
        // 이메일 중복 체크를 위한 SQL 쿼리 준비
        String sql = "SELECT COUNT(*) FROM m_member WHERE m_email = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql); //// PreparedStatement 객체 생성, SQL 쿼리와 입력된 이메일을 바인딩
        pstmt.setString(1, email);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            exists = rs.getInt(1) > 0;
            // 조회된 결과의 첫 번째 값(카운트 값)이 0보다 크면 중복된 이메일임
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (exists) {
        out.print("exists");
    } else {
        out.print("available");
    }
%>
