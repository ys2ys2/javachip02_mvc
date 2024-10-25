package com.human.web.service;


import com.human.web.vo.M_MemberVO;

public interface GoogleService {
    M_MemberVO handleGoogleCallback(String code) throws Exception;

	M_MemberVO handleGoogleLoginCallback(String code) throws Exception;
}
