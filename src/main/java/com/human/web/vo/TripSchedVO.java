package com.human.web.vo;

import lombok.Data;

@Data
public class TripSchedVO {
    private int id;
    private int m_idx;
    private String m_email;
    private String m_nickname;
    private String period_start;
    private String period_end;
    private String title;
    private int post_id;

    //여러 장소(배열)
    private int[] dayNumbers;
    private String[] cityNames;
    private int[] labelNumbers;
    private String[] placeNames;
    private String[] placeAddresses;
    private double[] placeLatitudes; 
    private double[] placeLongitudes; 


    private int day_number;     // 단일 DAY
    private String city_name;   // 단일 도시 이름
    private int label_number;   // 단일 라벨 번호
    private String place_name;  // 단일 장소 이름
    private String place_address; // 단일 주소
    private String thumbnail;   // 썸네일 이미지 URL 추가
    private double place_latitude;  // 단일 장소 위도
    private double place_longitude; // 단일 장소 경도
    
		
	}