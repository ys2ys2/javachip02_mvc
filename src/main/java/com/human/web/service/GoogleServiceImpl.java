package com.human.web.service;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.Scanner;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.human.web.repository.GoogleDAO;
import com.human.web.repository.M_MemberDAO;
import com.human.web.vo.GoogleVO;
import com.human.web.vo.M_MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GoogleServiceImpl implements GoogleService {

    private final GoogleDAO googleDAO;
    private final M_MemberDAO m_memberDAO;

    private final String CLIENT_ID = "981203649264-3mco0tr5ao6bgb6eulod79rn2bhvtmjd.apps.googleusercontent.com";
    private final String CLIENT_SECRET = "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";
    private final String REDIRECT_URI = "http://localhost:9090/BBOL/auth/google/callback";

    // Google 회원가입 처리
    @Override
    public M_MemberVO handleGoogleCallback(String code) throws Exception {
        String tokenEndpoint = "https://oauth2.googleapis.com/token";
        String userInfoEndpoint = "https://www.googleapis.com/oauth2/v2/userinfo?access_token=";

        // 액세스 토큰 요청
        String tokenResponse = sendPostRequest(tokenEndpoint, code);
        JSONObject tokenJson = new JSONObject(tokenResponse);
        String accessToken = tokenJson.getString("access_token");

        // 사용자 정보 요청
        String userInfoResponse = sendGetRequest(userInfoEndpoint + accessToken);
        JSONObject userInfoJson = new JSONObject(userInfoResponse);

        // Google 사용자 정보 저장
        GoogleVO googleUser = new GoogleVO();
        googleUser.setGoogleId(userInfoJson.getString("id"));
        googleUser.setGoogleName(userInfoJson.optString("name", "익명"));  // name 필드가 없으면 익명으로 설정
        googleUser.setCreateAt(new Timestamp(System.currentTimeMillis()));

        // 이미 가입된 사용자인지 확인
        M_MemberVO existingMember = m_memberDAO.getMemberByGoogleId(googleUser.getGoogleId());
        
        if (existingMember != null) {
            // 이미 가입된 경우 해당 사용자 정보를 반환 (회원가입 처리 X)
            return existingMember;
        }

        // 가입되지 않은 경우 새로 회원가입
        return handleGoogleSignup(googleUser);
    }

    // 회원가입 처리
    private M_MemberVO handleGoogleSignup(GoogleVO googleUser) throws Exception {
        // M_MemberVO 생성 후 DB에 삽입 (m_member 테이블)
        M_MemberVO memberVO = new M_MemberVO();
        memberVO.setM_email(googleUser.getGoogleId());  // 구글 ID를 이메일로 사용
        memberVO.setM_password("");  // 구글 로그인은 비밀번호 필요 없음
        memberVO.setM_nickname(googleUser.getGoogleName());  // 구글 이름을 닉네임으로 사용
        memberVO.setM_registration_type("google");  // 구글로 회원가입한 사용자
        memberVO.setM_status("active");  // 활성 사용자

        // 회원 정보를 m_member 테이블에 삽입 후 mIdx를 받아옴
        int mIdx = m_memberDAO.insertM_Member(memberVO);
        googleUser.setMIdx(mIdx);  // google_login 테이블에 사용할 mIdx 설정

        // 구글 로그인 정보를 google_login 테이블에 저장
        googleDAO.insertGoogleLogin(googleUser);

        return memberVO;
    }

    // 로그인 처리
    @Override
    public M_MemberVO handleGoogleLoginCallback(String code) throws Exception {
        String tokenEndpoint = "https://oauth2.googleapis.com/token";
        String userInfoEndpoint = "https://www.googleapis.com/oauth2/v2/userinfo?access_token=";

        // 액세스 토큰 요청
        String tokenResponse = sendPostRequest(tokenEndpoint, code);
        JSONObject tokenJson = new JSONObject(tokenResponse);
        String accessToken = tokenJson.getString("access_token");

        // 사용자 정보 요청
        String userInfoResponse = sendGetRequest(userInfoEndpoint + accessToken);
        JSONObject userInfoJson = new JSONObject(userInfoResponse);

        // Google 사용자 정보로 DB에서 m_member 정보 조회
        String googleId = userInfoJson.getString("id");

        // 이미 가입된 사용자인지 확인하고 회원 정보를 가져옴
        M_MemberVO memberVO = m_memberDAO.getMemberByGoogleId(googleId);

        if (memberVO == null) {
            throw new Exception("구글 계정으로 회원가입이 필요합니다."); // 가입되지 않은 경우 예외 처리
        }

		/*
		 * //m_profile이 null인 경우 기본 프로필 이미지 경로 설정 if(memberVO.getM_profile() == null ||
		 * memberVO.getM_profile().isEmpty()) {
		 * memberVO.setM_profile("/resources/images/defaultprofile.png"); }
		 */
        
        return memberVO;  // 로그인 처리 후 리턴
    }

    // 액세스 토큰 요청 (POST 요청 처리)
    private String sendPostRequest(String tokenEndpoint, String code) throws Exception {
        String requestBody = "code=" + URLEncoder.encode(code, "UTF-8") +
                "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8") +
                "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, "UTF-8") +
                "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8") +
                "&grant_type=authorization_code";

        URL url = new URL(tokenEndpoint);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        try (OutputStream os = connection.getOutputStream()) {
            os.write(requestBody.getBytes("UTF-8"));
            os.flush();
        }

        int responseCode = connection.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (Scanner scanner = new Scanner(connection.getInputStream())) {
                return scanner.useDelimiter("\\A").next();
            }
        } else {
            try (Scanner errorScanner = new Scanner(connection.getErrorStream())) {
                throw new RuntimeException("Error response: " + errorScanner.useDelimiter("\\A").next());
            }
        }
    }

    // 사용자 정보 요청 (GET 요청 처리)
    private String sendGetRequest(String url) throws Exception {
        URL endpointUrl = new URL(url);
        HttpURLConnection connection = (HttpURLConnection) endpointUrl.openConnection();
        connection.setRequestMethod("GET");

        int responseCode = connection.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (Scanner scanner = new Scanner(connection.getInputStream())) {
                return scanner.useDelimiter("\\A").next();
            }
        } else {
            try (Scanner errorScanner = new Scanner(connection.getErrorStream())) {
                throw new RuntimeException("Error fetching user info: " + errorScanner.useDelimiter("\\A").next());
            }
        }
    }
}



