package com.human.web.vo;

import lombok.Data;

@Data
public class TravelCommentVO {
    private int commentId;
    private int tpIdx;              // 여행기 ID
    private String commentWriter;
    private String commentContent;
    private String commentDate;
    private int m_idx; 
    private int commentWriterId; // 작성자 ID 추가
}
