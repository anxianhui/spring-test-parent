package web.user;

import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.andy.shiro.PasswordUtils;
import com.andy.shiro.PasswordUtils.Password;
import com.andy.usercenter.user.model.Role;
import com.andy.usercenter.user.model.User;
import com.andy.usercenter.user.service.RoleService;
import com.andy.usercenter.user.service.UserService;

import web.common.Pagination;
import web.common.Response;

@Controller
@RequestMapping("admin/user")
public class UserController {

	@Resource
	private UserService userService;

	@Resource
	private RoleService roleService;

	@RequestMapping("list.htm")
	public String listHtml(Map<String, Object> model) {
		model.put("roles", roleService.findAll());
		return "admin/user/list";
	}

	@RequestMapping("list.json")
	public void list(Pagination<User> pagination, Map<String, Object> model) throws IOException {
		PageRequest pageable = new PageRequest(pagination.getPage()-1, pagination.getRows());
		Page<User> page = userService.findAll(pageable);
		pagination.setResult(page.getContent());
		pagination.setTotal(page.getTotalElements());
		model.put("total", page.getTotalElements());
		model.put("rows", page.getContent());
	}

	@RequestMapping("save")
	public ResponseEntity<Object> save(User user, Long roleId) {
		Password password = PasswordUtils.encryptPwd(user.getUserPwd());
		user.setUserPwd(password.getPwd());
		user.setPwdSalt(password.getPwdSalt());
		user.setIsEnabled(true);
		user.setCreateDate(new Date());

		Set<Role> roles = new HashSet<Role>();
		roles.add(roleService.findOne(roleId));
		user.setRoles(roles);
		userService.save(user);
		return Response.success();
	}

	@RequestMapping({ "/update" })
	public ResponseEntity<Object> update(User user, Long roleId) {
		Password password = PasswordUtils.encryptPwd(user.getUserPwd());
		user.setUserPwd(password.getPwd());
		user.setPwdSalt(password.getPwdSalt());
		user.setIsEnabled(true);

		Set<Role> roles = new HashSet<Role>();
		roles.add(roleService.findOne(roleId));
		user.setRoles(roles);
		userService.save(user);
		return Response.success();
	}

	@RequestMapping({ "/load" })
	public void load(Long id, Map<String, Object> model) throws IOException {
		User user = userService.findOne(id);
		model.put("user", user);
	}

	@RequestMapping({ "/remove" })
	public ResponseEntity<Object> remove(Long id) {
		userService.delete(id);
		return Response.success();
	}

	@RequestMapping("enableOrDisenable")
	public ResponseEntity<Object> enableOrDisenable(Long id, boolean isEnabled) {
		User user = userService.findOne(id);
		user.setIsEnabled(isEnabled);
		userService.save(user);
		return Response.success();
	}

}
