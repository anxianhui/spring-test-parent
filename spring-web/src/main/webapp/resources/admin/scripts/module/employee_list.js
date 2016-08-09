$(document).ready(function(){
	
	employeeList();
	
});

function employeeList(){
	$('#grid').datagrid({
		rownumbers:true,
		fitColumns:true,
		url: relative + 'admin/employee/list.json',
		columns: [[   
		            {field:'name',title:'姓名',width:120, align: 'center'},
		            {field:'email',title:'邮箱',width:120, align: 'center'},
		            {field:'phone',title:'手机',width:120, align: 'center'},
		            {field:'idcard',title:'证件号码',width:100, align: 'center'},
		            {field:'createtime',title:'创建时间',width:100, align: 'center'}
		          ]],
		idField: 'id',
		pagination: true,
		pageNumber: 1,
		pageSize : 20,
		striped: true,
		method: 'get',
		singleSelect: true,
	});
}

