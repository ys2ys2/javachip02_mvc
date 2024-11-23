package com.human.web.repository;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.human.web.vo.TripScheduleVO;

@Repository
public class TripScheduleDAO {

    @Autowired
    private SqlSession sqlSession;
    private static final String MAPPER = "com.human.web.mapper.TripScheduleMapper";

    // 여행 일정 추가
    public void insertTripSchedule(TripScheduleVO tripSchedVO) {
        sqlSession.insert(MAPPER + ".insertTripSchedule", tripSchedVO);
    }
    
    // 최대 Post ID 가져오기
    public Integer getMaxPostId() {
        return sqlSession.selectOne(MAPPER + ".getMaxPostId");
    }

    // 여행 일정 리스트 조회
    public List<TripScheduleVO> getTripScheduleList() {
        return sqlSession.selectList(MAPPER + ".getTripScheduleList");
    }

    // 여행 일정 여러 개 조회 (postId 기준)
    public List<TripScheduleVO> getTripSchedulesById(int postId) {
        return sqlSession.selectList(MAPPER + ".getTripSchedulesById", postId);
    }
}
