package com.human.web.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MypageVO {
	  	private String addr1;        // 주소
	    private String firstimage;   // 첫 번째 이미지 URL
	    private String title;        // 장소 제목
	    private int likes;           // 좋아요 수
        
	    // 조인된 post 테이블의 컬럼 추가
	    private String postWriter;      // 게시글 작성자
	    private String postContent;     // 게시글 내용
	    private LocalDateTime postDate; // 게시글 작성 날짜
	    private int likeCount;          // 게시글 좋아요 수
	    private int commentCount;       // 게시글 댓글 수
	    
	    // 추가된 필드
	    private int m_idx;
	
			
		}      


