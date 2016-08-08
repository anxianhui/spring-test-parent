function setTheme(){
    //确定皮肤
	var cookieTheme = $.cookie('theme');
	if(cookieTheme){
		$("#theme").attr("href");
    	var url = $("#theme").attr("href");
		var href = url.substring(0, url.indexOf('themes')) + 'themes/' +cookieTheme + '/easyui.css'; 
   		$("#theme").attr("href",href);
   		$('#themes').combobox('setValue', cookieTheme);
	}
}

function setYears(combobox,setValue){
 	 var thisYear=new Date().getUTCFullYear();//今年
	 var years = [];
	 years.push({"year":"","text":"请选择"});
	 for(var year=thisYear-1;year<thisYear+5;year++){
	 	 years.push({"year":year,"text":year});
	 }
	 $(combobox).combobox({   
		valueField:'year',    
		textField:'text',  
		panelHeight:'auto',
		panelWidth: 80,
		width : 80,
	 });
	 $(combobox).combobox("loadData", years);
	 if(setValue){
		 $(combobox).combobox("setValue",thisYear); 
	 }
}


function setMonths(combobox,setValue){
	 var thisMonth=new Date().getUTCMonth()+1;//本月
	 var months = [];
	 months.push({"month":"","text":"请选择"});
	 for(var month=1;month<13;month++){
	 	 months.push({"month":month,"text":month});
	 }
	 $(combobox).combobox({   
		valueField:'month',    
		textField:'text',  
		panelHeight:'auto',
		panelWidth: 80,
		width : 80,
	 });
	 $(combobox).combobox("loadData", months);
	 if(setValue){
		 $(combobox).combobox("setValue",thisMonth); 
	 }
}

$.extend($.fn.validatebox.defaults.rules, {  
    /*必须和某个字段相等*/
    equalTo: {
        validator:function(value,param){
            return $(param[0]).val() == value;
        },
        message:'字段不匹配'
    }
});
