package com.human.web.repository;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.human.web.vo.SeoulMatzipCommentsVO;

import lombok.AllArgsConstructor;

@Repository
@AllArgsConstructor
public class SeMatzipCommentsDAO {

	 private final SqlSessionTemplate sqlSession;

	    private static final String MAPPER = "com.human.web.mapper.SeoulMatzipCommentsMapper";

	    public List<SeoulMatzipCommentsVO> getAllComments() {
	        return sqlSession.selectList(MAPPER + ".getAllComments");
	    }
	    
	    public List<SeoulMatzipCommentsVO> getAllCommentsByEventId(int eventId) {
	        return sqlSession.selectList(MAPPER + ".getAllCommentsByEventId", eventId);
	    }
	    // 댓글 삭제 메서드
	    public int deleteCommentById(int t_smc_idx) {
	        return sqlSession.delete(MAPPER + ".deleteCommentById", t_smc_idx);
	    }

	    // 댓글 수정 메서드
	    public int updateCommentById(int t_smc_idx, String newComment) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("t_smc_idx", t_smc_idx); // 댓글 번호
	        params.put("newComment", newComment); // 수정할 댓글 내용
	        return sqlSession.update(MAPPER + ".updateCommentById", params);
	    }

		public int insertComment(SeoulMatzipCommentsVO commentVO) {
			return sqlSession.insert(MAPPER+".insertComment", commentVO);
		}

	
	


  
}