package com.andy.usercenter.user.repositories;


import org.springframework.data.repository.PagingAndSortingRepository;

import com.andy.usercenter.user.model.User;



public interface UserRepository extends PagingAndSortingRepository<User, Long> {
	
	public User findByUserName(String userName);
	

}
