<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>登录</title>
    <link rel="stylesheet" href="${base}/resources/login/css/login.css">
    <script type="text/javascript" src="${base}/resources/login/js/jquery.js"></script>
    <script type="text/javascript" src="${base}/resources/login/js/shopex.js"></script>
    <script type="text/javascript" src="${base}/resources/login/js/jquery.validate.js"></script>
</head>
<body>
   <div class="header">
       <span class="welcome">
           Hi,　欢迎您登录！
       </span>
       <span class="hotline">
           客服热线　40012345678
       </span>
   </div>
   <div class="banner">
       <div class="img">
           
       </div>
       <div class="login">
           <form action="" id="fm1">
            <div class="content">
               <p>欢迎登录</p>
               <div class="group">
                    <label class="control-label"><i class="i01"></i></label>
                    <div class="controls">
                       <input type="text" autocomplete="off" value="" class="text valid" placeholder="用户名/邮箱/已验证手机" name="userName" id="username_" aria-invalid="false">
                    </div>
                </div>
                <div class="group password-group">
                    <label class="control-label"><i class="i02"></i></label>
                    <div class="controls">
                        <input type="password" autocomplete="off" value="" class="text" placeholder="请输入密码" name="userPwd" >
                        <i class="pw-toggle" id="pw_tg"></i>
                    </div>
                </div>
                 <div id="errorMsg" class="msgs"></div>
                <div class="action">      
                  <input type="button" value="登 录" accesskey="l" id="subBtn" name="btn_Login" class="submit">
              </div>
            </div>
           </form>
       </div>
   </div>
   <div class="footer">
       <p>
           技术支持：XX 有限公司
       </p>
   </div>
   <script type="text/javascript">
        $(function() {
        	$('#subBtn').click(function(){
	        	$.ajax({
	              url : "${base}/login.json",
	              data : {
	                  'userName' : $('input[name="userName"]').val(),
	                  'userPwd' : $('input[name="userPwd"]').val()
	                  },
	              type : 'POST',
	              dataType : 'json',
	              beforeSend : function(){
	            	  if($('input[name="userName"]').val()==''||$('input[name="userName"]').val()=='请输入用户名'){
	            		  alert("请输入用户名");
	            		  return false;
	            	  }
	              },
	              success : function(jsonData){
	              	if(jsonData.success){
	              		window.location.href ="${base}/admin/main.htm";	   
	              	}else{
	              		alert(jsonData.message);
	              	}
	                            
	              }
	          });
        	})
        });
   </script>
</body>
</html>
