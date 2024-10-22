package com.human.web.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject; // JSON 라이브러리 추가

import com.human.web.repository.GoogleDAO;
import com.human.web.repository.M_MemberDAO;
import com.human.web.vo.GoogleVO;
import com.human.web.vo.M_MemberVO;

@WebServlet("/auth/google/callback")
public class GoogleTokenServlet extends HttpServlet {

    private String CLIENT_ID;
    private String CLIENT_SECRET;
    private String REDIRECT_URI;
    private static final String TOKEN_ENDPOINT = "https://oauth2.googleapis.com/token";

    @Override
    public void init() throws ServletException {
        // config.properties 파일에서 설정을 읽어옵니다.
        Properties properties = new Properties();
        try (InputStream input = getServletContext().getResourceAsStream("/WEB-INF/classes/config.properties")) {
            if (input == null) {
                throw new IOException("Config file not found");
            }
            properties.load(input);
            CLIENT_ID = properties.getProperty("google.client.id");
            CLIENT_SECRET = properties.getProperty("google.client.secret");
            REDIRECT_URI = properties.getProperty("google.redirect.uri");
        } catch (IOException e) {
            throw new ServletException("Failed to load configuration", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        System.out.println("Google callback invoked with code: " + code);

        if (code != null) {
            try {
                // 액세스 토큰 요청
                String requestBody = "code=" + URLEncoder.encode(code, StandardCharsets.UTF_8) +
                        "&client_id=" + URLEncoder.encode(CLIENT_ID, StandardCharsets.UTF_8) +
                        "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, StandardCharsets.UTF_8) +
                        "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8) +
                        "&grant_type=authorization_code";

                URL url = new URL(TOKEN_ENDPOINT);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("POST");
                connection.setDoOutput(true);
                connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

                try (OutputStream os = connection.getOutputStream()) {
                    os.write(requestBody.getBytes(StandardCharsets.UTF_8));
                    os.flush();
                }

                // 응답 처리
                int responseCode = connection.getResponseCode();
                System.out.println("Response Code: " + responseCode);

                if (responseCode == HttpURLConnection.HTTP_OK) {
                    Scanner scanner = new Scanner(connection.getInputStream());
                    String response = scanner.useDelimiter("\\A").next();
                    scanner.close();

                    // 액세스 토큰 파싱
                    String accessToken = parseAccessToken(response);

                    // 사용자 정보 요청
                    String userInfoEndpoint = "https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + URLEncoder.encode(accessToken, StandardCharsets.UTF_8);
                    URL userInfoUrl = new URL(userInfoEndpoint);
                    HttpURLConnection userInfoConnection = (HttpURLConnection) userInfoUrl.openConnection();
                    userInfoConnection.setRequestMethod("GET");

                    Scanner userInfoScanner = new Scanner(userInfoConnection.getInputStream());
                    String userInfoResponse = userInfoScanner.useDelimiter("\\A").next();
                    userInfoScanner.close();

                 // 사용자 정보 요청 후, GoogleVO 객체 생성
                    GoogleVO googleVO = parseGoogleUserInfo(userInfoResponse);

                    // 사용자 등록 (m_member 테이블에 추가)
                    M_MemberVO memberVO = new M_MemberVO();
                    memberVO.setMEmail(googleVO.getGoogleId()); // 구글 ID를 이메일로 사용
                    memberVO.setMPassword(""); // 비밀번호를 빈 문자열로 설정 (소셜 로그인에서는 필요 없음)
                    memberVO.setMNickname(googleVO.getGoogleName()); // 구글 이름 사용

                    M_MemberDAO memberDAO = new M_MemberDAO();
                    int mIdx = memberDAO.insertM_Member(memberVO); // 사용자를 등록하고 mIdx 받아오기

                    // mIdx를 GoogleVO에 설정
                    googleVO.setMIdx(mIdx); // 반환받은 mIdx 설정

                    // DB에 사용자 정보 저장
                    GoogleDAO googleDAO = new GoogleDAO();
                    googleDAO.insertGoogleLogin(googleVO);

                    // 성공 시 메인 페이지로 리다이렉트
                    resp.sendRedirect(req.getContextPath() + "/index.jsp");

                } else {
                    // 오류가 발생할 경우 오류 메시지 출력
                    String errorResponse = new Scanner(connection.getErrorStream()).useDelimiter("\\A").next();
                    System.out.println("Error Response: " + errorResponse);
                }

            } catch (Exception e) {
                e.printStackTrace();
                resp.setContentType("text/html");
                resp.getWriter().println("<html><body><h1>오류가 발생했습니다.</h1><p>" + e.getMessage() + "</p></body></html>");
            }
        } else {
            resp.setContentType("text/html");
            resp.getWriter().println("<html><body><h1>코드 파라미터가 없습니다.</h1><p>유효하지 않은 요청입니다.</p></body></html>");
        }
    }

    private String parseAccessToken(String jsonResponse) {
        JSONObject jsonObject = new JSONObject(jsonResponse);
        return jsonObject.getString("access_token");
    }
    
    
    private GoogleVO parseGoogleUserInfo(String jsonResponse) {
        JSONObject jsonObject = new JSONObject(jsonResponse);
        GoogleVO googleVO = new GoogleVO();
        googleVO.setGoogleId(jsonObject.getString("id"));
        googleVO.setGoogleName(jsonObject.getString("name"));
        googleVO.setCreateAt(new Timestamp(System.currentTimeMillis())); // 현재 시간으로 설정
        return googleVO;

    }
}