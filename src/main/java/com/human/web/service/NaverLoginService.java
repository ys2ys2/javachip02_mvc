package com.human.web.service;

import com.human.web.vo.NaverLoginVO;

public interface NaverLoginService {

    boolean processNaverLogin(String code, String state);

    NaverLoginVO getNaverLoginInfo(String naverId); // 사용자 정보 조회 메서드
}
