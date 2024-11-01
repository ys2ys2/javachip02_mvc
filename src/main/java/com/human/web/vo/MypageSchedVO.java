package com.human.web.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MypageSchedVO {
	 	private Date period_start;    // 여행 시작 날짜
	    private Date period_end;      // 여행 끝 날짜
	    private String t_title;       // 여행기 제목
	    private String city_name;     // 도시 이름
	    private String place_name;    // 여행 장소
	    private String place_address; // 여행 장소 주소
	    private int m_idx;  
	    
	    //남은 일수 필드 추가
	    private String daysRemaining;
	    
	    
	    
}
