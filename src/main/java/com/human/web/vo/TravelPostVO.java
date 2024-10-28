package com.human.web.vo;

import java.util.Date;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TravelPostVO {
    private int tp_idx; // 여행기 번호(기본키)
    private String title; // 제목
    private String content; // 내용
    private String topic; // 여행기 토픽
    private int read_cnt; // 조회수
    private Date post_date; // 등록일
    private Date update_date; // 수정일
    private String tp_status; // 상태 (N:삭제요청 없음, Y:삭제요청함)
    private int m_idx; // 작성자 회원번호(외래키)
    private String writer; // 작성자 닉네임 (m_nickname)
    private int likeCount; // 좋아요 개수
    private boolean liked; // 사용자가 좋아요를 눌렀는지 여부
    private int commentCount; // 댓글 수
    private String tag_name; // 태그명
   
    
    private MultipartFile[] uploadFiles; // 첨부 파일
    private List<TravelMediaVO> attachedList; // 첨부파일 리스트
    private List<String> tags; // 태그 리스트
    private List<TravelMediaVO> mediaList; // 첨부파일 리스트
}
