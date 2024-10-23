package com.human.web.repository;


import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.human.web.vo.SeoulMatzipCommentsVO;

import lombok.AllArgsConstructor;

@Repository
@AllArgsConstructor
public class SeMatzipCommentsDAO {

	 private final SqlSessionTemplate sqlSession;

    private static final String MAPPER = "com.human.web.mapper.SeoulMatzipCommentsMapper";

    public int insertComment(SeoulMatzipCommentsVO commentVO) {
        return sqlSession.insert(MAPPER + ".insertComment", commentVO);
    }

    public List<SeoulMatzipCommentsVO> getAllCommentsMatzip() {
        return sqlSession.selectList(MAPPER + ".getAllComments");
    }
    
    public List<SeoulMatzipCommentsVO> getAllCommentsByEventId(int eventId) {
        return sqlSession.selectList(MAPPER + ".getAllCommentsByEventId", eventId);
    }


//    // 댓글 삭제 메서드
//    public int deleteCommentById(int t_ec_idx) {
//        return sqlSession.delete(MAPPER + ".deleteCommentById", t_ec_idx);
//    }
//
//    // 댓글 수정 메서드
//    public int updateCommentById(int t_ec_idx, String newComment) {
//        Map<String, Object> params = new HashMap<>();
//        params.put("t_ec_idx", t_ec_idx); // 댓글 번호
//        params.put("newComment", newComment); // 수정할 댓글 내용
//        return sqlSession.update(MAPPER + ".updateCommentById", params);
//    }


  
}