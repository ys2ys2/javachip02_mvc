package com.human.web.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class M_MemberVO {

	private int m_idx; // 회원 번호
	private String m_email; // 이메일
	private String m_password; // 비밀번호
	private String m_nickname; // 닉네임
	private String m_status = "active"; // 사용자 상태
	private String m_registration_type; // 가입 방식
	private String m_profile;
}
