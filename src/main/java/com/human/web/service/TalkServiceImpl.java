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
    public List<TalkVO> getTalkList(int contentid, String type, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("contentid", contentid);
        params.put("type", type); 
        params.put("offset", offset);
        params.put("limit", limit);
        return talkDAO.getTalkList(params);
    }


    // 전체 댓글 수 (type 필드 추가)
    @Override
    public int getTotalTalkCount(int contentid, String type) {
        Map<String, Object> params = new HashMap<>();
        params.put("contentid", contentid);
        params.put("type", type);  // type을 함께 전달
        return talkDAO.getTotalTalkCount(params);
    }

    // 댓글 삽입
    @Override
    public int insertTalk(TalkVO talkVO) {
        return talkDAO.insertTalk(talkVO);  // talkVO 객체에 이미 type 필드가 있음
    }

    // 댓글 삭제
    @Override
    public int deleteTalk(int talkIdx) {
        return talkDAO.deleteTalk(talkIdx);
    }

    // 댓글 수정
    @Override
    public int updateTalk(int talkIdx, String updatedText) {
    	return talkDAO.updateTalk(talkIdx, updatedText);
    }

    // 핫플레이스 아이템 리스트
    @Override
    public List<Map<String, String>> getItemList(int offset, int limit) {
        return talkDAO.getItemList(offset, limit);
    }

    
    
}
