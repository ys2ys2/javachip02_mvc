package com.human.web.repository;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.MypageVO;



//스프링에서 이 클래스가 DAO임을 알려주는 어노테이션
@Repository //DB와 관련된 작업을 하는 클래스에 붙여줌
public class MypageDAO {

	@Autowired  // 의존성 주입을 통해 SqlSession 객체를 사용 가능하게 함
	private SqlSession sqlSession;
	
	 // NAMESPACE: MyBatis에서 사용할 매퍼 파일의 네임스페이스를 지정
	private static final String NAMESPACE = "com.human.web.mapper.MypageMapper";	
	
	
	 // getMypageList: 데이터베이스에서 M_Mypage 테이블의 모든 데이터를 가져오는 메서드
    // 반환값: List<MypageVO> - M_Mypage 테이블의 모든 데이터를 VO 객체 리스트로 반환
	public List<MypageVO> getMypageList() {
		 System.out.println("MypageDAO - getMypageList 호출됨");  // 메서드 호출 시 출력
	        
	        List<MypageVO> list = sqlSession.selectList(NAMESPACE + ".getMypageList");

	        // 쿼리 결과 출력
	        if (list != null && !list.isEmpty()) {
	            System.out.println("조회된 데이터 수: " + list.size());
	            for (MypageVO vo : list) {
	                System.out.println(vo);
	            }
	        } else {
	            System.out.println("쿼리 결과가 없습니다.");
	        }
	        
	        return list;
		
	}

}
