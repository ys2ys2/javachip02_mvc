package com.human.web.vo;

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
}
