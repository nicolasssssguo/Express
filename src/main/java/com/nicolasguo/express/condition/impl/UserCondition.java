package com.nicolasguo.express.condition.impl;

import org.hibernate.criterion.DetachedCriteria;

import com.nicolasguo.express.condition.HibernateCondition;
import com.nicolasguo.express.entity.User;

public class UserCondition extends HibernateCondition<User> {

	@Override
	public void createCriteria(DetachedCriteria criteria) {
		
	}

}
