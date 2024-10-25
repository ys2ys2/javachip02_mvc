package com.human.web.vo;

import java.util.List;

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
    private String thumbnailUrl; // 썸네일 URL 필드 추가
    
    private List<ScheduleVO> scheduleList;
}