package com.human.web.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.TalkVO;

@Repository
public class TalkDAO {

    @Autowired
    private SqlSession sqlSession;
    private static final String MAPPER = "com.human.web.mapper.TalkMapper";

    // 댓글 리스트 가져오기
    public List<TalkVO> getTalkList(Map<String, Object> params) {
        return sqlSession.selectList(MAPPER + ".getTalkList", params);
    }

    // 댓글 총 개수 가져오기
    public int getTotalTalkCount() {
        return sqlSession.selectOne(MAPPER + ".getTotalTalkCount");
    }

    // 댓글 입력
    public int insertTalk(TalkVO vo) {
        return sqlSession.insert(MAPPER + ".insertTalk", vo);
    }

    // 댓글 삭제
    public int deleteTalk(int talkIdx) {
        return sqlSession.delete(MAPPER + ".deleteTalk", talkIdx);
    }

    // 댓글 수정
    public int updateTalk(Map<String, Object> params) {
        return sqlSession.update(MAPPER + ".updateTalk", params);
    }
    
    // 핫플레이스 아이템 리스트 가져오기 (매개변수 있는 버전)
    public List<Map<String, String>> getItemList(int offset, int limit) {
        Map<String, Integer> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList(MAPPER + ".getItemListWithPagination", params);
    }




}
