package com.human.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.web.vo.DaejeonEventApiVO;
import com.human.web.vo.DaejeonEventApiVO.Item;

import lombok.AllArgsConstructor;

@Repository
@AllArgsConstructor
public class DaejeonEventApiDAO {
	
	//매퍼 네임스페이스를 상수로 정의
	private static final String MAPPER = "com.human.web.mapper.DaejeonEventApiMapper";
	
    private final SqlSession sqlSession;

    // 모든 대전 행사 가져오기 (DB에서)
    public List<DaejeonEventApiVO.Item> getAllDaejeonEvents() {
     return sqlSession.selectList(MAPPER + ".getAllDaejeonEvents");
    }
    
    
    // 공공데이터를 DB에 삽입하는 메서드
	  public int insertSeoul(DaejeonEventApiVO data) {
		  int result = 0;  // 기본적으로 삽입 실패로 간주
		  
		  List<Item> items = data.getResponse().getBody().getItems();
	      int inputNum = sqlSession.insert(MAPPER + ".insertDaejeonEvent", items);  // 삽입된 레코드 개수를 저장

	        System.out.println("입력된 데이터 개수: " + inputNum);  // 삽입된 데이터 개수 출력

	        if (inputNum > 0) {
	            result = 1;  // 삽입이 성공하면 결과값을 1로 변경
	        }

	        return result;  // 최종적으로 결과값 반환 (1: 성공, 0: 실패)
	  }
	}