package com.human.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.TravelPostDAO;

@Service
public class TravelPostServiceImpl implements TravelPostService {
	
	@Autowired
	private TravelPostDAO travelPostDAO; // 의존성 주입을 통해 DAO를 사용

	//랜덤 travelPost
	@Override
	public List<Map<String, Object>> getRandomTravelPost(int limit) {
		//DB에서 랜덤으로 여러 필드 가져오기
		return travelPostDAO.getRandomTravelPost(limit);
	}

}
