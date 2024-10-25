package com.human.web.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {

    private PasswordAuthentication auth;

    public GoogleAuthentication() {
        // Gmail SMTP에 사용할 이메일과 비밀번호 설정
        String email = "parkyeseul.developer@gmail.com";
        String password = "wvcw pgwk vfxe dktu"; // 실제 비밀번호 또는 앱 비밀번호 입력
        auth = new PasswordAuthentication(email, password);
    }

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return auth;
    }
}
