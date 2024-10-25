package com.human.web.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TravelTagVO {
    private int tag_id;           // 태그 번호 (기본키)
    private int tp_idx;           // 여행기 번호 (외래키)
    private String tag_name;      // 태그명
}
