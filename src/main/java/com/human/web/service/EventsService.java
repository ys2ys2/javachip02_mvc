package com.human.web.service;

import com.human.web.vo.EventsCommetsVO;
import java.util.List;

public interface EventsService {
    int insertComment(EventsCommetsVO commentVO); // 댓글 추가 메서드
    List<EventsCommetsVO> getAllComments(); // 댓글 목록 가져오기 메서드
}
