package com.nicolasguo.webtemplate.service;

import java.io.Serializable;
import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.icloud.condition.impl.AccountCondition;

public interface AccountService<T, PK extends Serializable> extends UserDetailsService {

	public T getAccount(PK id);
	
	public T loadAccount(PK id);
	
	public List<T> findAccountByProperty(String propertyName, String propertyValue);
	
	public List<T> findAccountByCondition(AccountCondition condition);

	public void updateAccount(T entity);

	public void saveAccount(T entity);

	public void deleteAccount(T entity);
	
	public void deleteAccounts(List<T> list);
}
