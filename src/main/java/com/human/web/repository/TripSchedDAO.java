package com.human.web.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.TripSchedVO;

@Repository
public class TripSchedDAO {
	
    @Autowired
    private SqlSession sqlSession;
    private static final String MAPPER = "com.human.web.mapper.TripSchedMapper";

    public void insertTripSchedule(TripSchedVO tripSchedVO) {
        sqlSession.insert(MAPPER + ".insertTripSchedule", tripSchedVO);
    }
}
