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

    // 댓글 리스트를 가져오는 메서드
    @Override
    public List<TalkVO> getTalkList(int offset, int limit) {
        // 페이지네이션을 위한 offset과 limit 값을 Map에 담아 DAO로 전달
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        return talkDAO.getTalkList(params); // DAO를 통해 댓글 리스트 가져옴
    }

    // 전체 댓글 수를 가져오는 메서드
    @Override
    public int getTotalTalkCount() {
        return talkDAO.getTotalTalkCount(); // DAO를 통해 전체 댓글 수 조회
    }

    // 댓글을 삽입하는 메서드
    @Override
    public int insertTalk(TalkVO talkVO) {
        return talkDAO.insertTalk(talkVO); // DAO를 통해 댓글 삽입
    }

    // 댓글을 삭제하는 메서드
    @Override
    public int deleteTalk(int talkIdx) {
        return talkDAO.deleteTalk(talkIdx); // DAO를 통해 댓글 삭제
    }

    // 댓글을 수정하는 메서드
    @Override
    public int updateTalk(int talkIdx, String updatedText) {
        // 댓글 수정에 필요한 파라미터들을 Map에 담아 전달
        Map<String, Object> params = new HashMap<>();
        params.put("talkIdx", talkIdx);
        params.put("updatedText", updatedText);
        return talkDAO.updateTalk(params); // DAO를 통해 댓글 수정
    }

    // 핫플레이스 아이템 리스트를 가져오는 메서드
    @Override
    public List<Map<String, String>> getItemList(int offset, int limit) {
        return talkDAO.getItemList(offset, limit); // DAO를 통해 핫플레이스 리스트 가져옴
    }
    
    
}
