package com.human.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.MatzipDAO;
import com.human.web.vo.MatzipVO;

@Service
public class MatzipServiceImpl implements MatzipService {

    @Autowired
    private MatzipDAO matzipDAO;


    @Override
    public String insertMatzipData(List<MatzipVO> selectedRestaurants) {
        try {
            // DAO의 insert 메서드를 사용해 리스트 내의 각 MatzipVO 객체를 DB에 저장
            for (MatzipVO restaurant : selectedRestaurants) {
                matzipDAO.insertMatzip(restaurant);
            }
            return "음식점 정보가 성공적으로 저장되었습니다.";
        } catch (Exception e) {
            e.printStackTrace();
            return "음식점 정보 저장 중 오류가 발생했습니다: " + e.getMessage();
        }
    }


    @Override
    public List<MatzipVO> getMatzipList() {
        return matzipDAO.getMatzipList();
    }


	@Override
	public MatzipVO getMatzipDetailById(int contentid) {
        return matzipDAO.getMatzipDetailById(contentid);
	}
}
