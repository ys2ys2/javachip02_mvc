package com.human.web.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.NaverLoginVO;

@Repository
public class NaverLoginDAO {
	@Autowired
    private  SqlSession sqlSession;

    public static final String MAPPER = "com.human.web.mapper.NaverLoginMapper";

    // 네이버 로그인 정보 삽입
    public int insertNaverLogin(NaverLoginVO vo) {
        int result = 0; // 입력 실패 시 결과값
        try {
            result = sqlSession.insert(MAPPER + ".insertNaverLogin", vo);
        } catch (Exception e) {
            System.out.println("네이버 로그인 정보 삽입 중 예외 발생");
            e.printStackTrace();
        }
        return result;
    }

    // 네이버 ID로 사용자 정보 조회
    public NaverLoginVO getNaverLoginInfo(String naverId) {
        NaverLoginVO naverLoginVO = null;
        try {
            naverLoginVO = sqlSession.selectOne(MAPPER + ".getNaverLoginInfo", naverId);
        } catch (Exception e) {
            System.out.println("네이버 로그인 정보 조회 중 예외 발생");
            e.printStackTrace();
        }
        return naverLoginVO;
    }
    
    public NaverLoginVO findByNaverId(String naverId) {
        return sqlSession.selectOne("com.human.web.mapper.NaverLoginMapper.findByNaverId", naverId);
    }


	
}
