package com.andy.usercenter.user.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name = "t_authority")
public class Authority extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1510225400849876281L;

	private String name;
	
	private String url;
	
	private String code;
	
	private String introduction;

	private Authority parent;
	
	private Set<Authority> children;
	
	private Set<Role> roles = new HashSet<Role>();


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	public Authority getParent() {
		return parent;
	}

	public void setParent(Authority parent) {
		this.parent = parent;
	}

	@OneToMany(mappedBy = "parent", fetch = FetchType.LAZY)
	public Set<Authority> getChildren() {
		return children;
	}

	public void setChildren(Set<Authority> children) {
		this.children = children;
	}

	@ManyToMany(mappedBy = "authoritys", fetch = FetchType.LAZY)
	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	
	
}
