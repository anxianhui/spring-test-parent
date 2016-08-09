package com.andy.usercenter.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Service;

import com.andy.usercenter.user.model.Authority;
import com.andy.usercenter.user.repositories.AuthorityRepository;
import com.andy.usercenter.user.service.AuthorityService;
import com.andy.usercenter.user.service.base.impl.BaseServiceImpl;

@Service("authorityService")
public class AuthorityServiceImpl extends BaseServiceImpl<Authority, Long> implements AuthorityService{

	@Resource(name = "authorityRepository")
	private AuthorityRepository authorityRepository;
	
	@Resource(name = "authorityRepository")
	public void setRepository(PagingAndSortingRepository<Authority,Long> repository) {
		super.setRepository(repository);
	}

	@Override
	public List<Authority> findByParentIsNull(){
		return authorityRepository.findByParentIsNull();
	}
	
}
