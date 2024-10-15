package com.human.web.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

public class KakaoApiUtil {

    // 액세스 토큰을 가져오는 메소드
    public static String getAccessToken(String code) {
        String accessToken = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // POST 요청 설정
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            // QueryString 형식으로 파라미터 구성
            String params = "grant_type=authorization_code"
                    + "&client_id=cbfd3c2b6545bafe242443ecdb551a7c" // REST API 키
                    + "&redirect_uri=http://localhost:9090/BBOL/login/kakao" // Redirect URI
                    + "&code=" + code;

            // OutputStream으로 데이터 전송
            try (OutputStream os = conn.getOutputStream()) {
                os.write(params.getBytes());
                os.flush();
            }

            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                // 응답이 성공했을 때 액세스 토큰 받기
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                    StringBuilder response = new StringBuilder();
                    String line;
                    while ((line = br.readLine()) != null) {
                        response.append(line);
                    }

                    JSONObject jsonObject = new JSONObject(response.toString());
                    accessToken = jsonObject.getString("access_token");
                }
            } else {
                // 응답이 실패했을 때 상세 메시지 출력
                System.out.println("토큰 요청 실패: " + responseCode);
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream()))) {
                    StringBuilder errorResponse = new StringBuilder();
                    String line;
                    while ((line = br.readLine()) != null) {
                        errorResponse.append(line);
                    }
                    System.out.println("실패 내용: " + errorResponse.toString());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();  // 예외 발생 시 스택 트레이스 출력
        }

        return accessToken;
    }
}
