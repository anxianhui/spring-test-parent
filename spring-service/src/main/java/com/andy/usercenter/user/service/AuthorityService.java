package com.andy.usercenter.user.service;

import java.util.List;

import com.andy.usercenter.user.model.Authority;
import com.andy.usercenter.user.service.base.BaseService;

public interface AuthorityService extends BaseService<Authority, Long> {

	List<Authority> findByParentIsNull();

}
