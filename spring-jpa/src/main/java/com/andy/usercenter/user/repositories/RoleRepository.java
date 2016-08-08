package com.andy.usercenter.user.repositories;


import org.springframework.data.repository.PagingAndSortingRepository;

import com.andy.usercenter.user.model.Role;



public interface RoleRepository extends PagingAndSortingRepository<Role, Long> {

}
