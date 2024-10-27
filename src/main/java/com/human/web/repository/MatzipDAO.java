package com.human.web.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.MatzipVO;

@Repository
public class MatzipDAO {
    
    @Autowired
    private SqlSession sqlSession;
    private static final String MAPPER = "com.human.web.mapper.MatzipMapper";
    

	public void insertMatzip(MatzipVO restaurant) {
        sqlSession.insert(MAPPER + ".insertMatzip", restaurant);
		
	}
}
