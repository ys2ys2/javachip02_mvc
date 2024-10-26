package com.human.web.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@NoArgsConstructor
public class DaejeonEventApiVO {
	  private Response response;

	  	@Data
	    @NoArgsConstructor
	    public static class Response {
	        private Header header;
	        private Body body;
	    }

	    @Data
	    @NoArgsConstructor
	    public static class Header {
	        private String resultCode;
	        private String resultMsg;
	    }

	    @Data
	    @NoArgsConstructor
	    public static class Body {
	        private String totalCount;
	        private List<Item> items;
	    }

	    @Data
	    @NoArgsConstructor
	    public static class Item {
	    	private int t_dae_idx; // 대전 축제 번호
	    	
	        private String festvNm;        // 축제 이름
	        private String festvSumm;      // 축제 요약
	        private String festvTpic;      // 축제 주제
	        private String festvPrid;      // 축제 기간
	        private String festvPlcNm;     // 축제 장소 이름
	        private String festvHostNm;    // 주최 기관 이름
	        private String svorgnNm;       // 주관 기관 이름 (필요 시 추가)
	        private String festvZip;       // 우편번호
	        private String festvAddr;      // 주소
	        private String festvDtlAddr;   // 상세 주소
	        private String refadNo;        // 참조 번호 (연락처)
	        private String hmpgAddr;       // 홈페이지 주소
	    }

		
	}
	
	

