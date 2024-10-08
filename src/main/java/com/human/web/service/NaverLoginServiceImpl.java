package com.human.web.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.M_MemberDAO;
import com.human.web.repository.NaverLoginDAO;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.NaverLoginVO;

@Service
public class NaverLoginServiceImpl implements NaverLoginService {

    @Autowired
    private M_MemberDAO mMemberDAO;  // M_MemberDAO로 수정

    @Autowired
    private NaverLoginDAO naverLoginDAO;

    @Override
    public boolean processNaverLogin(String code, String state) {
        try {
            String clientId = "hNC1YTLpfwJa8Hc6uBaJ";
            String clientSecret = "zoh620bPc0";
            String redirectURI = "http://localhost:9090/web/naver/callback";

            String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&client_id=" 
                          + clientId + "&client_secret=" + clientSecret + "&code=" + code + "&state=" + state;

            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            int responseCode = con.getResponseCode();

            if (responseCode == 200) {
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer response = new StringBuffer();
                while ((inputLine = br.readLine()) != null) {
                    response.append(inputLine);
                }
                br.close();

                // JSON 파싱 후 액세스 토큰 가져오기
                JSONObject jsonResponse = new JSONObject(response.toString());
                String accessToken = jsonResponse.getString("access_token");

                // 사용자 정보 요청
                return requestUserInfo(accessToken);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean requestUserInfo(String accessToken) {
        try {
            String userApiURL = "https://openapi.naver.com/v1/nid/me";
            URL userUrl = new URL(userApiURL);
            HttpURLConnection userCon = (HttpURLConnection) userUrl.openConnection();
            userCon.setRequestMethod("GET");
            userCon.setRequestProperty("Authorization", "Bearer " + accessToken);

            int userResponseCode = userCon.getResponseCode();
            if (userResponseCode == 200) {
                BufferedReader userBr = new BufferedReader(new InputStreamReader(userCon.getInputStream()));
                StringBuilder userResponse = new StringBuilder();
                String userInputLine;
                while ((userInputLine = userBr.readLine()) != null) {
                    userResponse.append(userInputLine);
                }
                userBr.close();

                // 사용자 정보 파싱
                JSONObject userJson = new JSONObject(userResponse.toString());
                JSONObject responseObject = userJson.getJSONObject("response");
                String naverId = responseObject.getString("id");
                String naverName = responseObject.getString("name");
                String naverNickname = responseObject.getString("nickname");

                // m_member 테이블에 회원 정보 삽입
                M_MemberVO member = new M_MemberVO();
                member.setMEmail(naverId + "@naver.com");  // 카멜 케이스로 변경된 필드명에 맞춘 세터 호출
                member.setMNickname(naverNickname);         // 카멜 케이스로 변경된 필드명에 맞춘 세터 호출
                member.setMRegistrationType("naver");       // 카멜 케이스로 변경된 필드명에 맞춘 세터 호출

                int mIdx = mMemberDAO.insertM_Member(member);  // M_MemberDAO 사용하여 회원 정보 삽입

                if (mIdx > 0) {
                    // naver_login 테이블에 네이버 로그인 정보 삽입
                    NaverLoginVO vo = new NaverLoginVO();
                    vo.setNaverId(naverId);
                    vo.setMIdx(mIdx);
                    vo.setNaverName(naverName);
                    vo.setNaverNickname(naverNickname);

                    int result = naverLoginDAO.insertNaverLogin(vo);
                    return result > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

	@Override
	public NaverLoginVO getNaverLoginInfo(String naverId) {
		// TODO Auto-generated method stub
		return null;
	}
}