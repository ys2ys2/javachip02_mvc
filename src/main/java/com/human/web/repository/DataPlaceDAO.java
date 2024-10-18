package com.human.web.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DataPlaceDAO {

	@Autowired
	private SqlSession sqlSession;
	private static final String MAPPER = "com.example.mapper.DataPlaceMapper";
	
	public List<Map<String, Object>> getRandomDataPlace(int limit) {
		return sqlSession.selectList(MAPPER + ".getRandomBannerPlace", limit);
	}

	public Map<String, Object> getDataplaceById(int contentid) {
		return sqlSession.selectOne(MAPPER + ".getDataplaceById", contentid);
	}

}
