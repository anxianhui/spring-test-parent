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
<style>
.authorities label {
    display: block;
    float: left;
    min-width: 120px;
    padding-right: 4px;
}
a {
    text-decoration: none;
}

</style>
<script type="text/javascript">

//新增
function edit(){
	$('#editform').form('submit',{
		success:function(data){
			   location.href="${base}/admin/role/list.htm";
			  // $.messager.alert('操作提示', '添加员工成功！', 'info');
	    }
	})
}
$(function(){
	$('.selectAll').click(function() {
		var $this = $(this);
		var $thisCheckbox = $this.closest("tr").find(":checkbox");
		if ($thisCheckbox.filter(":checked").size() > 0) {
			$thisCheckbox.prop("checked", false);
		} else {
			$thisCheckbox.prop("checked", true);
		}
		return false;
	});
	
});
</script>
<body>
	<form id="editform" action="${base}/admin/role/update.do" method="post">
	<input class="easyui-textbox" type="hidden" name="id" data-options="required:true" value="${role.id}"></input>
		<table cellpadding="5" style="padding-top:50px;" align="center">
			<tr>
				<th>
					名称:
				</th>
				<td>
					<input class="easyui-textbox" type="text" name="name" data-options="required:true" value="${role.name}"></input>
				</td>
			</tr>
			<tr>
				<th>
					描述:
				</th>
				<td>
					<input class="easyui-textbox" name="introduction" data-options="multiline:true" style="height:60px"  value="${role.introduction}"></input>
				</td>
			</tr>
			
			
			<tr>
				<td colspan="2">
					&nbsp;
				</td>
			</tr>
			
			<#list authorities as authority>
				<tr>
					<th><a title="全选此组权限" class="selectAll" href="javascript:;">${authority.name}:</a></th>
					<td>
						<span class="fieldSet">
							<#list authority.children as child>
								<label>
									<input type="checkbox"  value="${child.id}" name="authorities"
									<#list role.authoritys as roleAuthority><#if roleAuthority.id=child.id> checked="checked"</#if></#list> >
									${child.name}          
								</label>
							</#list>
						</span>
					</td>
				</tr>
			</#list>
			
			<tr>
				<th>
				</th>
				<td>
					<div id="editdlg-buttons" style="text-align:center" >
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="edit()">保存</a>
						<a href="${base}/admin/role/list.htm" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" >返回</a> 
					</div>	
				</td>
			</tr>
		</table>
	</form>
</body>
</html>