package com.human.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data  // 게터, 세터, toString, equals, hashCode 등을 자동으로 생성
@NoArgsConstructor  // 기본 생성자 생성
@AllArgsConstructor  // 모든 필드를 매개변수로 받는 생성자 생성
public class GoogleVO {

    private String googleId;      // 구글에서 제공하는 고유 ID (google_id)
    private int mIdx;             // m_member 테이블의 외래키 (m_idx)
    private String googleName;
    private Timestamp createAt;   // 가입 날짜 (create_at)
}
