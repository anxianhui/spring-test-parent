/*
 * Copyright 2005-2013 kuanda.net. All rights reserved.
 * Support: http://www.kuanda.net
 * License: http://www.kuanda.net/license
 */
package com.andy.usercenter.user.service.base.impl;

import java.io.Serializable;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

import com.andy.usercenter.user.model.User;
import com.andy.usercenter.user.service.base.BaseService;

/**
 * Service - 基类
 * 
 */
@Transactional
public class BaseServiceImpl<T, ID extends Serializable> implements BaseService<T, ID> {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** repository */
	private PagingAndSortingRepository<T, ID> repository;
	

	public PagingAndSortingRepository<T, ID> getRepository() {
		return repository;
	}

	public void setRepository(PagingAndSortingRepository<T, ID> repository) {
		this.repository = repository;
	}

	@Override
	public T findOne(ID id) {
		return repository.findOne(id);
	}

	@Override
	public List<T> findAll() {
		return (List<T>)repository.findAll();
	}

	@Override
	public long count() {
		return repository.count();
	}

	@Override
	public boolean exists(ID id) {
		return repository.exists(id);
	}

	@Override
	public void save(T entity) {
		repository.save(entity);
	}

	@Override
	public T update(T entity) {
		return repository.save(entity);
	}

	@Override
	public T update(T entity, String... ignoreProperties) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(ID id) {
		repository.delete(id);
	}

	@Override
	public void delete(T entity) {
		repository.delete(entity);
	}

	@Override
	public Page<T> findAll(PageRequest pageable) {
		return (Page<T>)repository.findAll(pageable);
	}

}