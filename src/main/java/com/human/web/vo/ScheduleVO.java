package com.human.web.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor // 기본 생성자 추가
public class ScheduleVO {
    private int s_idx;
    private int post_id;
    private int day_number;
    private String city_name;
    private int label_number;
    private String place_name;
    private String place_address;

    // 모든 필드를 포함한 생성자 추가
    public ScheduleVO(int s_idx, int post_id, int day_number, String city_name, int label_number, String place_name, String place_address) {
        this.s_idx = s_idx;
        this.post_id = post_id;
        this.day_number = day_number;
        this.city_name = city_name;
        this.label_number = label_number;
        this.place_name = place_name;
        this.place_address = place_address;
    }
}
