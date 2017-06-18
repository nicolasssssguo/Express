package com.nicolasguo.webtemplate.service.impl;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.nicolasguo.webtemplate.entity.Role;
import com.nicolasguo.webtemplate.service.RoleService;


public class RoleServiceImpl implements RoleService<Role, String> {
	
	@Transactional
	public void saveRole(Role entity) {
		
	}

	@Transactional
	public void updateRole(Role entity) {
		
	}

	@Transactional
	public void deleteRole(Role entity) {
		
	}
	
	@Override
	public Role getRole(String id) {
		return null;
	}

	@Override
	public List<Role> findRoleByProperty(String propertyName,
			String propertyValue) {
		return null;
	}
}
