package com.human.web.service;

import java.util.List;
import java.util.Map;

import com.human.web.vo.TalkVO;

public interface TalkService {
    
	//댓글 리스트
	List<TalkVO> getTalkList(int contentid, String type, int offset, int limit); 
    
	//총 댓글 리스트
    int getTotalTalkCount(int contentid, String type);  

    //item list
    List<Map<String, String>> getItemList(int offset, int limit);

    int insertTalk(TalkVO talkVO);	// 댓글 삽입
    
    int deleteTalk(int talkIdx);	// 댓글 삭제
    
    int updateTalk(int talkIdx, String updatedText);	// 댓글 수정
    
    
    
    
}
