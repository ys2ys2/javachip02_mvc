package com.human.web.service;

import com.human.web.vo.NaverLoginVO;

public interface OAuth2LoginService {
    NaverLoginVO getNaverUserInfo(String accessToken);

	String getAccessToken(String code);
}
