package com.nicolasguo.webtemplate.entity;

import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.nicolasguo.webtemplate.common.ProjectConfig;

@Entity
@Table(name = ProjectConfig.PREFIX + "_user")
public class User extends BaseEntityObject implements UserDetails {

	private static final long serialVersionUID = -9038525706596164283L;

	private String username;

	private String loginName;

	private String password;

	private boolean enabled;

	private Collection<? extends GrantedAuthority> authorities;

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return enabled;
	}

	@Override
	public String toString() {
		return "MyUserDetails [id=" + getId() + ", username=" + username + ", password=" + password + ", enabled="
				+ enabled + ", authorities=" + authorities + "]";
	}
}
