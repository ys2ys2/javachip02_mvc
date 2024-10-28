package com.human.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.human.web.repository.EventsDAO;
import com.human.web.vo.EventsCommentsVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class EventsServiceImpl implements EventsService {
	
	private EventsDAO dao;

	@Override
	public int insertComment(EventsCommentsVO commentVO) {
		return dao.insertComment(commentVO);
	}

	@Override
	public List<EventsCommentsVO> getAllComments() {
		return dao.getAllComments();
	}

	@Override
	public boolean deleteCommentById(int t_ec_idx) {
		try {
	           int result = dao.deleteCommentById(t_ec_idx); // DAO 호출
	           return result > 0; // 삭제 성공 여부 반환
	       } catch (Exception e) {
	           return false; // 실패 시 false 반환
	       }
	}
	
	@Override
	public boolean updateCommentById(int t_ec_idx, String newComment) {
	    try {
	        int result = dao.updateCommentById(t_ec_idx, newComment); // DAO 호출
	        return result > 0; // 업데이트 성공 여부 반환
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 발생 시 로그 출력
	        return false; // 실패 시 false 반환
	    }
	}

	//t_main_img url 가져오기
	@Override
	public List<Map<String, Object>> getRandomEventImages() {
		return dao.getRandomEventImages();
	}

	

	    
	    
}

   
   
