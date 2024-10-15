
// 모달 열기 함수
function openTermsModal(type) {
  const modal = document.getElementById('termsModal');
  const modalTitle = document.getElementById('modalTitle');
  const modalContent = document.getElementById('modalContent');

  // 약관 타입에 따라 모달 제목과 내용을 설정
  if (type === 'terms') {
    modalTitle.textContent = '이용약관';
    modalContent.innerHTML = `
      <p><strong>제 1 조 (목적)</strong> - 이 약관은 BBOL BBOL BBOL(이하 "회사")가 제공하는 인터넷 관련 서비스(이하 "서비스")를 이용함에 있어 회사와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.</p>
      <p><strong>제 2 조 (정의)</strong> - "사이트"란 회사가 서비스를 이용자에게 제공하기 위해 컴퓨터 등 정보통신설비를 이용하여 구축한 웹사이트를 말합니다. "이용자"란 사이트에 접속하여 이 약관에 따라 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</p>
      <p>... (중략) ...</p>
      <p><strong>제 12 조 (준거법 및 재판 관할)</strong> - 이 약관과 회사와 이용자 간의 서비스 이용계약에 관하여는 대한민국 법을 준거법으로 합니다.</p>
    `;
  } else if (type === 'privacy') {
    modalTitle.textContent = '개인정보 수집·이용 동의';
    modalContent.innerHTML = `
      <p><strong>제 1 조 (수집하는 개인정보 항목)</strong> - 회사는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.</p>
      <ul>
        <li>필수항목: 이름, 이메일 주소, 비밀번호, 연락처</li>
        <li>선택항목: 생년월일, 성별</li>
      </ul>
      <p><strong>제 2 조 (개인정보의 수집 및 이용 목적)</strong> - 수집한 개인정보는 다음의 목적을 위해 활용됩니다.</p>
      <ul>
        <li>회원 관리: 회원제 서비스 이용에 따른 본인확인, 개인 식별, 가입 의사 확인</li>
        <li>서비스 제공: 콘텐츠 제공, 맞춤 서비스 제공, 본인 인증, 요금 결제 및 환불</li>
      </ul>
      <p><strong>제 3 조 (개인정보의 보유 및 이용기간)</strong> - 이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용 목적이 달성되면 지체 없이 파기합니다. 단, 관련 법령에 따라 일정 기간 보관이 필요한 경우에는 해당 기간 동안 개인정보를 보관합니다.</p>
    `;
  } else if (type === 'marketing') {
    modalTitle.textContent = '마케팅 메일 수신 동의';
    modalContent.innerHTML = `
      <p><strong>제 1 조 (목적)</strong> - 회사는 이용자의 동의를 받아 광고성 정보를 전자우편, 문자메시지 등으로 전송할 수 있습니다.</p>
      <p><strong>제 2 조 (수집하는 항목)</strong> - 광고성 정보 수신에 필요한 정보는 이메일 주소 및 연락처입니다.</p>
      <p><strong>제 3 조 (마케팅 활용)</strong> - 회사는 이용자의 동의를 받아 마케팅 목적으로 개인정보를 활용할 수 있으며, 여기에는 맞춤형 광고 제공, 이벤트 알림, 신제품 안내 등이 포함됩니다.</p>
      <p><strong>제 4 조 (수신 거부권)</strong> - 이용자는 언제든지 회사가 제공하는 마케팅 정보의 수신을 거부할 권리가 있으며, 수신 거부 시 더 이상의 마케팅 정보는 발송되지 않습니다.</p>
      <p><strong>제 5 조 (보유 및 이용기간)</strong> - 회사는 이용자의 동의 철회 요청 또는 개인정보 파기 요청 시, 해당 정보를 지체 없이 파기합니다. 단, 법령에서 정한 정보는 해당 법령이 정한 기간 동안 보유합니다.</p>
    `;
  }

  // 모달 표시
  modal.style.display = 'block';
}

// 모달 닫기 함수
function closeTermsModal() {
  const modal = document.getElementById('termsModal');
  modal.style.display = 'none';
}


