<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="js/kakao.js">
    </script>
</head>

<body>

    <form action = "#" name = "loginForm" method="post">
        아이디 : <input type = "text" name = "id"><br>
        비밀번호 : <input type = "text" name = "pw"><br>

        <input type = "hidden" name = "email">
        <input type = "hidden" name = "name">
        <button type = "submit">로그인</button> 
    </form>
    <!-- 카카오로그인 버튼 -->
    <a id="custom-login-btn" href="javascript:loginWithKakao()">
        <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222" />
    </a>

    <!-- 카카오 로그아웃버튼 -->
    <button class="api-btn" onclick="kakaoLogout()">로그아웃</button>

    <script>
        //1. 카카오 초기화
        Kakao.init('86cd8cd247e3989f81b7f6587c700e3e');
        console.log(Kakao.isInitialized());

        //2.카카오 로그인버튼

        function loginWithKakao() {
            Kakao.Auth.loginForm({
                success: function (authObj) {
                    getInfo(); //사용자 정보요청 함수
                },
                fail: function (err) {
                    alert(JSON.stringify(err))
                },
                fail: function (err) {
                    alert('failed to login: ' + JSON.stringify(err))
                },
            })
        }

        //사용자 정보 얻기
        function getInfo() {
            Kakao.API.request({
                url: '/v2/user/me',
                success: function (res) {
                    console.log(res)

                    //아이디
                    var id = res.id;
                    //이메일
                    var email = res.kakao_account.email;
                    //이름
                    var name = res.kakao_account.profile.nickname;
                    //프로필 사진
                    var profile_img = res.kakao_account.profile.profile_image_url;

                    console.log(id, email, name, profile_img);

                    //폼 요청 url변경
                    document.loginForm.action = "xxx";
                    document.loginForm.id.value = id;
                    document.loginForm.email.value = "";
                    document.loginForm.name.value = name;
                    document.loginForm.submit();

                },
                fail: function (error) {
                    alert("사용자 요청 정보에 실패했습니다. 동의 항목을 확인하세요.")
                },
            })
        }
            //로그아웃
            function kakaoLogout() {
                if (!Kakao.Auth.getAccessToken()) {
                    alert('Not logged in.')
                    return
                }
                Kakao.Auth.logout(function () {
                    alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken())
                })
            }
    </script>
</body>

</html>