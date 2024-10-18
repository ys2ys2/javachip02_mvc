package com.human.web.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DataPlaceServiceImpl implements DataPlaceService {
	
	@Autowired
	private DataPlaceDAO dataPlaceDAO;

	@Override
	public Map<String, Object> getDataplaceById(int contentid) {
		// TODO Auto-generated method stub
		return null;
	}

}
