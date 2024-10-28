package com.human.web.service;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.human.web.explorer.SeoulApiExplorer;
import com.human.web.repository.SeoulEventApiDAO;
import com.human.web.vo.SeoulEventApiVO;
import com.human.web.vo.SeoulEventApiVO.Row;

import lombok.AllArgsConstructor;


@Service
@AllArgsConstructor
public class SeoulEventApiServiceImpl implements SeoulEventApiService {

	 private SeoulEventApiDAO dao;


	  @Override
	    public List<Row> getAllEvents() {
	        return dao.getAllEvents();
	    }


	@Override
	public int insertSeoul() {
		int result = 0;//입력 실패시 결과값
		
		//ApiSeoulExplorer를 이용해서 공공데이터 가져오기
		
		//getApiJsonData()메소드 매개변수 세팅하기
		String serviceKey = "796275674f676d6c383351444e4c70";
		String srcUrl = "http://openapi.seoul.go.kr:8088/"+serviceKey+"/json/culturalEventInfo/1/500/";
		SeoulEventApiVO data = null;
		try {
			
			data = (SeoulEventApiVO) SeoulApiExplorer.getApiJsonData(srcUrl, new TypeReference<SeoulEventApiVO>() {});
			
		} catch (IOException | URISyntaxException e) {
			System.out.println("공공데이터 가져오기 중 예외발생");
			e.printStackTrace();
		} 
		
		return dao.insertSeoul(data);
	
	}



	    //@Override
//	    public int saveEvent(SeoulEventApiVO.Row row) {
//	        return seoulEventApiDAO.insertEvent(row);
//	    }
	}