package com.human.web.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.NoArgsConstructor;


//서울 데이터 가져오는 방법! 대문자는 다 대문자로 가져오기 !
@Data
@NoArgsConstructor
public class SeoulEventApiVO {
	private CulturalEventInfo culturalEventInfo;
	
	@Data
	@NoArgsConstructor
	public static class CulturalEventInfo{
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
		private int t_idx; //서울 축제 번호
		
		@JsonProperty("CODENAME")
        private String CODENAME;
		@JsonProperty("GUNAME")
        private String GUNAME;
		@JsonProperty("TITLE")
        private String TITLE;
		@JsonProperty("DATE")
        private String DATE;
		@JsonProperty("PLACE")
        private String PLACE;
		@JsonProperty("ORG_NAME")
        private String ORG_NAME;
		@JsonProperty("USE_TRGT")
        private String USE_TRGT;
		@JsonProperty("USE_FEE")
        private String USE_FEE;
		@JsonProperty("PLAYER")
        private String PLAYER;
		@JsonProperty("PROGRAM")
        private String PROGRAM;
		@JsonProperty("ETC_DESC")
        private String ETC_DESC;
		@JsonProperty("ORG_LINK")
        private String ORG_LINK;
		@JsonProperty("MAIN_IMG")
        private String MAIN_IMG;
		@JsonProperty("RGSTDATE")
        private String RGSTDATE;
		@JsonProperty("TICKET")
        private String TICKET;
		@JsonProperty("STRTDATE")
        private String STRTDATE;
		@JsonProperty("END_DATE")
        private String END_DATE;
		@JsonProperty("THEMECODE")
        private String THEMECODE;
		@JsonProperty("LOT")
        private String LOT;
		@JsonProperty("LAT")
        private String LAT;
		@JsonProperty("IS_FREE")
        private String IS_FREE;
		@JsonProperty("HMPG_ADDR")
        private String HMPG_ADDR;
	}

}
	
	
	

