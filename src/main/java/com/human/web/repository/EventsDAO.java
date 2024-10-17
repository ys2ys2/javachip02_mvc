package com.human.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.web.vo.EventsCommetsVO;

import lombok.AllArgsConstructor;

@Repository
@AllArgsConstructor
public class EventsDAO {

    private SqlSession sqlSession;

    private static final String MAPPER = "com.yourpackage.mapper.EventsCommentsMapper";

    public int insertComment(EventsCommetsVO commentVO) {
        return sqlSession.insert(MAPPER + ".insertComment", commentVO);
    }

    public List<EventsCommetsVO> getAllComments() {
        return sqlSession.selectList(MAPPER + ".getAllComments");
    }
}
