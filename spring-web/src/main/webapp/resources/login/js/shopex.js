/**
 * @author bing
 */

var storeHostname = "http://fuli.ezhiyang.com";
var storeLogin = "/index.php/openapi/phpsso_member/sync_login";
var storeLogout = "/index.php/openapi/phpsso_member/sync_logout";


var storeloginStatus = false;
function loginShopex(form) {
	return true;
}

function logoutShopex() {
	if (!storeloginStatus) {
		$.ajax({
			url : storeHostname + storeLogout,
			dataType : "jsonp",
			success : function(result){
				console.log(result);
			}
		});
	}
	return storeloginStatus;
}
