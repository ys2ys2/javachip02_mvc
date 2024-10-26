package com.human.web.service;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.human.web.explorer.DaejeonMatzipApiExplorer;
import com.human.web.repository.DaejeonMatzipApiDAO;
import com.human.web.vo.DaejeonMatzipApiVO;

import lombok.AllArgsConstructor;


@Service
@AllArgsConstructor
public class DaejeonMatzipApiServiceImpl implements DaejeonMatzipApiService {

	 private DaejeonMatzipApiDAO dao;
	 
	 

	@Override
	public int insertDaejeonMatzip() {
		int result = 0;//입력 실패시 결과값
	
		//ApiSeoulExplorer를 이용해서 공공데이터 가져오기
		DaejeonMatzipApiVO data = null;
		
		try {
			//getApiJsonData()메소드 매개변수 세팅하기
			String serviceKey = "KQVlTiVYcVTyk%2BlF3J%2F8MGHUfOlyH0hDW6voB8r9oeDO8mkUIORdDB6Tfjc51cbqIQZ1a4cfGh9Uous1T7t2ow%3D%3D";
			String srcUrl = "https://api.odcloud.kr/api/15073964/v1/uddi:167da00d-5619-4cac-93ba-b3cb9fd1a49a";
			
		    data = DaejeonMatzipApiExplorer.getApiJsonData(srcUrl, serviceKey, new TypeReference<DaejeonMatzipApiVO>() {});

		} catch (IOException | URISyntaxException e) {
		    System.out.println("공공데이터 가져오기 중 예외 발생: " + e.getMessage());
		    e.printStackTrace();

        }
		
		   // 공공데이터가 성공적으로 수신되었는지 확인
        if (data != null) {
            // DAO를 통해 데이터베이스에 삽입
            int inputNum = dao.insertDeajeon(data); // DAO에서 데이터 삽입 로직 실행

            if (inputNum > 0) {
                result = 1; // 삽입 성공 시 1로 설정
            }
        }
		
		  return result; // 삽입 결과 반환
	}
		  
   // getAllDaejeonEvent 메서드 추가
    @Override
    public List<DaejeonMatzipApiVO.Damat> getAllDaejeonMatzip() {
        // DAO를 통해 모든 대전 행사 데이터를 가져옴
        return dao.getAllDaejeonMatzip();
	
	}

	


	}