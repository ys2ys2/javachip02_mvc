// 모달 열기
function openProfileModal() {
    document.getElementById("e_profileModal").style.display = "block"; // 모달 창 열기
    document.querySelector(".overlay").style.display = "block"; // 어두운 배경 열기
}

// 모달 닫기
function closeProfileModal() {
    document.getElementById("e_profileModal").style.display = "none"; // 모달 창 닫기
    document.querySelector(".overlay").style.display = "none"; // 어두운 배경 닫기
}

// 닉네임 중복 체크
function checkNickname(m_nickname) {
    if (m_nickname.length > 0) {
        $.ajax({
            type: "POST",
            url: contextPath + "/Member/checkNickname", // contextPath 사용
            data: {m_nickname: m_nickname},
            success: function(response) {
                if (response === "available") {
                    $("#nicknameStatus").text("사용 가능한 닉네임입니다.").css("color", "green");
                } else {
                    $("#nicknameStatus").text("이미 사용 중인 닉네임입니다.").css("color", "red");
                }
            }
        });
    } else {
        $("#nicknameStatus").text("");
    }
}

// 프로필 이미지 미리보기
function previewProfileImage(event) {
    var reader = new FileReader();
    reader.onload = function(){
        var output = document.querySelector('.e_profile-image');
        output.src = reader.result;
    }
    reader.readAsDataURL(event.target.files[0]);
}

// 확인 버튼 동작 (updateProfile)
function updateProfile() {
    var formData = new FormData(document.getElementById("e_profileForm"));
    
    // 폼 데이터 확인을 위한 디버깅
    for (var pair of formData.entries()) {
        console.log(pair[0] + ': ' + pair[1]); // 모든 폼 데이터 출력
    }
    
    $.ajax({
        type: "POST",
        url: contextPath + "/Member/updateProfile", // contextPath 사용
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response === "success") {
                alert("프로필이 성공적으로 업데이트되었습니다.");
                location.reload(); // 페이지 새로고침
            } else {
                alert("프로필 업데이트에 실패했습니다.");
            }
        },
        error: function(xhr, status, error) {
	    console.log(xhr.responseText); // 서버에서 반환된 에러 메시지 확인
	    console.log('Error: ' + status + ' - ' + error); // 상태와 에러 로그 출력
	    alert("에러가 발생했습니다. 다시 시도해주세요.");
}

    });
}
