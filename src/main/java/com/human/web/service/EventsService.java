package com.human.web.service;

import com.human.web.vo.EventsCommentsVO;
import java.util.List;

public interface EventsService {
    int insertComment(EventsCommentsVO commentVO); // 댓글 추가 메서드
    List<EventsCommentsVO> getAllComments(); // 댓글 목록 가져오기 메서드
    boolean deleteCommentById(int t_ec_idx);  // 댓글 삭제 메서드
    boolean updateCommentById(int t_ec_idx, String newComment);


}
