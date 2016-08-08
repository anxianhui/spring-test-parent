;
(function() {
	$.fn.onlyNumAlpha = function() {
		return this.each(function() {
			var $this = $(this);
			$this.bind("keypress", function(event) {
				var eventObj = event || e;
				var keyCode = eventObj.keyCode || eventObj.which;
				if ((keyCode >= 48 && keyCode <= 57)
						|| (keyCode >= 65 && keyCode <= 90)
						|| (keyCode >= 97 && keyCode <= 122) || (keyCode == 8)
						|| (keyCode == 13) || (keyCode == 46)
						|| (keyCode == 37) || (keyCode == 39))
					return true;
				else
					return false;
			});
		});
	};
})(jQuery);

var numCount = 0;
$(function() {
	var SUCCESS = "SUCCESS";
	var isRight = false, checkTimeFlag = null, clickTimeFlag = null;
	$('#myImg_').click(
			function() {
				var $this = $(this);
				clearTimeout(clickTimeFlag);
				clickTimeFlag = setTimeout(function() {
					$this.attr("src", basePath + "/images/loading.gif");
					Imagess(basePath + "/stickyImg?method=buildCaptcha&t="
							+ new Date().getTime(), 'myImg_', showImg);
					isRight = false;
					setErrorMsg("");
					$('#captcha_').val("").focus();
					numCount = 0;
				}, '300');
			});

	$('#captcha_').onlyNumAlpha().keyup(
			function(event) {
				var $keyCode = event.keyCode;
				var $val = $(this).val().trim();
				if (($keyCode >= 48 && $keyCode <= 57)
						|| ($keyCode >= 65 && $keyCode <= 90)
						|| ($keyCode >= 97 && $keyCode <= 122))
					numCount++;
				else if ($keyCode == 8 || $keyCode == 46)
					numCount = $val.length;
				else {
				}
				isRight = false;
				if (numCount >= 7 || $val.length < 4)
					return;
				clearTimeout(checkTimeFlag);
				checkTimeFlag = setTimeout(function() {
					$.ajax({
						type : 'get',
						dataType : 'json',
						url : basePath + '/stickyImg?method=checkCaptcha',
						data : {
							'captcha_' : $val
						},
						success : function(result) {
							if (result.code != SUCCESS) {
								setErrorMsg(result.msg);
								isRight = false;
							} else {
								$('#errorMsg').text('').hide();
								isRight = true;
							}
						},
						error : function(XMLHttpRequest, textStatus,
								errorThrown) {
							setErrorMsg("系统异常，请稍候重试");
						}
					});
				}, '300');
			});

	/**
	 * 手动验证是否文本框输入值。（此处建议使用validition框架）
	 */
	$('#subBtn')
			.click(
					function() {
						var $name = $('#username_'), $pwd = $('#password_'), $captcha = $('#captcha_');
						var $nameVal = $name.val().trim(), $pwdVal = $pwd.val()
								.trim(), $captchaVal = $captcha.val().trim();
						if ($nameVal.length == 0) {
							$name.focus();
							setErrorMsg("请输入用户名");
							return false;
						}
						if ($pwdVal.length == 0) {
							$pwd.focus();
							setErrorMsg("请输入密码");
							return false;
						}
						if ($captchaVal.length < 4) {
							$captcha.focus();
							setErrorMsg("请输入6位验证码");
							return false;
						}
						return isRight;
					});

	// 判断浏览器
	var Browser = new Object();
	Browser.userAgent = window.navigator.userAgent.toLowerCase();
	Browser.ie = /msie/.test(Browser.userAgent);
	Browser.Moz = /gecko/.test(Browser.userAgent);

	// 判断是否加载完成
	function Imagess(url, imgid, callback) {
		var val = url;
		var img = new Image();
		if (Browser.ie) {
			img.onreadystatechange = function() {
				if (img.readyState == "complete" || img.readyState == "loaded") {
					callback(img, imgid);
				}
			};
		} else if (Browser.Moz) {
			img.onload = function() {
				if (img.complete == true) {
					callback(img, imgid);
				}
			};
		}
		// 如果因为网络或图片的原因发生异常，显示错误图片
		img.onerror = function() {
			img.src = basePath + "/images/failed.png";
		};
		img.src = val;
	}

	// 显示图片
	function showImg(obj, imgid) {
		document.getElementById(imgid).src = obj.src;
	}

	(function() {
		Imagess($('#myImg_').attr("targetSrc"), 'myImg_', showImg);
	})();

	$('.inputtip ').on("keypress", function(event) {
		if (event.keyCode == 9 || event.keyCode == 13)
			return;
		setErrorMsg("");
	});

	var $errorMsg = $('#errorMsg');
	var setErrorMsg = function(msg) {
		$errorMsg.html(msg).show();
	};

	/**
	 * 扩展string类，添加两边去空格
	 */
	String.prototype.trim = function() {
		return this.replace(/(^\s*)|(\s*$)/g, '');
	};
});
