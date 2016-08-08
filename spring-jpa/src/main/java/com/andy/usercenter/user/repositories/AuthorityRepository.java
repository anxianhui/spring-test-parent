package com.andy.usercenter.user.repositories;


import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.andy.usercenter.user.model.Authority;



public interface AuthorityRepository extends PagingAndSortingRepository<Authority, Long> {

	
	public List<Authority> findByParentIsNull();
	
}
