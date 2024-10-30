package com.human.web.vo;

import lombok.Data;

@Data
public class TripScheduleVO {
    private int id;
    private int m_idx;
    private String m_email;
    private String m_nickname;
    private String period_start;
    private String period_end;
    private String title;
    private int post_id;

    private int[] dayNumbers;
    private String[] cityNames;
    private int[] labelNumbers;
    private String[] placeNames;
    private String[] placeAddresses;
    private double[] placeLatitudes;
    private double[] placeLongitudes;

    private int day_number;
    private String city_name;
    private int label_number;
    private String place_name;
    private String place_address;
    private double place_latitude;
    private double place_longitude;
    private String thumbnail;

    // 각 일정의 날짜를 저장하기 위한 필드
    private String dayDate;
}
