package com.human.web.service;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.human.web.explorer.SeoulMatzipApiExplorer;
import com.human.web.repository.SeoulMatzipApiDAO;
import com.human.web.vo.SeoulMatzipApiVO;

import lombok.AllArgsConstructor;


@Service
@AllArgsConstructor
public class SeoulMatzipApiServiceImpl implements SeoulMatzipApiService {

	 private SeoulMatzipApiDAO dao;


	  @Override
	    public List<SeoulMatzipApiVO.Row> getAllSeoulMatzip() {
	        return dao.getAllSeoulMatzip();
	    }


	@Override
	public int insertSeoul() {
		int result = 0;//입력 실패시 결과값
		
		//ApiSeoulExplorer를 이용해서 공공데이터 가져오기
		
		//getApiJsonData()메소드 매개변수 세팅하기
		String serviceKey = "796275674f676d6c383351444e4c70";
		String srcUrl = "http://openapi.seoul.go.kr:8088/"+serviceKey+"/json/SebcJungguTourKkor/1/200/";
		SeoulMatzipApiVO data = null;
		try {
			
			data = (SeoulMatzipApiVO) SeoulMatzipApiExplorer.getApiJsonData(srcUrl, new TypeReference<SeoulMatzipApiVO>() {});
			
		} catch (IOException | URISyntaxException e) {
			System.out.println("공공데이터 가져오기 중 예외발생");
			e.printStackTrace();
		} 
		
		return dao.insertSeoul(data);
	
	}




	}