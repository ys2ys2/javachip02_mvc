<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPageMain.css"> 
    <title>FAQ 챗봇</title>
    <style>
    /* 여기어때 잘난체 */
@font-face {
    font-family: 'yg-jalnan';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.2/JalnanOTF00.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

/* Pretendard */
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

/*플라이트 산스  */
@font-face {
    font-family: 'FlightSans-Bold';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2410-1@1.0/FlightSans-Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
    
           /* 전체 채팅 창 스타일 */
        .chat-container {
            max-width: 400px;
            height: 600px;
            margin: 20px auto;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            font-family: 'FlightSans-Bold';
            font-weight: 600;
            margin-bottom: 200px;
            position: relative;
            top: 110px;
        }

        /* 상단 헤더 스타일 */
        .chat-header {
            background-color: black;
            color: #fff;
            padding: 15px 15px;
            font-size: 18px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

     
        /* 채팅 내용 영역 */
        .chat-content {
            flex-grow: 1;
            padding: 20px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
        }

        /* 메시지 스타일 */
        .message {
            max-width: 90%;
            padding: 12px 16px;
            margin: 8px 0;
            border-radius: 15px;
            font-size: 14px;
            line-height: 1.4;
            display: flex;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

      
        .message.question {
            align-self: flex-start;
            background-color: beige;
            color: #333;
            border-radius: 15px 15px 15px 0;
            
        }

        .message.answer {
            align-self: flex-end;
            background-color: black;
            color: #fff;
            border-radius: 15px 15px 0 15px;
        }

        /* 버튼 스타일 */
        .message.buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: flex-start;
            align-items: center;
        }

        .message.buttons button {
            padding: 8px 16px;
            border: none;
            border-radius: 20px;
            background-color: black;
            cursor: pointer;
            color: #fff;
            font-size: 14px;
            font-weight: bold;
            transition: background-color 0.2s;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.15);
        }

     

        /* 입력 영역 스타일 */
        .chat-input {
            display: flex;
            align-items: center;
            padding: 10px;
            border-top: 1px solid #ddd;
            background-color: #ffffff;
        }

        .chat-input input {
            flex-grow: 1;
            padding: 10px;
            border: none;
            border-radius: 20px;
            background-color: #f1f1f1;
            margin-right: 10px;
            font-size: 14px;
        }

        .chat-input button {
            background-color: black;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.2s;
        }

       
    </style>
</head>
<body>
<!-- header -->
    <jsp:include page="/WEB-INF/views/Components/header.jsp" />

<div class="chat-container">
 <!-- 상단 헤더 -->
    <div class="chat-header">
        BBOLBBOLBBOL 챗봇
    </div>

    <div class="chat-content" id="chatContent">
        <!-- 초기 안내 메시지 -->
        <div class="message question">안녕하세요.😊 <br>
            우리 일상의 여행과 추억을 그려가는 곳,<br> 여행 추천 플랫폼 BBOLBBOLBBOL 입니다.<br>
            궁금하신 내용을 메시지 입력란에<br> 직접 입력해 주시거나 <br>문의자 유형을 선택해 주세요.🐾🐾
        </div>
    </div>

    <!-- 메인 FAQ 버튼 메시지 형태로 추가 -->
    <div class="message buttons" id="mainButtons">
        <button onclick="showSubButtons('account')">계정/로그인</button>
        <button onclick="showSubButtons('schedule')">여행일정</button>
        <button onclick="showSubButtons('community')">커뮤니티</button>
    </div>

    <!-- 사용자 입력 영역 -->
    <div class="chat-input">
        <input type="text" id="userInput" placeholder="메세지 입력"  onkeydown="handleKeyPress(event)"/>
        <button onclick="sendMessage()">➤</button>
    </div>
</div>

<script>
    // FAQ 버튼을 통해 질문을 전송하는 함수
    function sendFAQ(question) {
        // 사용자의 질문을 대화창에 추가
        addMessage(question, "answer");
        const answerText = getAnswer(question);
        setTimeout(() => addMessage(answerText, "question"), 500); // 챗봇 답변 추가
    }

    // 계정/로그인 하위 질문 버튼을 대화창에 메시지 형태로 표시하는 함수
    function showSubButtons(category) {
      let messageText ="";

        if (category === 'account') {
            messageText = "계정/로그인 관련 질문을 선택해 주세요.";
            addMessage(messageText, "question");

           // 하위 질문 버튼들
           const buttons = [
                { text: "회원가입", action: "회원가입 하는 방법" },
                { text: "탈퇴", action: "탈퇴하는 방법" },
                { text: "로그인 유형", action: "로그인 유형" },
                { text: "아이디/비밀번호 찾기", action: "아이디/비밀번호 찾기" }
            ];
            addButtons(buttons);
        }else if(category === 'schedule'){
            messageText ="여행일정 관련 질문을 선택해 주세요."
            addMessage(messageText, "question");

            const buttons = [
              { text: "일정 추가 방법", action: "일정 추가 방법"},
              { text: "일정 삭제 방법", action: "일정 삭제 방법"},
              { text: "일정 공유 방법", action: "일정 공유 방법"}
            ];
            addButtons(buttons);
          }else if(category ==='community'){
            messageText="커뮤니티 관련 질문을 선택해 주세요."
            addMessage(messageText, "question");

            const buttons = [
              { text: "커뮤니티 이용 방법", action: "커뮤니티 이용 방법"},
              { text: "커뮤니티 매너", action: "커뮤니티 매너"},
            ];
            addButtons(buttons);

          }

        }
        
        //버튼 목록을 메세지 형태로 추가하는 함수
        function addButtons(buttons){
            const chatContent =document.getElementById("chatContent");

        //버튼 컨테이너 생성
       const buttonContainer = document.createElement("div");
       buttonContainer.classList.add("message","buttons");
       
       buttons.forEach(btn => {
        const button = document.createElement("button");
        button.innerText = btn.text;
        button.onclick = () => sendFAQ(btn.action); //각 버튼 클릭 시 FAQ 전송
        buttonContainer.appendChild(button);
       });
      

            // 뒤로 가기 버튼 추가
            const backButton = document.createElement("button");
            backButton.innerText = "뒤로";
            backButton.onclick = goBackToMain;
            buttonContainer.appendChild(backButton);

            // 대화창에 버튼 메시지 추가
            chatContent.appendChild(buttonContainer);
            chatContent.scrollTop = chatContent.scrollHeight;
        }
    

     // 메인 FAQ 버튼으로 돌아가기
        function goBackToMain() {
            addMessage("이전으로 돌아갑니다.", "question");

            // 기존의 mainButtons 배열을 제거하고, 각 버튼에 직접 함수를 설정합니다.
            const chatContent = document.getElementById("chatContent");

            // 버튼 컨테이너 생성
            const buttonContainer = document.createElement("div");
            buttonContainer.classList.add("message", "buttons");

            // 계정/로그인 버튼
            const accountButton = document.createElement("button");
            accountButton.innerText = "계정/로그인";
            accountButton.onclick = () => showSubButtons('account');
            buttonContainer.appendChild(accountButton);

            // 여행일정 버튼
            const scheduleButton = document.createElement("button");
            scheduleButton.innerText = "여행일정";
            scheduleButton.onclick = () => showSubButtons('schedule');
            buttonContainer.appendChild(scheduleButton);

            // 커뮤니티 버튼
            const communityButton = document.createElement("button");
            communityButton.innerText = "커뮤니티";
            communityButton.onclick = () => showSubButtons('community');
            buttonContainer.appendChild(communityButton);

            // 대화창에 버튼 메시지 추가
            chatContent.appendChild(buttonContainer);
            chatContent.scrollTop = chatContent.scrollHeight;
        }


    // 사용자가 입력한 메시지를 전송하는 함수
    function sendMessage() {
        const userInput = document.getElementById("userInput");
        const messageText = userInput.value.trim();

        if (messageText) {
            addMessage(messageText, "answer");

            // FAQ 답변 추가
            setTimeout(() => {
                const answerText = getAnswer(messageText);
                addMessage(answerText, "question");
            }, 500); // 지연 효과로 자연스러움 추가

            userInput.value = ""; // 입력란 비우기
        }
    }

    //enter키를 눌렀을 때 메세지 전송 함수
    function handleKeyPress(event){
      if(event.key ==="Enter"){
        sendMessage();
      }
    }

    // 메시지를 추가하는 함수
    function addMessage(text, type) {
        const chatContent = document.getElementById("chatContent");
        const message = document.createElement("div");
        message.classList.add("message", type);
        message.innerText = text;
        chatContent.appendChild(message);

        // 새로운 메시지가 추가될 때 스크롤을 맨 아래로 이동
        chatContent.scrollTop = chatContent.scrollHeight;
    }

    // FAQ에 따른 고정된 답변 반환 함수
    function getAnswer(question) {
        if (question.includes("회원가입")) {
            return "홈페이지 화면 좌측상단에 회원가입 버튼을 통해 가능하며, 약관 동의 및 정보입력 해주시면 가입이 완료됩니다.";
        } else if (question.includes("탈퇴")) {
            return "마이페이지 > 프로필 편집 > 회원탈퇴 버튼을 통해 탈퇴가 가능합니다.";
        } else if (question.includes("로그인 유형")) {
            return "이메일 간편가입, 카카오, 네이버, 구글을 통해 간편하게 로그인이 가능합니다.";
        } else if (question.includes("아이디/비밀번호 찾기")) {
            return "로그인 페이지에서 아이디/비밀번호 찾기 옵션을 사용해 주세요.";
        } else if (question.includes("일정 추가 방법")) {
            return "여행일정은 구글지도와 날짜 별로 쉽고 간편하게 여행 일정을 작성할 수 있습니다.   ";
        } else if (question.includes("일정 삭제 방법")) {
            return "여행 일정은 여행일정 페이지에서 삭제할 수 있습니다. ";
        } else if (question.includes("일정 공유 방법")) {
            return "마이페이지에서 내 일정을 확인하고 공유해 보세요!🙂";
        }else if (question.includes("커뮤니티 이용 방법")) {
            return "커뮤니티에서 다양한 여행 지식과 정보를 얻을 수 있습니다. 😄";
        }else if (question.includes("커뮤니티 매너")) {
            return "커뮤니티를 이용할 때는 건강한 소통 문화를 지양하고 규칙을 준수함으로써 모두가 즐겁고 안전한 환경을 유지할 수 있도록 합니다.";
        } 
        else {
            return "죄송합니다. 해당 질문에 대한 답변을 찾을 수 없습니다.";
        }
    }
</script>

  <!-- footer -->
    <jsp:include page="/WEB-INF/views/Components/footer.jsp" />
</body>
</html>
