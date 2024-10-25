package com.human.web.util;

import java.util.Random;

public class CodeGenerator {
    // 6자리 랜덤 인증번호를 생성하는 메서드
    public static String generateCode() {
        Random random = new Random();
        StringBuilder code = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            code.append(random.nextInt(10)); // 0-9 랜덤 숫자 생성
        }
        return code.toString(); // 생성된 인증번호 반환
    }
}
