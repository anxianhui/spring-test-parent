package com.andy.usercenter.user.model;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.aspectj.internal.lang.annotation.ajcDeclareSoft;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "t_user")
public class User extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1510225400849876281L;
	
	
	/**用户名. */
	private String userName;

	/** 密码. */
	@JsonIgnore
	private String userPwd;

	/** 密码盐. */
	@JsonIgnore
	private String pwdSalt;

	/** 是否启用 */
	private Boolean isEnabled;
	
	private String remark;
	
	@JsonIgnore
	private Set<Role> roles;

	@Column(nullable = false,  unique = true, length = 50)
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getPwdSalt() {
		return pwdSalt;
	}

	public void setPwdSalt(String pwdSalt) {
		this.pwdSalt = pwdSalt;
	}


	public Boolean getIsEnabled() {
		return isEnabled;
	}

	public void setIsEnabled(Boolean isEnabled) {
		this.isEnabled = isEnabled;
	}

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "xx_user_role",joinColumns={ @JoinColumn(name="user_id")}, 
			inverseJoinColumns={ @JoinColumn(name="role_id") } )
	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
