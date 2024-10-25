package com.human.web.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TalkVO {
    private int talkIdx; // 회원번호
    private String talkNickname; // 닉네임
    private String talkEmail; // 회원ID
    private String talkText; // 본문 내용
    private String talkProfile; // 프로필 이미지 URL
    private Date talkCreatedAt; // 작성일자
    private Date talkUpdatedAt; // 수정일자
    private int contentid; // 전달받을 contentid
    private String type; // type 추가
}