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
				   $.messager.alert('操作提示', '添加员工成功！', 'info');
				   search();
		    }
		})
	}
	
	//修改
	function edit(){
		$('#editform').form('submit',{
			success:function(data){
				   $('#editdlg').dialog('close');
				   $.messager.alert('操作提示', '修改员工成功！', 'info');
				   search();
		    }
		})
	}
$(function(){
		
    //初始化table
	$('#grid').datagrid({
		rownumbers:true,
		fitColumns:true,
		url: '${base}/admin/role/list.json',
		columns: [[   
		            {field:'name',title:'角色',width:120, align: 'center'},
		            {field:'introduction',title:'说明',width:120, align: 'center'},
		            {field:'createtime',title:'创建时间',width:100, align: 'center'},
		            {field:'operation', title :'操作', width:80, align : 'center', 
                           formatter : function ( colValue , rowData , rowIndex ) {
                        	   var menu = "<div class='op-menu' >";
                               menu += "<a href='${base}/admin/role/edit.htm?id="+rowData.id+"' class='easyui-linkbutton roleEdit' >修改</a></div>";
                               return menu;
                           } 
                    }
		          ]],
		idField: 'id',
		pagination: true,
		pageNumber: 0,
		pageSize : 20,
		striped: true,
		method: 'get',
		singleSelect: true,
		onLoadSuccess: function(ajaxData){
			$('.roleEdit').linkbutton({
				iconCls:'icon-edit'
			});
		}
	});


	//查询
    $('#searchBtn').bind('click', function(){
 	   search();
    });
    
	//新增
	/**
    $('#addbtn').bind('click', function(){
     	 $('#adddlg').dialog('open');
		 $('#addform').form('clear');
    });
   **/ 
    //修改
    $('#editbtn').bind('click', function(){
        var row = $('#grid').datagrid('getSelected');
	    if (!row){
	        $.messager.alert("操作提示", "请先选择员工！","error");
	    	return;
	    }
		 $('#editdlg').dialog('open');
		 $('#editform').form('clear');
		 $('#editform').form('load', '${base}/admin/role/load.json?id='+row.id);
    });
    
    //删除
    $('#removebtn').bind('click', function(){
        var row = $('#grid').datagrid('getSelected');
	    if (!row){
	        $.messager.alert("操作提示", "请先选择员工！","error");
	    	return;
	    }else{
	    	$.messager.confirm('确认','您确认想要删除记录吗？',function(r){   
			    if (r){   
			       $.ajax({
						type: 'POST',
						url: '${base}/admin/role/remove.do',
						data: {id:row.id},
						dataType: 'json',
						success: function(data){
							//$.messager.alert('操作提示', '删除员工成功！', 'info');
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
			<a href="${base}/admin/role/add.htm" id="addbtn" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a>
			<a href="#" id="editbtn" onclick="$('#w').window('open')" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
			<a href="#" id="removebtn" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
		</div>
		<div id="search" style="padding:2px 5px;">
			姓名: <input class="easyui-textbox" id="name" name="name" style="width:110px">
			<a href="#" class="easyui-linkbutton" id="searchBtn" iconCls="icon-search">查询</a>
		</div>
	</div>
	
	
</body>
</html>