$(document).ready(function() {
    // 이메일 유효성 검사
    $('#email').on('input', function() {
        const emailMsg = $('#emailMsg');
        const email = $(this).val();
        const emailPattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$/;

        if (email === '') {
            emailMsg.text("이메일을 입력하세요.");
            emailMsg.css('display', 'block');
        } else if (!emailPattern.test(email)) {
            emailMsg.text("유효하지 않은 이메일 형식입니다.");
            emailMsg.css('display', 'block');
        } else {
            emailMsg.css('display', 'none');
        }
    });

    // 닉네임 유효성 검사
    $('#nickname').on('input', function() {
        const nicknameMsg = $('#nicknameMsg');
        const nickname = $(this).val();
        const nicknamePattern = /^[a-zA-Z0-9가-힣]{2,7}$/;

        if (nickname === '') {
            nicknameMsg.text("닉네임을 입력하세요.");
            nicknameMsg.css('display', 'block');
        } else if (!nicknamePattern.test(nickname)) {
            nicknameMsg.text("닉네임은 2자 이상 7자 이하의 한글, 영문, 숫자로만 구성되어야 합니다.");
            nicknameMsg.css('display', 'block');
        } else {
            nicknameMsg.css('display', 'none');
        }
    });

    // 비밀번호 유효성 검사
    $('#password').on('input', function() {
        const passwordMsg = $('#passwordMsg');
        const password = $(this).val();
        const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;

        if (password === '') {
            passwordMsg.text("비밀번호를 입력하세요.");
            passwordMsg.css('display', 'block');
        } else if (password.length < 8) {
            passwordMsg.text("비밀번호는 8자 이상이어야 합니다.");
            passwordMsg.css('display', 'block');
        } else if (!passwordPattern.test(password)) {
            passwordMsg.text("비밀번호는 숫자, 대문자, 소문자, 특수문자를 포함해야 합니다.");
            passwordMsg.css('display', 'block');
        } else {
            passwordMsg.css('display', 'none');
        }
    });

    // 비밀번호 확인 유효성 검사 (m_password_re)
    $('#password_re').on('input', function() {
        const passwordReMsg = $('#passwordReMsg');
        const password = $('#password').val();  // 원래 비밀번호 필드의 값
        const passwordRe = $(this).val();       // 비밀번호 확인 필드의 값

        if (passwordRe === '') {
            passwordReMsg.text("비밀번호 확인을 입력하세요.");
            passwordReMsg.css('display', 'block');
        } else if (passwordRe !== password) {
            passwordReMsg.text("비밀번호가 일치하지 않습니다.");
            passwordReMsg.css('display', 'block');
        } else {
            passwordReMsg.css('display', 'none');  // 비밀번호가 일치하면 메시지를 숨김
        }
        
         // 필수 항목 체크
    if (!terms || !privacy) {
        alert("이용약관 및 개인정보 수집·이용 동의는 필수 항목입니다.");
        return false;  // 필수 항목이 체크되지 않으면 폼 제출을 막음
    }

    // 모든 조건이 충족되면 폼을 제출
    return true;
    });
});
