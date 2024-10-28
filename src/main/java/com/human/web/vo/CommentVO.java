package com.human.web.vo;

import lombok.Data;

@Data
public class CommentVO {
    private int commentId;
    private int postId;
    private int m_idx;                 // 댓글 작성자의 회원 ID
    private String commentNickname;     // 댓글 작성자의 닉네임
    private String commentContent;
    private String commentDate;         // 날짜가 문자열로 저장될 경우
    private String commentWriter; 
    
}
