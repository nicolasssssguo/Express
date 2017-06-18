package com.nicolasguo.webtemplate.condition.impl;

import org.hibernate.criterion.DetachedCriteria;

import com.nicolasguo.webtemplate.condition.HibernateCondition;
import com.nicolasguo.webtemplate.entity.User;

public class UserCondition extends HibernateCondition<User> {

	@Override
	public void createCriteria(DetachedCriteria criteria) {
		
	}

}
