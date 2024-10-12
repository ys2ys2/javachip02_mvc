package com.human.web.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HotPlaceDAO {

    @Autowired
    private SqlSession sqlSession;
    private static final String MAPPER = "com.human.web.mapper.HotPlaceMapper";
    
    // 테이블에 데이터 삽입
    public int insertHotPlace(String contentId, String title, String addr1, String overview,
                              double mapx, double mapy, String firstimage, String areacode) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("contentId", contentId);
        paramMap.put("title", title);
        paramMap.put("addr1", addr1);
        paramMap.put("overview", overview);
        paramMap.put("mapx", mapx);
        paramMap.put("mapy", mapy);
        paramMap.put("firstimage", firstimage);
        paramMap.put("areacode", areacode);

        try {
            // MyBatis Mapper 호출하여 데이터 삽입
            return sqlSession.insert(MAPPER + ".insertHotPlace", paramMap);

        } catch (Exception e) {
            System.out.println("DB 삽입 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }
}
