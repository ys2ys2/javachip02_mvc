package com.human.web.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.TravelDAO;
import com.human.web.vo.TravelVO;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class TravelServiceImpl implements TravelService {
	private final TravelDAO travelDAO;

	 @Override
	    public List<TravelVO> getTravelListByMidx(Integer m_idx) {
	        System.out.println("TravelServiceImpl - getTravelListByMidx 호출됨: m_idx = " + m_idx);
	        
	        // DAO를 통해 m_idx에 해당하는 게시글 목록 조회
	        List<TravelVO> travelList = travelDAO.getTravelListByMidx(m_idx);
	        
	        if (travelList == null || travelList.isEmpty()) {
	            System.out.println("조회된 게시글이 없습니다: m_idx = " + m_idx);
	        } else {
	            System.out.println("조회된 게시글 목록:");
	            travelList.forEach(post -> System.out.println("Title: " + post.getTitle() + ", Image: " + post.getSaveFilename()));
	        }

	        return travelList;
	    }
	    
}
