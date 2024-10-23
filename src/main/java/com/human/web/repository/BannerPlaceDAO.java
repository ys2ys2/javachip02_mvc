package com.human.web.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BannerPlaceDAO {

    @Autowired
    private SqlSession sqlSession;
    private static final String MAPPER = "com.example.mapper.BannerPlaceMapper";

    // 랜덤으로 가져오기
    public List<Map<String, Object>> getRandomBannerPlace(int limit) {
        return sqlSession.selectList(MAPPER + ".getRandomBannerPlace", limit);
    }

    // contentid에 해당하는 장소 가져오기
    public Map<String, Object> getBannerById(int contentid) {
        return sqlSession.selectOne(MAPPER + ".getBannerById", contentid);
    }

    // areacode로 지역여행지 가져오기
    public List<Map<String, Object>> getBannersByAreaCode(String areacode) {
        System.out.println("DAO에서 받은 areacode: " + areacode);
        return sqlSession.selectList(MAPPER + ".getBannerByAreaCode", areacode);
    }

}
