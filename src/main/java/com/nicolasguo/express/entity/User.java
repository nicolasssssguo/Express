package com.nicolasguo.express.entity;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.nicolasguo.express.common.ProjectConfig;

@Entity
@Table(name = ProjectConfig.PREFIX + "_user")
public class User extends BaseEntityObject implements UserDetails {

	private static final long serialVersionUID = -9038525706596164283L;

	private String username;

	private String loginName;

	private String password;

	private boolean enabled;

	private Collection<? extends GrantedAuthority> authorities;

	@Column(length=255)
	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	@Transient
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Column(length=255)
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

	@Column(length=255)
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}

	@Transient
	public boolean isAccountNonExpired() {
		return true;
	}

	@Transient
	public boolean isAccountNonLocked() {
		return true;
	}

	@Transient
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Transient
	public boolean isEnabled() {
		return enabled;
	}

	@Override
	public String toString() {
		return "MyUserDetails [id=" + getId() + ", username=" + username + ", password=" + password + ", enabled="
				+ enabled + ", authorities=" + authorities + "]";
	}
}
