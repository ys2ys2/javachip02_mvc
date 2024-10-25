package com.human.web.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TravelMediaVO {
    private int media_id;           // 첨부파일 ID (기본키)
    private int tp_idx;             // 여행기 ID (외래키)
    private String origin_filename; // 원본 파일명
    private String save_filename;   // 서버에 저장된 파일명
    private String file_type;       // 파일 유형 (예: image, video)
    private long file_size;         // 파일 크기 (바이트 단위)
    private String upload_date;     // 업로드 일자
}
