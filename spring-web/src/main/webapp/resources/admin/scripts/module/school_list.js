$(document).ready(function(){
	schoolList();
});

function schoolList(){
	var queryMap = {};
	var data = {};
	queryMap.name = $('input[name="name"]').val();
	data.queryMap=queryMap;
	var grid = $('#grid').datagrid({
		rownumbers:true,
		fitColumns:true,
		url: relative + 'admin/schoolList.json',
		columns: [[   
		            {field:'name',title:'学校名称',width:120, align: 'center'},
		            {field:'createTime',title:'创建时间',width:80, align: 'center'}
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
