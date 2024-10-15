package com.human.web.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.web.vo.KakaoLoginVO;

@Repository
public class KakaoLoginDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String MAPPER = "com.human.web.mapper.KakaoLoginMapper";

    // 카카오 로그인 정보 삽입
    public int insertKAKAOLOGIN(KakaoLoginVO kakaoLoginVO) {
        return sqlSession.insert(MAPPER+ ".insertKAKAOLOGIN", kakaoLoginVO);
    }

    // 카카오 ID로 기존 회원 확인
    public KakaoLoginVO findByKakaoId(Long kakaoId) {
        return sqlSession.selectOne(MAPPER+ ".findByKakaoId", kakaoId);
    }
}
