package com.human.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.human.web.repository.SeMatzipCommentsDAO;
import com.human.web.vo.SeoulMatzipCommentsVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class SeMatzipCommentsServiceImpl implements SeMatzipCommentsService {
	
	private SeMatzipCommentsDAO dao;

	@Override
	public boolean deleteCommentById(int t_smc_idx) {
		try {
	           int result = dao.deleteCommentById(t_smc_idx); // DAO 호출
	           return result > 0; // 삭제 성공 여부 반환
	       } catch (Exception e) {
	           return false; // 실패 시 false 반환
	       }
	}
	
	@Override
	public boolean updateCommentById(int t_smc_idx, String newComment) {
	    try {
	        int result = dao.updateCommentById(t_smc_idx, newComment); // DAO 호출
	        return result > 0; // 업데이트 성공 여부 반환
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 발생 시 로그 출력
	        return false; // 실패 시 false 반환
	    }
	}
	
	//맛집 댓글 추가
	@Override
	public int insertComment(SeoulMatzipCommentsVO commentVO) {
		return dao.insertComment(commentVO);
	}

	//맛집 댓글 목록 조회
	@Override
	public List<SeoulMatzipCommentsVO> getAllComments() {
		return dao.getAllComments();
	}
	

	    
	    
}

   
   
