package com.human.web.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import com.human.web.repository.KakaoLoginDAO;
import com.human.web.repository.M_MemberDAO;
import com.human.web.vo.KakaoLoginVO;
import com.human.web.vo.M_MemberVO;

public class KakaoService {
    private static final String USER_INFO_URL = "https://kapi.kakao.com/v2/user/me";
    public void saveUserInfo(String accessToken) {
        HttpURLConnection conn = null;
        BufferedReader br = null;

        try {
            // 카카오 API를 호출하여 사용자 정보 요청
            URL url = new URL(USER_INFO_URL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                StringBuilder response = new StringBuilder();
                String line;

                while ((line = br.readLine()) != null) {
                    response.append(line);
                }

                // 응답 JSON에서 사용자 정보 추출
                JSONObject userInfoJson = new JSONObject(response.toString());
                Long kakaoId = userInfoJson.getLong("id");
                String nickname = userInfoJson.getJSONObject("properties").getString("nickname");

                // M_MemberDTO 생성 및 데이터 설정
                M_MemberVO memberVO = new M_MemberVO();
                memberVO.setMEmail(kakaoId + "@kakao.com"); // 카카오 ID를 이메일 형식으로 사용
                memberVO.setMNickname(nickname);
                memberVO.setMRegistrationType("kakao"); // 가입 방식 설정

                M_MemberDAO memberDAO = new M_MemberDAO();
                KakaoLoginDAO kakaoLoginDAO = new KakaoLoginDAO();

                // 멤버 정보를 DB에 삽입
                System.out.println("MemberDAO에 사용자 정보 삽입 시도 중...");
                int memberIdx = memberDAO.insertM_Member(memberVO); // m_member에 사용자 정보 삽입
                if (memberIdx != -1) {
                    System.out.println("MemberDAO에 사용자 정보 삽입 성공, KakaoLoginDAO에 정보 삽입 시도 중...");
                  
                    KakaoLoginVO kakaoLoginVO = new KakaoLoginVO();
                    kakaoLoginVO.setKakao_id(kakaoId);
                    kakaoLoginVO.setM_idx(memberIdx); // 올바른 memberIdx가 설정되었는지 확인
                    kakaoLoginVO.setKakao_nickname(nickname);
                    kakaoLoginVO.setCreate_at(new java.sql.Timestamp(System.currentTimeMillis())); // 현재 시간 설정

                    System.out.println("KakaoLoginDTO 값 확인:");
                    System.out.println("kakao_id: " + kakaoLoginVO.getKakao_id());
                    System.out.println("m_idx: " + kakaoLoginVO.getM_idx());
                    System.out.println("kakao_nickname: " + kakaoLoginVO.getKakao_nickname());
                    System.out.println("create_at: " + kakaoLoginVO.getCreate_at());

                    // Kakao 로그인 정보를 DB에 삽입
                    int insertResult = kakaoLoginDAO.insertKAKAOLOGIN(kakaoLoginVO);
                    kakaoLoginDAO.insertKAKAOLOGIN(kakaoLoginVO);
                    System.out.println("DB에 카카오 사용자 정보가 성공적으로 저장되었습니다.");
                } else {
                    System.err.println("DB에 사용자 정보 저장 실패");
                }
            } else {
                System.err.println("사용자 정보 요청 실패: " + responseCode);
            }
        } catch (Exception e) {
            System.err.println("사용자 정보 저장 중 예외가 발생했습니다.");
            e.printStackTrace();
        } finally {
            try {
                if (br != null) br.close();
                if (conn != null) conn.disconnect();
            } catch (Exception e) {
                System.err.println("자원 해제 중 오류가 발생했습니다.");
                e.printStackTrace();
            }
        }
    }
}