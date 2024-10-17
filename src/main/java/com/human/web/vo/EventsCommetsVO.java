package com.human.web.vo;

import java.sql.Timestamp;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


//행사 정보를 표현하는 Value Object 클래스

@Data
@NoArgsConstructor
@AllArgsConstructor

public class EventsCommetsVO {  // 댓글 및 게시글
	    private int t_ec_idx; // 행사 댓글 번호 (기본키, 자동 증가)
	    private String t_comment_content; // 댓글 내용
	    private int t_comment_author_id; // 댓글 작성자 ID
	    private Timestamp t_comment_created_at; // 댓글 작성 시간
	    private Timestamp t_comment_updated_at; // 댓글 수정 시간
	    private int t_comment_likes; // 댓글 좋아요 수
	    private int t_idx; // 행사번호 (외래키)

}