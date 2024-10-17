package com.human.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.SeoulEventApiDAO;
import com.human.web.vo.EventsCommetsVO;

@Service
public class EventsServiceImpl implements EventsService {

    private final SeoulEventApiDAO seoulEventApiDAO;

    @Autowired
    public EventsServiceImpl(SeoulEventApiDAO seoulEventApiDAO) {
        this.seoulEventApiDAO = seoulEventApiDAO;
    }

    
	@Override
	public int insertComment(EventsCommetsVO commentVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<EventsCommetsVO> getAllComments() {
		// TODO Auto-generated method stub
		return null;
	}

//    @Override
//    public int saveEvent(SeoulEventApiVO.Row event) {
//        seoulEventApiDAO.insertEvent(event);
//    }
}