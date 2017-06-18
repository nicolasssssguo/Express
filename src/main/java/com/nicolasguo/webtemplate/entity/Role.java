package com.nicolasguo.webtemplate.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;

import com.nicolasguo.webtemplate.common.ProjectConfig;

@Entity
@Table(name = ProjectConfig.PREFIX + "_role")
public class Role extends BaseEntityObject implements GrantedAuthority{

	private static final long serialVersionUID = 635469332843374297L;

	private String roleName;

	@Column(length = 255)
	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	@Override
	public String getAuthority() {
		return roleName;
	}
}
