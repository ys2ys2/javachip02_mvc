package com.human.web.service;

import java.util.List;
import java.util.Map;

import com.human.web.vo.TalkVO;

public interface TalkService {
    List<TalkVO> getTalkList(int offset, int limit);	// 댓글 리스트 가져오기
    
    int getTotalTalkCount();  // 전체 댓글 수 가져오기

    List<Map<String, String>> getItemList(int offset, int limit);

    int insertTalk(TalkVO talkVO);	// 댓글 삽입
    
    int deleteTalk(int talkIdx);	// 댓글 삭제
    
    int updateTalk(int talkIdx, String updatedText);	// 댓글 수정
    
    
    
    
}