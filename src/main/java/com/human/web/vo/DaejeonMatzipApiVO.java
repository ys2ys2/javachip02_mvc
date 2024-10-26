package com.human.web.vo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@NoArgsConstructor
public class DaejeonMatzipApiVO {
		
      private int page;           // 현재 페이지
      private int perPage;        // 페이지당 데이터 수
      private int totalCount;     // 전체 데이터 수
      private int currentCount;   // 현재 데이터 수
      private int matchCount;     // 일치하는 데이터 수
      private List<Damat> data; // 음식점 데이터 리스트

       @Data
       @NoArgsConstructor
        public static class Damat {
        private int t_dm_idx; // 대전 맛집 번호	
        private String 구분;     // 구분
        private String 상호;         // 상호
        @JsonProperty("소재지(도로명 주소)")
        private String 소재지;      // 소재지(도로명 주소)
        private String 메뉴;         // 메뉴
        private String 전화번호;  // 전화번호
        private String 비고;        // 비고
    }
}
	
	  

