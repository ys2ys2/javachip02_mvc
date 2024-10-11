package com.human.web.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.TalkDAO;
import com.human.web.vo.TalkVO;

@Service
public class TalkServiceImpl implements TalkService {

    @Autowired
    private TalkDAO talkDAO;

    // 댓글 리스트
    @Override
    public List<TalkVO> getTalkList(int offset, int limit) {
        // 페이지네이션을 위한 offset과 limit 값을 Map에 담아 DAO로 전달
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        return talkDAO.getTalkList(params); 
    }

    // 전체 댓글 수
    @Override
    public int getTotalTalkCount() {
        return talkDAO.getTotalTalkCount();
    }

    // 댓글 삽입
    @Override
    public int insertTalk(TalkVO talkVO) {
        return talkDAO.insertTalk(talkVO);
    }

    // 댓글 삭제
    @Override
    public int deleteTalk(int talkIdx) {
        return talkDAO.deleteTalk(talkIdx);
    }

    // 댓글 수정
    @Override
    public int updateTalk(int talkIdx, String updatedText) {
        System.out.println("Updating comment with ID: " + talkIdx + " to text: " + updatedText);
    	return talkDAO.updateTalk(talkIdx, updatedText);
    }

    // 핫플레이스 아이템 리스트
    @Override
    public List<Map<String, String>> getItemList(int offset, int limit) {
        return talkDAO.getItemList(offset, limit);
    }
    
    
    
}
