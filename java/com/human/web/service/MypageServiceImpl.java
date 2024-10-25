package com.human.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.human.web.repository.MypageDAO;
import com.human.web.vo.MypageVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MypageServiceImpl implements MypageService {

	private MypageDAO dao;
	
	
	@Override
	public List<MypageVO> getMypageList() {
		/* System.out.println("MypageServiceImpl - getMypageList 호출됨"); */
			return dao.getMypageList() ;
	}

}
