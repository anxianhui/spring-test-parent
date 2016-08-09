$(document).ready(function(){
	userList();
});

/** 未审核视频列表 */
function userList(){
	var queryMap = {};
	var data = {};
	queryMap.realName = $('input[name="realName"]').val();
	queryMap.roleId = $('input[name="roleId"]').val();
	data.queryMap=queryMap;
	var grid = $('#grid').datagrid({
		rownumbers:true,
		fitColumns:true,
		url: relative + 'user/admin/userList.json',
		columns: [[   
		            {field:'realName',title:'姓名',width:120, align: 'center'},
		            {field:'gender',title:'性别',width:80, align: 'center',
		            	formatter: function(colValue , rowData , rowIndex){
		            		var genderName = '';
		            		if(colValue == 'M'){
		            			genderName = '男';
		            		}else if(colValue == 'F'){
		            			genderName = '女';
		            		}else{
		            			genderName = '未知';
		            		}
		            		return genderName;
		            	}},
		            {field:'roleNames',title:'角色',width:120, align: 'center'},
		            {field:'cardNumber',title:'证件号码',width:100, align: 'center'},
		            { title : '操作', field : 'operation', width : 80, align : 'center', 
                           formatter : function ( colValue , rowData , rowIndex ) {
                        	   var menu = "<div id='op-menu-" + rowIndex + "' class='op-menu'>";
                               menu += "<a href='javascript:void(0);' class='a-btn audit'>修改角色</a></div>";
                               return menu;
                           } 
                     }
		          ]],
		idField: 'id',
		pagination: true,
		pageNumber: 1,
		pageSize : 20,
		striped: true,
		method: 'get',
		singleSelect: true,
		queryParams:data,
		onLoadSuccess: function(ajaxData){
			resize();
			$('.op-menu').each(function(index, item){
				var $opt = $(this);
				var id = ajaxData.rows[index]['id'];
				if($opt.find('.audit').length > 0){
					$opt.find('.audit').linkbutton({
                    }).bind('click', function(){
                    	editRole(id);
                    });
				}
			});
		}
	});
	function resize(){
		grid.datagrid('resize', {height: parent.$('body').layout('panel', 'center').height() - 50});
	}
	$(window).unbind('resize.grid').bind('resize.grid', function(event){
        resize();
    });
}
