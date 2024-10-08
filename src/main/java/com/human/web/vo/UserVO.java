package com.human.web.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data  //카카오 로그인 시 받아올 사용자 정보(예: 이메일, 닉네임 등)를 정의
@NoArgsConstructor  // 기본 생성자 자동 생성
@AllArgsConstructor  // 모든 필드를 포함한 생성자 자동 생성
public class UserVO {
    private Long kakaoId;  // 카카오에서 제공하는 고유 ID
    private Long mIdx;  // Member 테이블의 idx (외래키)
    private String kakaoNickname;  // 카카오에서 제공하는 닉네임
    private String createAt;  // 가입 날짜
}

