package com.andy.usercenter.user.service.impl;

import javax.annotation.Resource;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Service;

import com.andy.usercenter.user.model.Role;
import com.andy.usercenter.user.service.RoleService;
import com.andy.usercenter.user.service.base.impl.BaseServiceImpl;

@Service("roleService")
public class RoleServiceImpl extends BaseServiceImpl<Role, Long> implements RoleService{

	@Resource(name = "roleRepository")
	public void setRepository(PagingAndSortingRepository<Role,Long> repository) {
		super.setRepository(repository);
	}

}
