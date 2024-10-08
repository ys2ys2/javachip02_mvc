package com.human.web.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.sql.Timestamp;

@Data // Getter, Setter, toString, equals, hashCode 등을 자동으로 생성
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 포함하는 생성자 자동 생성
public class KakaoLoginVO {
    private Long kakao_id;             // 카카오에서 제공하는 고유 ID
    private int m_idx;                 // m_member 테이블의 idx를 외래키로 사용
    private String kakao_nickname;     // 카카오에서 제공하는 닉네임
    private Timestamp create_at;       // 가입 날짜
}
