package com.human.web.service;

import javax.servlet.http.HttpSession;

import com.human.web.vo.NaverLoginVO;

public interface NaverLoginService {


    NaverLoginVO getNaverLoginInfo(String naverId); // 사용자 정보 조회 메서드

	boolean processNaverLogin(String code, String state, HttpSession session);
}
