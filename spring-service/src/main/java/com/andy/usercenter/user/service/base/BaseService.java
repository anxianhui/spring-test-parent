/*
 * Copyright 2005-2013 kuanda.net. All rights reserved.
 * Support: http://www.kuanda.net
 * License: http://www.kuanda.net/license
 */
package com.andy.usercenter.user.service.base;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import com.andy.usercenter.user.model.User;


/**
 * Service - 基类
 * 
 */
public interface BaseService<T, ID extends Serializable> {

	/**
	 * 查找实体对象
	 * 
	 * @param id
	 *            ID
	 * @return 实体对象，若不存在则返回null
	 */
	T findOne(ID id);

	/**
	 * 查找所有实体对象集合
	 * 
	 * @return 所有实体对象集合
	 */
	List<T> findAll();

	
	Page<T> findAll(PageRequest pageable);
	
	/**
	 * 查询实体对象总数
	 * 
	 * @return 实体对象总数
	 */
	long count();

	/**
	 * 判断实体对象是否存在
	 * 
	 * @param id
	 *            ID
	 * @return 实体对象是否存在
	 */
	boolean exists(ID id);

	/**
	 * 保存实体对象
	 * 
	 * @param entity
	 *            实体对象
	 */
	void save(T entity);

	/**
	 * 更新实体对象
	 * 
	 * @param entity
	 *            实体对象
	 * @return 实体对象
	 */
	T update(T entity);

	/**
	 * 更新实体对象
	 * 
	 * @param entity
	 *            实体对象
	 * @param ignoreProperties
	 *            忽略属性
	 * @return 实体对象
	 */
	T update(T entity, String... ignoreProperties);

	/**
	 * 删除实体对象
	 * 
	 * @param id
	 *            ID
	 */
	void delete(ID id);

	/**
	 * 删除实体对象
	 * 
	 * @param entity
	 *            实体对象
	 */
	void delete(T entity);
}