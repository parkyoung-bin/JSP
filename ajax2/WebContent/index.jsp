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

<h2 style="color:white"> �ǽð� ������ �뿩 ����</h2>
<hr  style="color:white">
 <form action="login.user" name="loginForm" method="post"  class = "asd">
        
        <table  class = "allForm" align="center">
        	<tr class ="id" >
        		<td style="color:white">���̵�</td> 
        		<td style="color:white">:</td>
        		<td><input type="text" name="id" ></td>
        	</tr>
        	<tr class ="pw">
        		<td style="color:white">��й�ȣ</td>
        		<td style="color:white">:</td>
        		<td><input type="password" name="pw"></td>
        	</tr>
		</table>
		
		
		<div class = "loginbtnForm">
		
        <button type="submit" onclick = "login()">�α���</button>

        <button type="button" onclick="location.href='joinForm.user'">ȸ������</button> 
  
        </div> <!-- �α��� ��ư �� -->
        
    <!-- īī���α��ι�ư -->
    <div class = "kakaoBtn">
    <a id="custom-login-btn" href="javascript:loginWithKakao()" >
        <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222" />
    </a>
    </div>
    </form>
    
    <script>
  
    function login() {

		if(document.reg_form.id.value == 0) {
			alert('���̵� �Է����ּ���');
		return false; 
		
		}else if(document.reg_form.pw.value == 0){
			alert('��й�ȣ�� �Է����ּ���');	
			return false;
			
		}else{
			reg_form.submit();
		}
	}
    
  //1. īī�� �ʱ�ȭ
    Kakao.init('21dacd05a4f6f56d008ee3ba02ad3564');
    console.log(Kakao.isInitialized());

    //2. īī�� �α��� ��ư
    function loginWithKakao() {
    	
        Kakao.Auth.loginForm({
            // success: function(authObj) {
            //     alert(JSON.stringify(authObj))
            // },
            // fail: function(err) {
            //     alert(JSON.stringify(err))
            // },
            success: function (authObj) {
                getInfo(); //����� ������û �Լ� ȣ��
                //alert(JSON.stringify(authObj))
                //HttpServletResponse response = new HttpServletResponse;
                //response.sendRedirection("loginForm.user");
            },
            fail: function (err) {
                alert('failed to login: ' + JSON.stringify(err))
            },

        })
    }
 



    //3. ����� ���� ���
    function getInfo() {

        Kakao.API.request({
            url: '/v2/user/me',
            success: function (res) {
                //alert(JSON.stringify(res))
                console.log(res)

                //�Ʒ��� �ڵ�� id����
                var id = res.id;
                var email = res.kakao_account.email;
                var name = res.kakao_account.profile.nickname;
                //var profile_img = res.kakao_account.profile.profile_image_url;

                console.log(id, email, name);

                //�� ��û url����
                document.loginForm.action = "map.user";
                //�� id�� value�� ����
                document.loginForm.id.value = id;
                //

                document.loginForm.name.value = name;

                document.loginForm.submit(); //�����


            },
            fail: function (error) {
                alert(
                    /* 'login success, but failed to request user information: ' +
                    JSON.stringify(error) */
                    "����� ��û ������ �����߽��ϴ�. �����׸��� Ȯ���ϼ���."
                )
            },
        })

    }

    //4. īī�� �α׾ƿ� ��ư
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