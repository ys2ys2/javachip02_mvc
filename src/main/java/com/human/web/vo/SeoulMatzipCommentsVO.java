package com.human.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


//행사 정보를 표현하는 Value Object 클래스

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SeoulMatzipCommentsVO {  
    private int t_smc_idx;               // 댓글 번호
    private String t_smc_content;        // 댓글 내용
    private int t_smc_author_id;         // 작성자 ID
    private Timestamp t_smc_created_at;  // 댓글 작성 시간
    private Timestamp t_smc_updated_at;  // 댓글 수정 시간
    private int t_sm_idx;                // 게시글 번호 (외래키)
}
