package com.human.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.web.vo.SeoulEventApiVO;
import com.human.web.vo.SeoulEventApiVO.Row;

import lombok.AllArgsConstructor;

@Repository
@AllArgsConstructor
public class SeoulEventApiDAO {
	
	//매퍼 네임스페이스를 상수로 정의
	private static final String MAPPER="com.human.web.mapper.SeoulEventApiMapper";

	//MyBatis를 이용해서 DB 작업을 하는데 핵심적인 역할을 하는  SqlSession객체 의존 자동 주입: 생성자 방식
  	private SqlSession sqlSession;

 
    public List<Row> getAllEvents() {
        return sqlSession.selectList(MAPPER+".getAllEvents");
    }

  	public int insertSeoul(SeoulEventApiVO data) {
  		int result = 0; //입력 실패시 결과값
  		
  		Row[] rows = data.getCulturalEventInfo().getRow();
  		
  		int inputNum = sqlSession.insert(MAPPER+".insertSeoul", rows);
  		
  		System.out.println("입력된 데이터 개수: "+ inputNum);
  		
  		if(inputNum > 0) {
  			result = 1; //입력 성공시 결과값
  		}
  		
  		return result;
  	}

}

  
