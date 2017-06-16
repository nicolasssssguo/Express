package com.nicolasguo.webtemplate.dao.impl;

import java.util.List;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import com.nicolasguo.webtemplate.condition.HibernateCondition;
import com.nicolasguo.webtemplate.dao.IBaseEntityDao;


public class BaseEntityDaoImpl<T> implements IBaseEntityDao<T> {

	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;
	
	private Class<T> entityClass;

	public BaseEntityDaoImpl(Class<T> entityClass) {
		this.entityClass = entityClass;
	}
	
	@Override
	public T get(String id) {
		return sessionFactory.getCurrentSession().get(entityClass, id);
	}

	@Override
	public T load(String id) {
		return sessionFactory.getCurrentSession().load(entityClass, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByProperty(String propertyName, String propertyValue) {
		String queryString = "from " + this.entityClass.getSimpleName() + " t where t." + propertyName + " = :" + propertyName;
		return sessionFactory.getCurrentSession().createQuery(queryString)
				.setParameter(propertyName, propertyValue)
				.list();
	}

	public void delete(T entity) {
		sessionFactory.getCurrentSession().delete(entity);
	}
	

	@Override
	public void deleteEntitys(List<T> list) {
		list.forEach(sessionFactory.getCurrentSession()::delete);
	}

	public void save(T entity) {
		sessionFactory.getCurrentSession().save(entity);
	}

	public void update(T entity) {
		sessionFactory.getCurrentSession().update(entity);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findAll() {
		String queryString = "from " + entityClass.getSimpleName();
		return sessionFactory.getCurrentSession().createQuery(queryString)
				.list();
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<T> findByCondition(HibernateCondition condition) {
		return condition.getCriteria()
				.getExecutableCriteria(sessionFactory.getCurrentSession())
				.list();
	}
	
	@Override
	@SuppressWarnings("rawtypes")
	public List findByCriteria(DetachedCriteria criteria){
		return criteria.getExecutableCriteria(sessionFactory.getCurrentSession())
				.list();
	}
}
