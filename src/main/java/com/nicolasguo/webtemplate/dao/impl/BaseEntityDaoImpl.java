package com.nicolasguo.webtemplate.dao.impl;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import com.nicolasguo.webtemplate.condition.HibernateCondition;
import com.nicolasguo.webtemplate.dao.IBaseEntityDao;
import com.nicolasguo.webtemplate.entity.Page;


public class BaseEntityDaoImpl<T> implements IBaseEntityDao<T> {

	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;
	
	private Class<T> entityClass;

	public BaseEntityDaoImpl(Class<T> entityClass) {
		this.entityClass = entityClass;
	}
	
	public Session currentSession(){
		return sessionFactory.getCurrentSession();
	}
	
	@Override
	public T get(String id) {
		return currentSession().get(entityClass, id);
	}

	@Override
	public T load(String id) {
		return currentSession().load(entityClass, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByProperty(String propertyName, String propertyValue) {
		String queryString = "from " + this.entityClass.getSimpleName() + " t where t." + propertyName + " = :" + propertyName;
		return currentSession().createQuery(queryString)
				.setParameter(propertyName, propertyValue)
				.list();
	}

	public void delete(T entity) {
		currentSession().delete(entity);
	}
	

	@Override
	public void deleteEntitys(List<T> list) {
		list.forEach(currentSession()::delete);
	}

	public void save(T entity) {
		currentSession().save(entity);
	}

	public void update(T entity) {
		currentSession().update(entity);
	}
	
	public long count(){
		DetachedCriteria criteria = DetachedCriteria.forClass(entityClass);
		criteria.setProjection(Projections.rowCount());
		return (long) criteria.getExecutableCriteria(currentSession()).uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findAll() {
		String queryString = "from " + entityClass.getSimpleName();
		return currentSession().createQuery(queryString)
				.list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Page<T> findAll(Page<T> page) {
		String queryString = "from " + entityClass.getSimpleName();
		List<T> result = currentSession().createQuery(queryString)
				.setFirstResult(page.getPageSize() * (page.getPageNo() - 1))
				.setMaxResults(page.getPageSize())
				.list();
		page.setTotalRecords(count());
		page.setList(result);
		return page;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<T> findByCondition(HibernateCondition condition) {
		return condition.getCriteria()
				.getExecutableCriteria(currentSession())
				.list();
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Page<T> findByCondition(HibernateCondition condition, Page<T> page) {
		List<T> result = condition.getCriteria()
				.getExecutableCriteria(currentSession())
				.setFirstResult(page.getPageSize() * (page.getPageNo() - 1))
				.setMaxResults(page.getPageSize())
				.list();
		page.setTotalRecords(count());
		page.setList(result);
		return page;
	}
	
	@Override
	@SuppressWarnings("rawtypes")
	public List findByCriteria(DetachedCriteria criteria){
		return criteria.getExecutableCriteria(currentSession())
				.list();
	}
}
