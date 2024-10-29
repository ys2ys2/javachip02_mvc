package com.human.web.vo;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class PostVO {
    private int id;                  // 게시글 ID
    private int m_idx;               // 작성자 ID (회원 ID)
    private String content;          // 게시글 내용
    private String postDate; // 문자열로 저장  // 작성 날짜
    private int commentCount;        // 댓글 수
    private int likeCount;           // 좋아요 수
    private boolean isLiked;         // 좋아요 여부
    private String post_writer;		 // 글 작성자
   
    // 기본 생성자
    public PostVO() {
        // 한국 표준시 (KST)로 포맷된 날짜 설정
        this.postDate = ZonedDateTime.now(ZoneId.of("Asia/Seoul"))
                          .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
    	
}
