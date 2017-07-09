package com.nicolasguo.express.condition.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import com.nicolasguo.express.condition.HibernateCondition;
import com.nicolasguo.express.entity.Customer;

public class CustomerCondition extends HibernateCondition<Customer> {

	private String keynumber;

	@Override
	public void createCriteria(DetachedCriteria criteria) {
		if(keynumber != null){
			criteria.add(Restrictions.like("phoneNumber", keynumber, MatchMode.ANYWHERE));
		}
	}

	public String getKeynumber() {
		return keynumber;
	}

	public void setKeynumber(String keynumber) {
		this.keynumber = keynumber;
	}

}
