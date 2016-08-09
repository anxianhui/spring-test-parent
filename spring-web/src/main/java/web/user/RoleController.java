package web.user;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.andy.usercenter.user.model.Authority;
import com.andy.usercenter.user.model.Role;
import com.andy.usercenter.user.model.User;
import com.andy.usercenter.user.service.AuthorityService;
import com.andy.usercenter.user.service.RoleService;
import com.andy.usercenter.user.service.UserService;

import web.common.Pagination;
import web.common.Response;

@Controller
@RequestMapping("admin/role")
public class RoleController {

	@Resource
	private UserService userService;

	@Resource
	private RoleService roleService;

	@Resource
	private AuthorityService authorityService;

	@RequestMapping("list.htm")
	public String listHtml() {
		return "admin/role/list";
	}

	@RequestMapping("list.json")
	public void list(Pagination<User> pagination, Map<String, Object> model) throws IOException {
		PageRequest pageable = new PageRequest(pagination.getPage() - 1, pagination.getRows());
		Page<Role> page = roleService.findAll(pageable);
		model.put("total", page.getTotalElements());
		model.put("rows", page.getContent());
	}

	@RequestMapping({ "/add.htm" })
	public String add(Map<String, Object> model) throws IOException {
		List<Authority> authorities = this.authorityService.findByParentIsNull();
		model.put("authorities", authorities);
		return "/admin/role/add";
	}

	@RequestMapping({ "/save.do" })
	public ResponseEntity<Object>  save(Role role, Long[] authorities) {
		role.setCreateDate(new Date());
		for (int i = 0; i < authorities.length; i++) {
			Authority authority = new Authority();
			authority.setId(authorities[i]);
			role.getAuthoritys().add(authority);
		}
		roleService.save(role);
		return Response.success();
	}

	@RequestMapping({ "/edit.htm" })
	public String edit(Long id, Map<String, Object> model) {
		Role role = roleService.findOne(id);
		List<Authority> authorities = this.authorityService.findByParentIsNull();
		model.put("authorities", authorities);
		model.put("role", role);
		return "/admin/role/edit";
	}
	
	@RequestMapping({ "/update.do" })
	public ResponseEntity<Object>  update(Role role, Long[] authorities) {
		role.setModifyDate(new Date());
		for (int i = 0; i < authorities.length; i++) {
			Authority authority = new Authority();
			authority.setId(authorities[i]);
			role.getAuthoritys().add(authority);
		}
		roleService.save(role);
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
