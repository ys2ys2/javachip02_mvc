package com.human.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.human.web.vo.ScheduleVO;
import com.human.web.vo.TripScheduleVO;

import lombok.AllArgsConstructor;

@Repository
@AllArgsConstructor
public class TripScheduleDAO {
	
    private SqlSession sqlSession;
    private PlatformTransactionManager transactionManager;
    private static final String MAPPER = "com.human.web.mapper.TripScheduleMapper";

    // 여행 일정 추가
    @Transactional
    public void insertTripSchedule(TripScheduleVO tripSchedVO) {
       
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			// 1. travel_schedule에 먼저 삽입
			sqlSession.insert(MAPPER + ".insertTripSchedule", tripSchedVO);

			// 2. 방금 삽입된 travel_schedule의 자동 생성된 post_id 가져오기
			int post_id = sqlSession.selectOne(MAPPER + ".getMaxPostId");

			// 3. schedule 테이블에 post_id를 기반으로 데이터 삽입
			List<ScheduleVO> scheduleList = tripSchedVO.getScheduleList();
			for (ScheduleVO sVo : scheduleList) {
				sVo.setPost_id(post_id);  // post_id 설정
				sqlSession.insert(MAPPER + ".insertSchedule", sVo);  // schedule에 삽입
			}

			// 성공 시 커밋
			transactionManager.commit(txStatus);

		} catch (Exception e) {
			// 예외 발생 시 롤백
			transactionManager.rollback(txStatus);
			throw e;
		}
	}
    
    // 최대 Post ID 조회 (방금 삽입된 post_id 조회)
    public Integer getMaxPostId() {
        return sqlSession.selectOne(MAPPER + ".getMaxPostId");
    }

    // 여행 일정 리스트 조회
    public List<TripScheduleVO> getTripScheduleList() {
        return sqlSession.selectList(MAPPER + ".getDistinctTripScheduleList");
    }

    // 여행 일정 단일 조회
    public List<TripScheduleVO> getTripScheduleById(int id) {
    	List<TripScheduleVO> tripScheduleList = sqlSession.selectList(MAPPER + ".getTripScheduleById", id);
    	for (TripScheduleVO vo : tripScheduleList) {
    		List<ScheduleVO> scheduleList = sqlSession.selectList(MAPPER + ".getScheduleByPostId", vo.getPost_id());
    		vo.setScheduleList(scheduleList);
    	}
    	return tripScheduleList;
    }
}

