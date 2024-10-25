package com.human.web.vo;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

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
	    
	    
	    private int m_idx;
	
			

	    // 포맷팅된 날짜 반환 메서드 (한국 시간으로 변환)
	    public String getFormattedPostDate() {
	        if (postDate == null) return ""; // null 처리
	        
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        
	        // 한국 시간대(KST)로 변환 (LocalDateTime은 시간대 정보가 없기 때문에 현재 시간대를 한국으로 고정)
	        ZonedDateTime koreaTime = postDate.atZone(ZoneId.of("Asia/Seoul"));
	        
	        return koreaTime.format(formatter);
	    
		}      

}
