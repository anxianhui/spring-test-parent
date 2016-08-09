<#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>xx管理系统</title>
	<link rel="stylesheet" id="theme" type="text/css" href="${base}/resources/admin/easyui/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${base}/resources/admin/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${base}/resources/admin/style/layout.css">
	<link rel="stylesheet" type="text/css" href="${base}/resources/admin/style/common.css">

	<script type="text/javascript" src="${base}/resources/admin/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="${base}/resources/admin/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${base}/resources/admin/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="${base}/resources/admin/scripts/plugin/jquery.cookie.js"></script>	
	<script type="text/javascript" src="${base}/resources/admin/easyui/operateTabs.js"></script>
	<script type="text/javascript" src="${base}/resources/admin/scripts/module/common.js"></script>
	<script>
	$(document).ready(function() {
	
		 $('#themes').combobox({   
		    onChange : function(n,o){
		    	$.cookie('theme', n, { expires: 30 });
		    	$("#theme").attr("href");
		    	var url = $("#theme").attr("href");
	   			var href = url.substring(0, url.indexOf('themes')) + 'themes/' + n + '/easyui.css'; 
		   		$("#theme").attr("href",href);
			    var iframes = $('iframe');
			    if (iframes.length > 0) {
				    for (var i = 0; i < iframes.length; i++) {
				          var iframe = iframes[i];
				          $(iframe).contents().find('#theme').attr('href', href);
				    } 
				}
		    } 
		 });
		 
		var cookieTheme = $.cookie('theme');
		if(cookieTheme){
			$("#theme").attr("href");
	    	var url = $("#theme").attr("href");
			var href = url.substring(0, url.indexOf('themes')) + 'themes/' +cookieTheme + '/easyui.css'; 
	   		$("#theme").attr("href",href);
	   		$('#themes').combobox('setValue', cookieTheme);
		}
		
		$('#logout').click(function(){
			location.href="${base}/logout.htm";
		})
		
	  
		//新增
	    $('#resetbtn').bind('click', function(){
	     	 $('#resetdlg').dialog('open');
			 $('#resetform').form('clear');
	    });
	    
	  
		
	})
	
	
	  //新增
	function reset(){
		$('#resetform').form('submit',{
			success:function(data){
			   var data = eval('(' + data + ')');// change the JSON string to javascript object
		 	   if(data.status=='ok'){
			  	  $('#resetdlg').dialog('close');
			   	  $.messager.alert('操作提示', data.message, 'info');
			   }else{
		  		  $.messager.alert('操作提示', data.message, 'error');
			   }
		    }
		})
	}
	
	</script>
	
</head>
<body class="easyui-layout" >
	<div region="north" border="true" class="cs-north">
		<div class="cs-north-bg">
			<div class="cs-north-logo">xx管理系统</div>
			<div style="float: right; margin-right: 20px;margin-top:15px;">
				 当前用户：xxxx
	           	<a href="#" class="easyui-menubutton" data-options="menu:'#mm3'">控制面板</a> 
	           	切换皮肤:
	           	<select class="easyui-combobox" id="themes">
	           		<option value="default">default</option>
					<option value="black">black</option>
					<option value="bootstrap">bootstrap</option>
					<option value="gray">gray</option>
					<option value="metro">metro</option>
				</select>
            </div> 
		</div>
	</div>
	
	<div region="west" border="true" split="true" title="导航" class="cs-west">
		<div class="easyui-accordion "  border="false">
			
			<#list authorities as authority>
				<#list authority.children as child>
					<@shiro.hasPermission name = child.code>
						<div title="${authority.name}">
							<ul class="nav">
								<#list authority.children as child>
									<@shiro.hasPermission name = child.code>
										<li class="nav-item"><a href="javascript:void(0);" src="${base}/${child.url}" class="cs-navi-tab">${child.name}</a></li>
									</@shiro.hasPermission>
								</#list>
							</ul>
						</div>
						<!-- 发现有子权限就退出循环 -->
						<#break />
					</@shiro.hasPermission>
				</#list>
			</#list>
			
		</div>
	</div>
	
	<div id="mainPanle" region="center" border="true" border="false">
		 <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
                <div title="Home">
					<div class="cs-home-remark">
						<h1>欢饮使用xx后台管理系统</h1> <br>
					</div>
				</div>
        </div>
	</div>
	
	<div region="south" border="false" id="south"><center>xx@163.com</center></div>
	<div id="mm" class="easyui-menu cs-tab-menu">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseother">关闭其他</div>
		<div id="mm-tabcloseall">关闭全部</div>
	</div>
	
	<div id="mm3" style="width:100px;">
		<div id="resetbtn">修改密码</div>
		<div id="logout">退出</div>
	</div>
	
	<div id="resetdlg" class="easyui-dialog"  closed="true" buttons="#adddlg-buttons" title="修改密码">
		<div style="padding:10px 60px 20px 60px">
	   		<form id="resetform" action="${base}/admin/user/resetPassword.do" method="post">
		    	<table cellpadding="5">
		    		<tr>
		    			<td>原密码:</td>
		    			<td><input class="easyui-textbox" type="password" name="password" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>新密码:</td>
		    			<td><input class="easyui-textbox" type="password" id="newPassword" name="newPassword" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>确认密码:</td>
		    			<td><input class="easyui-textbox" type="password" name="rePassword" validType="equalTo['#newPassword']" invalidMessage="两次输入密码不匹配" data-options="required:true"></input></td>
		    		</tr>
		    	</table>
		    </form>
	    </div>
	</div>
	<div id="adddlg-buttons" style="text-align:center" >
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="reset()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#resetdlg').dialog('close')">取消</a>
	</div>
</body>
</html>