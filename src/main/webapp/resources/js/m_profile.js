// 모달 열기
function openProfileModal() {
    document.getElementById("profileModal").style.display = "block";
}

// 모달 닫기
function closeProfileModal() {
    document.getElementById("profileModal").style.display = "none";
}

// 닉네임 중복 체크
function checkNickname(nickname) {
    if (nickname.length > 0) {
        $.ajax({
            type: "POST",
            url: "/checkNickname",
            data: {nickname: nickname},
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

// 프로필 수정
function updateProfile() {
    let formData = new FormData($("#profileForm")[0]);

    $.ajax({
        type: "POST",
        url: "/updateProfile",
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response === "success") {
                alert("프로필이 성공적으로 업데이트되었습니다.");
                closeProfileModal();
                location.reload();
            } else {
                alert("프로필 업데이트에 실패했습니다.");
            }
        }
    });
}
