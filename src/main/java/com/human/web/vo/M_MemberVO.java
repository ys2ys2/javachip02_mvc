package com.human.web.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@AllArgsConstructor
@NoArgsConstructor
public class M_MemberVO {
    
    private int mIdx;                 // 회원 번호
    private String mEmail;            // 이메일
    private String mPassword;         // 비밀번호
    private String mNickname;         // 닉네임
    private String mStatus = "active"; // 사용자 상태
    private String mRegistrationType; // 가입 방식
}