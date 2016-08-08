<html class="panel-fit">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" id="theme" type="text/css" href="${base}/resources/admin/easyui/themes/metro/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${base}/resources/admin/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${base}/resources/admin/style/layout.css">
	<link rel="stylesheet" type="text/css" href="${base}/resources/admin/style/common.css">
	<script type="text/javascript" src="${base}/resources/admin/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="${base}/resources/admin/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${base}/resources/admin/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="${base}/resources/admin/easyui/extends/datagrid-scrollview.js"></script>
	<script type="text/javascript" src="${base}/resources/admin/scripts/plugin/jquery.cookie.js"></script>			
	
</head>
<script type="text/javascript">
var relative ="${base}";

	//查询
	function search(){
		queryMap={};
		queryMap.name=$("#name").val();
		$('#grid').datagrid('reload',{
	   		queryParams:queryMap,
	    });
	}
	
	//新增
	function add(){
		$('#addform').form('submit',{
			success:function(data){
			   $('#adddlg').dialog('close');
			   $.messager.alert('操作提示', '添加用户成功！', 'info');
			   search();
		    }
		})
	}
	
	//修改
	function edit(){
		$('#editform').form('submit',{
			success:function(data){
				$('#editdlg').dialog('close');
			  	$.messager.alert('操作提示', '修改用户成功！', 'info');
			   	search();
		    }
		})
	}
$(function(){
		
    //初始化table
	$('#grid').datagrid({
		rownumbers:true,
		fitColumns:true,
		url: relative + '/admin/user/list.json',
		columns: [[   
		            {field:'userName',title:'用户名',width:120, align: 'center'},
		            {field:'isEnabled',title:'状态',width:120, align: 'center',
		            	formatter: function(colValue , rowData , rowIndex){
		            		var statusName = '';
		            		if(colValue){
		            			statusName = '<input class="easyui-switchbutton" checked>';
		            		}else {
		            			statusName = '<input class="easyui-switchbutton" >';
		            		}
		            		return statusName;
		            	}
	             	},
		            {field:'createDate',title:'创建时间',width:100, align: 'center'}
		          ]],
		idField: 'id',
		pagination: true,
		pageNumber: 0,
		pageSize : 20,
		striped: true,
		method: 'get',
		singleSelect: true,
		onLoadSuccess: function(ajaxData){
			$('.easyui-switchbutton').each(function(index, item){
				$(this).switchbutton({
		            onText:'启用',
		            offText:'禁用',
		            onChange: function(checked){
		           		var isEnabled=true;
		            	if(checked){
	            			isEnabled=true;
		            	}else{
		            		isEnabled=false;
		            	}
		            	$.ajax({
							type: 'POST',
							url: '${base}/admin/user/enableOrDisenable.do',
							data: {
									id:ajaxData.rows[index].id,
							  		isEnabled:isEnabled,
								   },
							dataType: 'json',
							success: function(data){
							
							}
						}); 
		            }
		        })
				
			})
        	
		}
	});


	//查询
    $('#searchBtn').bind('click', function(){
 	   search();
    });
    
	//新增
    $('#addbtn').bind('click', function(){
     	 $('#adddlg').dialog('open');
		 $('#addform').form('clear');
    });
    
    //修改
    $('#editbtn').bind('click', function(){
        var row = $('#grid').datagrid('getSelected');
	    if (!row){
	        $.messager.alert("操作提示", "请先选择用户！","error");
	    	return;
	    }
		 $('#editdlg').dialog('open');
		 $('#editform').form('clear');
		 $('#editform').form('load', '${base}/admin/user/load.json?id='+row.id);
    });
    
    //删除
    $('#removebtn').bind('click', function(){
        var row = $('#grid').datagrid('getSelected');
	    if (!row){
	        $.messager.alert("操作提示", "请先选择用户！","error");
	    	return;
	    }else{
	    	$.messager.confirm('确认','您确认想要删除记录吗？',function(r){   
			    if (r){   
			       $.ajax({
						type: 'POST',
						url: '${base}/admin/user/remove.do',
						data: {id:row.id},
						dataType: 'json',
						success: function(data){
							//$.messager.alert('操作提示', '删除用户成功！', 'info');
							search();
						}
					}); 
			    }   
			});  
	    }
		
    });
    
    //确定皮肤
	var cookieTheme = $.cookie('theme');
	if(cookieTheme){
		$("#theme").attr("href");
    	var url = $("#theme").attr("href");
		var href = url.substring(0, url.indexOf('themes')) + 'themes/' +cookieTheme + '/easyui.css'; 
   		$("#theme").attr("href",href);
   		$('#themes').combobox('setValue', cookieTheme);
	}
});


</script>

<body>

	<table id="grid" fit="true" data-options="toolbar:'#toolbar'"></table>
	
	<div id="toolbar" style="padding:5px;height:auto">
		<div style="margin-bottom:5px">
			<a href="#" id="addbtn" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a>
			<a href="#" id="editbtn" onclick="$('#w').window('open')" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
			<a href="#" id="removebtn" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
		</div>
		<div id="search" style="padding:2px 5px;">
			姓名: <input class="easyui-textbox" id="name" name="name" style="width:110px">
			<a href="#" class="easyui-linkbutton" id="searchBtn" iconCls="icon-search">查询</a>
		</div>
	</div>
	
	<div id="adddlg" class="easyui-dialog"  closed="true" buttons="#adddlg-buttons" title="新增用户">
		<div style="padding:10px 60px 20px 60px">
	   		<form id="addform" action="${base}/admin/user/save.do" method="post">
		    	<table cellpadding="5">
		    		<tr>
		    			<td>用户名:</td>
		    			<td><input class="easyui-textbox" type="text" name="userName" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>密码:</td>
		    			<td><input class="easyui-textbox" type="password" name="userPwd" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>角色:</td>
		    			<td>
			    			<select class="easyui-combobox" name="roleId" data-options="required:false">
							  	<#list roles as role>
							  		<option value="${role.id}">${role.name}</option> 
							  	</#list>
							</select>
						</td>
		    		</tr>
		    		<tr>
		    			<td>备注:</td>
		    			<td><input class="easyui-textbox" name="remark" data-options="multiline:true" style="height:60px"></input></td>
		    		</tr>
		    	</table>
		    </form>
	    </div>
	</div>
	<div id="adddlg-buttons" style="text-align:center" >
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="add()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#adddlg').dialog('close')">取消</a>
	</div>
	
	
	<div id="editdlg" class="easyui-dialog"  closed="true" buttons="#editdlg-buttons" title="修改用户">
		<div style="padding:10px 60px 20px 60px">
	   		<form id="editform" action="${base}/admin/user/update.do" method="post">
		    	<input type="text" name="id" style="display:none;"></input>
		    	<table cellpadding="5">
		    		<tr>
		    			<td>用户名:</td>
		    			<td><input class="easyui-textbox" type="text" name="userName" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>密码:</td>
		    			<td><input class="easyui-textbox" type="password" name="userPwd" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>角色:</td>
		    			<td>
			    			<select class="easyui-combobox" name="roleId" data-options="required:true">
				          		<#list roles as role>
							  		<option value="${role.id}">${role.name}</option> 
							  	</#list>
							</select>
						</td>
		    		</tr>
		    		<tr>
		    			<td>备注:</td>
		    			<td><input class="easyui-textbox" name="remark" data-options="multiline:true" style="height:60px"></input></td>
		    		</tr>
		    	</table>
		    </form>
	    </div>
	</div>
	<div id="editdlg-buttons" style="text-align:center" >
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="edit()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#editdlg').dialog('close')">取消</a>
	</div>
	
</body>
</html>