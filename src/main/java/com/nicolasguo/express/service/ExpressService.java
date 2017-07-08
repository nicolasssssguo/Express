package com.nicolasguo.express.service;

import java.io.Serializable;
import java.util.List;

import com.nicolasguo.express.condition.impl.ExpressCondition;

public interface ExpressService<T, PK extends Serializable> {
	
	public T getExpress(PK id);

	public T loadExpress(PK id);

	public List<T> findExpressByProperty(String propertyName, Object propertyValue);

	@SuppressWarnings("rawtypes")
	public List<T> findExpressByCondition(ExpressCondition condition);

	public void updateExpress(T entity);

	public void saveExpress(T entity);

	public void deleteExpress(T entity);

	public void deleteExpresss(List<T> list);
}
