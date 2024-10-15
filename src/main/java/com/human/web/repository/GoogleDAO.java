package com.human.web.repository;

import com.human.web.vo.GoogleVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class GoogleDAO {

    private final SqlSession sqlSession;

    // Mapper의 네임스페이스
    private static final String MAPPER = "com.human.web.mapper.GoogleMapper";

    // Google 로그인 정보를 DB에 삽입하는 메서드
    public void insertGoogleLogin(GoogleVO googleVO) {
        sqlSession.insert(MAPPER + ".insertGoogleLogin", googleVO);
    }
}
