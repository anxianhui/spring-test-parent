package com.andy.usercenter.user.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "t_role")
public class Role extends BaseEntity {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1510225400849876281L;

	private String name;
	
	private String introduction;
	
	@JsonIgnore
	private Set<Authority> authoritys = new HashSet<Authority>(); 
	
	private Set<User> users;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "xx_role_authority",joinColumns={ @JoinColumn(name="role_id")}, 
				inverseJoinColumns={ @JoinColumn(name="authority_id") } )
	public Set<Authority> getAuthoritys() {
		return authoritys;
	}

	public void setAuthoritys(Set<Authority> authoritys) {
		this.authoritys = authoritys;
	}

	@ManyToMany(mappedBy = "roles", fetch = FetchType.LAZY)
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}
	
	
}
