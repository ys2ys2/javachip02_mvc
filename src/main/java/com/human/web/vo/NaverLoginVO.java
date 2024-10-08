package com.human.web.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class NaverLoginVO {
    
    private String naverId;           // 네이버에서 제공하는 고유 ID
    private int mIdx;                 // m_member 테이블의 idx (외래 키로 사용)
    private String naverName;         // 네이버에서 제공하는 이름
    private String naverNickname;     // 네이버에서 제공하는 별명 (닉네임)
    private Timestamp createAt;       // 가입 날짜 (기본값: 현재 시간)

}
