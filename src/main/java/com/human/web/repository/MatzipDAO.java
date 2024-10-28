package com.human.web.repository;

import java.util.List;

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


    // DB에서 맛집 목록을 가져오는 메서드
	public List<MatzipVO> getMatzipList() {
        List<MatzipVO> list = sqlSession.selectList(MAPPER + ".getMatzipList");
        System.out.println("Fetched matzipList: " + list); // 데이터 확인용 로그
        return list;
    }


	//contentid로 맛집 가져오기
	public MatzipVO getMatzipDetailById(int contentid) {
        return sqlSession.selectOne(MAPPER + ".getMatzipDetailById", contentid);
	}
}
