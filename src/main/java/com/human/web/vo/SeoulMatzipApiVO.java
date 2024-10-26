package com.human.web.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.NoArgsConstructor;


//서울 데이터 가져오는 방법! 대문자는 다 대문자로 가져오기 !
@Data
@NoArgsConstructor
public class SeoulMatzipApiVO {
	@JsonProperty("SebcJungguTourKkor")
	private SebcJungguTourKkor SebcJungguTourKkor;
	
	@Data
	@NoArgsConstructor
	public static class SebcJungguTourKkor{
		private int list_total_count; //기본타입 값을 가지는 필드
		@JsonProperty("RESULT")
		private RESULT RESULT;
		private Row[] row;
	}
	
	@Data
	@NoArgsConstructor
	public static class RESULT{
		@JsonProperty("CODE")
		private String CODE;
		@JsonProperty("MESSAGE")
		private String MESSAGE;
	}
	
	//서울 공공데이터는 다 롬북 적용 해야함
	@Data
	@NoArgsConstructor
	public static class Row{
		private int t_sm_idx; //서울 맛집 번호
		
		@JsonProperty("MAIN_KEY")
        private String MAIN_KEY;
		@JsonProperty("CATE1_NAME")
        private String CATE1_NAME;
		@JsonProperty("NAME_KOR")
		private String NAME_KOR;
		@JsonProperty("ADD_KOR_ROAD")
		private String ADD_KOR_ROAD;
		@JsonProperty("RES_CONTACT")
        private String RES_CONTACT;
		@JsonProperty("CN_SITE")
        private String CN_SITE;
		@JsonProperty("CATE2_NAME")
        private String CATE2_NAME;
		@JsonProperty("CATE3_NAME")
        private String CATE3_NAME;


	}

	


}
	
	
	

