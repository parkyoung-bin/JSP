<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	
	<script src="js/kakao.js">
    </script>
    <style>
    .center{text-align:center; padding-left:30%; padding-right:30%; padding:30px; background="213.jpg";}
    body { background-size : cover;}
    
    .loginbtnForm{overflow:hidden; box-sizing:border-box;margin:0 auto; text-align: center; margin-bottom :10px; margin-top:10px}
	.id{margin-bottom: 10px;}
	.pw{margin-bottom: 10px;}
   .asd{ margin : 0 auto; width: 300px; border : 0px solid white; text-align:center; margin-top:50px}
   .kakaoBtn{ margin-top:50px}
    </style>
</head>
<body class="center"   background="1.jpg";>

<h2 style="color:white"> 실시간 자전거 대여 정보</h2>
<hr  style="color:white">
 <form action="login.user" name="loginForm" method="post"  class = "asd">
        
        <table  class = "allForm" align="center">
        	<tr class ="id" >
        		<td style="color:white">아이디</td> 
        		<td style="color:white">:</td>
        		<td><input type="text" name="id" ></td>
        	</tr>
        	<tr class ="pw">
        		<td style="color:white">비밀번호</td>
        		<td style="color:white">:</td>
        		<td><input type="password" name="pw"></td>
        	</tr>
		</table>
		
		
		<div class = "loginbtnForm">
		
        <button type="submit" onclick = "login()">로그인</button>

        <button type="button" onclick="location.href='joinForm.user'">회원가입</button> 
  
        </div> <!-- 로그인 버튼 폼 -->
        
    <!-- 카카오로그인버튼 -->
    <div class = "kakaoBtn">
    <a id="custom-login-btn" href="javascript:loginWithKakao()" >
        <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222" />
    </a>
    </div>
    </form>
    
    <script>
  
    function login() {

		if(document.reg_form.id.value == 0) {
			alert('아이디를 입력해주세요');
		return false; 
		
		}else if(document.reg_form.pw.value == 0){
			alert('비밀번호를 입력해주세요');	
			return false;
			
		}else{
			reg_form.submit();
		}
	}
    
  //1. 카카오 초기화
    Kakao.init('21dacd05a4f6f56d008ee3ba02ad3564');
    console.log(Kakao.isInitialized());

    //2. 카카오 로그인 버튼
    function loginWithKakao() {
    	
        Kakao.Auth.loginForm({
            // success: function(authObj) {
            //     alert(JSON.stringify(authObj))
            // },
            // fail: function(err) {
            //     alert(JSON.stringify(err))
            // },
            success: function (authObj) {
                getInfo(); //사용자 정보요청 함수 호출
                //alert(JSON.stringify(authObj))
                //HttpServletResponse response = new HttpServletResponse;
                //response.sendRedirection("loginForm.user");
            },
            fail: function (err) {
                alert('failed to login: ' + JSON.stringify(err))
            },

        })
    }
 



    //3. 사용자 정보 얻기
    function getInfo() {

        Kakao.API.request({
            url: '/v2/user/me',
            success: function (res) {
                //alert(JSON.stringify(res))
                console.log(res)

                //아래의 코드로 id추출
                var id = res.id;
                var email = res.kakao_account.email;
                var name = res.kakao_account.profile.nickname;
                //var profile_img = res.kakao_account.profile.profile_image_url;

                console.log(id, email, name);

                //폼 요청 url변경
                document.loginForm.action = "map.user";
                //폼 id의 value를 변경
                document.loginForm.id.value = id;
                //

                document.loginForm.name.value = name;

                document.loginForm.submit(); //서브밋


            },
            fail: function (error) {
                alert(
                    /* 'login success, but failed to request user information: ' +
                    JSON.stringify(error) */
                    "사용자 요청 정보에 실패했습니다. 동의항목을 확인하세요."
                )
            },
        })

    }

    //4. 카카오 로그아웃 버튼
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