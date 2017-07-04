package com.nicolasguo.express.service;

import java.io.Serializable;
import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.nicolasguo.express.condition.impl.UserCondition;

public interface UserService<T, PK extends Serializable> extends UserDetailsService {

	public T getUser(PK id);

	public T loadUser(PK id);

	public List<T> findUserByProperty(String propertyName, String propertyValue);

	@SuppressWarnings("rawtypes")
	public List<T> findUserByCondition(UserCondition condition);

	public void updateUser(T entity);

	public void saveUser(T entity);

	public void deleteUser(T entity);

	public void deleteUsers(List<T> list);

}
