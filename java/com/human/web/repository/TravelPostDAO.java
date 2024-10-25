package com.human.web.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TravelPostDAO {

	@Autowired
    private SqlSession sqlSession;
	private static final String MAPPER = "com.human.web.mapper.TravelPostMapper";
	
	
	public List<Map<String, Object>> getRandomTravelPost(int limit) {
		return sqlSession.selectList(MAPPER + ".getRandomTravelPost", limit);
	}
	
	

	
}
