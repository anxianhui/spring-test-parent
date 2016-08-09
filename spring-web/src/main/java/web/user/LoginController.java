package web.user;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.andy.usercenter.user.repositories.AuthorityRepository;

import web.common.Response;

@Controller
public class LoginController {

	@Resource
	private AuthorityRepository authorityRepository;

	/**
	 * To login.
	 *
	 * @param request
	 *            the request
	 * @return the string
	 */
	@RequestMapping("/login.htm")
	public String toLogin() {
		return "login";
	}

	@RequestMapping("/login.json")
	public ResponseEntity<Object> login(String userName, String userPwd) {
		AuthenticationToken token = new UsernamePasswordToken(userName, userPwd);
		try {
			SecurityUtils.getSubject().login(token);
			Long uid = (Long) SecurityUtils.getSubject().getPrincipal();
			System.out.println(uid);
			return Response.success();
		} catch (UnknownAccountException e) {
			return Response.fail("用户名不存在！");
		} catch (IncorrectCredentialsException e) {
			return Response.fail("密码错误！");
		} catch (DisabledAccountException e) {
			return Response.fail("账号被禁用！");
		}

	}

	@RequestMapping("/admin/main.htm")
	public String main(ModelMap model) {
		model.put("authorities", authorityRepository.findByParentIsNull());
		return "/admin/main";
	}

	@RequestMapping({ "/logout.htm" })
	public String logout() {
		SecurityUtils.getSubject().logout();
		return "redirect:/login.htm";
	}

}
