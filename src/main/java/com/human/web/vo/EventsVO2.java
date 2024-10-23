package com.human.web.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class EventsVO {
    private int t_idx; // 행사번호 (기본키)
    private int t_author_id; // 작성자 ID
    private String t_title; // 행사 제목
    private String t_content; // 게시글 내용
    private String t_location; // 행사 위치
    private Date t_created_at; // 게시글 저장 시간
    private Date t_updated_at; // 게시글 수정 시간
    private int m_idx; //회원 번호
}
