package com.nicolasguo.webtemplate.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.nicolasguo.webtemplate.condition.HibernateCondition;


/**
 * @ClassName：IBaseGenericDAO
 * @Description：TODO(IBaseGenericDAO DAO层泛型接口，定义基本的DAO功能 )
 * @param <T>    实体类 
 * @param <PK>    主键类，必须实现Serializable接口	
 * @date：Jul 9, 2012 1:32:07 PM
 * @version V1.0 
 */
public interface IBaseEntityDao<T> {

	public T load(String id);
	
	public T get(String id);
	
	public List<T> findByProperty(String propertyName, String propertyValue);

	public void update(T entity);

	public void save(T entity);

	public void delete(T entity);
	
	public void deleteEntitys(List<T> list);

	public List<T> findAll();

	@SuppressWarnings("rawtypes")
	public List<T> findByCondition(HibernateCondition condition);
	
	@SuppressWarnings("rawtypes")
	public List findByCriteria(DetachedCriteria criteria);
}
