package com.human.web.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.DataPlaceDAO;

@Service
public class DataPlaceServiceImpl implements DataPlaceService {
	
	@Autowired
	private DataPlaceDAO dataPlaceDAO;

	@Override
	public List<Map<String, Object>> getRandomDataPlace(int limit) {
		//DB에서 랜덤 배너 데이터 가져오기
		List<Map<String, Object>> dataPlaces = dataPlaceDAO.getRandomDataPlace(limit);
		
		//firstimage에서 첫 번째 이미지 URL만 가져오기
		return dataPlaces.stream().map(dataPlace -> {
			String firstimage = (String) dataPlace.get("firstimage");
			if (firstimage != null && firstimage.contains(",")) {
				//쉼표 자르기
				firstimage = firstimage.split(",")[0].trim();
			}
			dataPlace.put("firstimage", firstimage);
			return dataPlace;
		}).collect(Collectors.toList());
	}
	
	//contetid로 dataplace 가져오기
	@Override
	public Map<String, Object> getDataplaceById(int contentid) {
		
		return dataPlaceDAO.getDataplaceById(contentid);
	}

		

}
