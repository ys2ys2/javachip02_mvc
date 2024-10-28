package com.human.web.service;

import java.util.List;

import com.human.web.vo.MatzipVO;

public interface MatzipService {


	String insertMatzipData(List<MatzipVO> selectedRestaurants);

	
	//맛집 리스트
    List<MatzipVO> getMatzipList();


    // contentid로 맛집 정보 가져오기
	MatzipVO getMatzipDetailById(int contentid);


}
