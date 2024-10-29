package com.human.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.TravelVO;

import lombok.RequiredArgsConstructor;


@Repository // 이 클래스가 DAO 역할을 한다는 것을 스프링에 알림
@RequiredArgsConstructor
public class TravelDAO {
	
	
	private final SqlSession sqlSession;

    private static final String MAPPER = "com.human.web.mapper.TravelMapper";

    public List<TravelVO> getTravelListByMidx(Integer m_idx) {
        System.out.println("TravelDAO - getTravelListByMidx 호출됨: m_idx = " + m_idx);
        
        // MyBatis를 통해 m_idx에 해당하는 게시글 목록을 조회
        List<TravelVO> travelList = sqlSession.selectList(MAPPER + ".getTravelListByMidx", m_idx);
        
        if (travelList == null || travelList.isEmpty()) {
            System.out.println("조회된 게시글이 없습니다: m_idx = " + m_idx);
        } else {
            System.out.println("조회된 게시글 목록:");
            travelList.forEach(post -> System.out.println("Title: " + post.getTitle() + ", Image: " + post.getSaveFilename()));
        }

        return travelList;
    }
    }