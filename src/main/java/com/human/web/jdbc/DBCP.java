/*
 * package com.human.web.jdbc;
 * 
 * import java.sql.Connection; import java.sql.PreparedStatement; import
 * java.sql.ResultSet;
 * 
 * import javax.naming.Context; import javax.naming.InitialContext; import
 * javax.sql.DataSource;
 * 
 * DBCP(Database Connection Pool) - 톰캣에서 DB와의 작업을 효율적으로 하기 위해 연결 객체를 데이터베이스 풀로
 * 관리하고 지원해주는 기법 - DBCP 매니저가 어느 정도의 연결 객체를 확보해 놓고 있다가 사용자의 요청이 들어오면 연결객체를 지원해주고
 * 작업이 다 끝나면 연결객체를 DBCP 매니저에게 반환하도록 하는 기법 - 사용자의 요청을 처리하기 위해 매번 드라이버를 로드하고 연결객체를
 * 생성하는 작업을 하지 않아도 됨 - DBCP 설정항목 maxTotal: 풀에서 유지할 수 있는 최대 연결 수 지정. DBCP 크기 제어
 * maxIdle: 연결 풀이 유지할 수 있는 최대 유휴(사용되지 않는) 연결 수 지정 minIdle: 연결 풀에서 유지할 수 있는 최소 유휴
 * 연결 수 지정 maxWaitMillis: 연결이 사용 가능해질 때까지 기다릴 수 있는 최대 시간(밀리초) 지정
 * 
 * - 톰캣에서 DBCP를 이용하기 위한 조치 사항들 1. 오라클의 JDBC 드라이버(ojdbc6.jar)파일을 톰캣의 lib 폴더에 추가해줌
 * MySQL의 JDBC 드라이버(mysql-connector-j-8.3.0.jar)파일을 톰캣의 lib 폴더에 추가해줌
 * 
 * 2. Server 폴더의 server.xml 파일에서 GlobalNamingResources 요소에 Resource요소 추가하기 <!--
 * 오라클 --> <Resource auth="Container" dirverClassName="oracle.jdbc.OracleDriver"
 * minIdle="5" maxIdle="10" maxTotal="20" maxWaitMillis="5000"
 * name="global_oracle_dbcp" password="1234" type="javax.sql.DataSource"
 * url="jdbc:oracle:thin:@localhost:1521:xe" username="sql_dev" />
 * 
 * <!-- MySQL --> <Resource auth="Container"
 * driverClassName="com.mysql.cj.jdbc.Driver" minIdle="5" maxIdle="10"
 * maxTotal="20" maxWaitMillis="5000" name="global_mysql_dbcp" password="1234"
 * type="javax.sql.DataSource"
 * url="jdbc:mysql://localhost:3306/webdb?characterEncoding=UTF-8
 * &amp;useSSL=false &amp;allowPublicKeyRetrieval=true &amp;serverTimezone=UTC"
 * username="web_dev" />
 * 
 * 3. 톰캣의 server.xml 파일에서 현재 웹 프로그램을 나타내는 Context 요소에 ResourceLink요초 추가하기 <!--
 * Oracle --> <ResourceLink global="global_oracle_dbcp" name="oracle_dbcp"
 * type="javax.sql.DataSource" />
 * 
 * <!-- MySQL --> <ResourceLink global="global_mysql_dbcp" name="mysql_dbcp"
 * type="javax.sql.DataSource" />
 * 
 * - JNDI(Java Naming and Directory Interface) - 자바 프로그램 외부에 있는 자원을 사용(lookup)하기
 * 위해 지원되는 기술 - DBCP에서는 톰캣의 server.xml 파일에 저장된 리소스 정보를 가져오기 위해 사용 - Context:
 * JNDI에서 객체를 저장하고 검색하는데 사용되는 기본적인 인터페이스 - lookup(String name): 지정된 이름으로 바인딩된
 * 객체를 검색함
 * 
 * - InitialContext: Context 인터페이스를 구현한 기본 클래스. 애플리케이션이 JNDI 서비스를 처음 사용할 때 생성
 * JNDI를 사용하는데 필요한 환경 설정을 가져옴 - java:comp/env: 톰캣에 의해 제공되는 자원을 참조할 수 있는 컨텍스트
 * 
 * 
 * 
 * public class DBCP {
 * 
 * public Connection conn; public PreparedStatement pstmt; public ResultSet rs;
 * 
 * public DBCP() { try { Context initCtx = new InitialContext(); Context ctx =
 * (Context)initCtx.lookup("java:comp/env"); //server.xml의 Resource를 참조할 수 있는
 * Context객체를 얻음 DataSource source = (DataSource)ctx.lookup("mysql_dbcp");
 * //DBCP를 지원하는 DataSource객체를 얻음 //DataSource: 물리적인 데이터 소스(커넥션 풀)와의 연결을 생성해 주는
 * 자바 표준 인터페이스
 * 
 * conn = source.getConnection(); System.out.println("DBCP 연결 성공");
 * 
 * } catch (Exception e) { System.out.println("DBCP 연결 실패");
 * e.printStackTrace(); } }
 * 
 * public void close() { try {
 * 
 * if(rs != null) rs.close(); if(pstmt != null) pstmt.close(); if(conn != null)
 * conn.close(); System.out.println("DBCP 자원 반납");
 * 
 * } catch (Exception e) { e.printStackTrace(); } }
 * 
 * }
 */