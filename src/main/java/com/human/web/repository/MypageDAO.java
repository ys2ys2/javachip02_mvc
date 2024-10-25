package com.human.web.repository;

import java.util.List;
import java.util.stream.Collectors;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.MypageSchedVO;
import com.human.web.vo.MypageVO;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;



//스프링에서 이 클래스가 DAO임을 알려주는 어노테이션
@Repository //DB와 관련된 작업을 하는 클래스에 붙여줌
@RequiredArgsConstructor
@AllArgsConstructor 
public class MypageDAO {

	@Autowired  // 의존성 주입을 통해 SqlSession 객체를 사용 가능하게 함
	private SqlSession sqlSession;
	
	 // NAMESPACE: MyBatis에서 사용할 매퍼 파일의 네임스페이스를 지정
	private static final String MAPPER = "com.human.web.mapper.MypageMapper";	
	
	 // getMypageList: 데이터베이스에서 M_Mypage 테이블의 모든 데이터를 가져오는 메서드
    // 반환값: List<MypageVO> - M_Mypage 테이블의 모든 데이터를 VO 객체 리스트로 반환
	
	
	//랜덤 핫플레이스 가져오기, 이미지 1개처리
	public List<MypageVO> getRandomHotplaceList() {
	    System.out.println("MypageDAO - getRandomHotplaceList 호출됨");  // 메서드 호출 시 출력
	        
	    List<MypageVO> list = sqlSession.selectList(MAPPER + ".getRandomHotplaceList");

	    // 쿼리 결과가 있는 경우 처리
	    if (list != null && !list.isEmpty()) {
	        list = list.stream().map(vo -> {
	            String firstimage = vo.getFirstimage(); // MypageVO의 firstimage 필드를 가져옴
	            if (firstimage != null && firstimage.contains(",")) {
	                // 쉼표로 구분된 이미지 중 첫 번째만 추출
	                firstimage = firstimage.split(",")[0].trim();
	            }
	            vo.setFirstimage(firstimage); // 수정된 firstimage를 다시 설정
	            return vo;  // vo 객체 반환
	        }).collect(Collectors.toList());
	        
	        // 쿼리 결과 출력
	        for (MypageVO vo : list) {
	            System.out.println(vo);
	        }
	    } else {
	        System.out.println("쿼리 결과가 없습니다.");
	    }
	    
	    return list;
	}


	//저장 목록 카테고리에 불러오기
	public List<MypageVO> getSavedList(int m_idx) {
			List<MypageVO> savedList = sqlSession.selectList(MAPPER + ".getSavedList", m_idx);
			System.out.println("DAO에서 가져온 데이터 출력하기: " +savedList);
			return savedList;
	}
	
	//게시글 카테고리에불러오기
	public List<MypageVO> getSavedPostList(int m_idx) {
	    System.out.println("DAO에서 전달받은 m_idx: " + m_idx);  // m_idx 값을 확인
	    List<MypageVO> savedPostList = sqlSession.selectList(MAPPER + ".getSavedPostList", m_idx);
	    System.out.println("DAO에서 가져온 데이터 출력하기: " + savedPostList);  // 가져온 데이터 확인
	    return savedPostList;
	}

	//게시글 마이페이지 홈에 불러오기
	public List<MypageVO> getSavedPostListByMidx(Integer m_idx) {
		  return sqlSession.selectList(MAPPER + ".getSavedPostList", m_idx);
	}

	
	//저장목록 마이페이지 홈에 불러오기
	public List<MypageVO> getSavedListByMidx(Integer m_idx) {
		return sqlSession.selectList(MAPPER+".getSavedList", m_idx);
	}

	//여행 일정 카테고리에 불러오기(다가오는 일정)
	public List<MypageSchedVO> getUpcomingTrips(int m_idx) {
		  return sqlSession.selectList(MAPPER + ".getUpcomingTrips", m_idx);
	}
	//여행 일정 카테고리에 불러오기(지난 일정)
	public List<MypageSchedVO> getPastTrips(int m_idx) {
		  return sqlSession.selectList(MAPPER + ".getPastTrips", m_idx);
	}

	public List<MypageSchedVO> getUpcomingTripsByMidx(Integer m_idx) {
		return sqlSession.selectList(MAPPER+".getUpcomingTrips", m_idx);
	}

	/*
	 * public List<MypageSchedVO> getPastTripsByMidx(Integer m_idx) { return
	 * sqlSession.selectList(MAPPER+".getPastTrips", m_idx); }
	 */
	public MypageSchedVO getLatestPastTrip(Integer m_idx) {
		return sqlSession.selectOne(MAPPER+".getLatestPastTrip", m_idx);
	}

	public MypageSchedVO getLatestUpcomingTripByMidx(Integer m_idx) {
		return sqlSession.selectOne(MAPPER+".getLatestUpcomingTripByMidx", m_idx);
	}

}


