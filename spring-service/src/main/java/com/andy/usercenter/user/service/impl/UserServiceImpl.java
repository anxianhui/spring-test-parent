package com.andy.usercenter.user.service.impl;

import javax.annotation.Resource;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Service;

import com.andy.usercenter.user.model.User;
import com.andy.usercenter.user.service.UserService;
import com.andy.usercenter.user.service.base.impl.BaseServiceImpl;

@Service("userService")
public class UserServiceImpl extends BaseServiceImpl<User, Long> implements UserService{

	@Resource(name = "userRepository")
	public void setRepository(PagingAndSortingRepository<User,Long> repository) {
		super.setRepository(repository);
	}

}
