package com.nicolasguo.express.service;

import java.io.Serializable;
import java.util.List;

import com.nicolasguo.express.condition.impl.CustomerCondition;

public interface CustomerService<T, PK extends Serializable> {
	
	public T getCustomer(PK id);

	public T loadCustomer(PK id);

	public List<T> findCustomerByProperty(String propertyName, Object propertyValue);

	@SuppressWarnings("rawtypes")
	public List<T> findCustomerByCondition(CustomerCondition condition);

	public void updateCustomer(T entity);

	public void saveCustomer(T entity);

	public void deleteCustomer(T entity);

	public void deleteCustomers(List<T> list);
	
}
