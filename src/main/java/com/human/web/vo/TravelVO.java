package com.human.web.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TravelVO {
    private String title;
    
    private String saveFilename;
 // tb_travel_media 테이블 관련 필드
    private String originFilename;   // 원본 파일명
    private String fileType;         // 파일 유형
    private Long fileSize;           // 파일 크기

    
    
    // 외부 이미지 URL을 반환하는 메서드
    public String getImageUrl() {
        return "http://localhost:9090/resources/uploads/" + saveFilename;
    }
}
