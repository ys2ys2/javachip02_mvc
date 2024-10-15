package com.human.web.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.KakaoLoginDAO;
import com.human.web.repository.M_MemberDAO;
import com.human.web.vo.KakaoLoginVO;
import com.human.web.vo.M_MemberVO;

@Service
public class KakaoService {

    @Autowired
    private M_MemberDAO memberDAO;  // 회원 정보를 처리하는 DAO

    @Autowired
    private KakaoLoginDAO kakaoLoginDAO;  // 카카오 로그인 정보를 저장하는 DAO

    // 카카오 API에서 사용자 정보를 가져오는 메서드
    public M_MemberVO saveUserInfo(String accessToken) throws Exception {
        // 카카오 API 호출
        String apiURL = "https://kapi.kakao.com/v2/user/me";
        URL url = new URL(apiURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // JSON으로 파싱하여 사용자 정보 가져오기
            JSONObject jsonResponse = new JSONObject(response.toString());
            Long kakaoId = jsonResponse.getLong("id");
            String nickname = jsonResponse.getJSONObject("properties").getString("nickname");

            
            // 기존에 카카오 ID로 등록된 사용자인지 확인
            M_MemberVO existingMember = memberDAO.findByKakaoId(kakaoId);
            if (existingMember != null) {
                // 이미 가입된 사용자이면 그 정보를 반환 (새로운 삽입 없이)
                return existingMember;
            }
            
            // M_MemberVO에 사용자 정보 저장
            M_MemberVO memberInfo = new M_MemberVO();
            memberInfo.setM_email(kakaoId + "@kakao.com");  // 이메일 형식으로 저장
            memberInfo.setM_nickname(nickname);
            memberInfo.setM_registration_type("kakao");

            // DB에 사용자 정보 저장
            int mIdx = memberDAO.insertM_Member(memberInfo);

            // kakao_login 테이블에 저장할 카카오 정보 생성
            KakaoLoginVO kakaoLoginInfo = new KakaoLoginVO();
            kakaoLoginInfo.setKakao_id(kakaoId);
            kakaoLoginInfo.setM_idx(mIdx);
            kakaoLoginInfo.setKakao_nickname(nickname);

            // 카카오 로그인 정보 DB에 저장
            kakaoLoginDAO.insertKAKAOLOGIN(kakaoLoginInfo);

            return memberInfo;  // 사용자 정보를 반환
        } else {
            throw new Exception("카카오 API 호출 실패: " + responseCode);
        }
    }
}
