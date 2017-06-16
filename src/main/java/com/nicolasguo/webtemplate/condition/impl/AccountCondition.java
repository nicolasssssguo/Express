package com.nicolasguo.webtemplate.condition.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.icloud.condition.HibernateCondition;
import com.icloud.entity.Account;

public class AccountCondition extends HibernateCondition<Account> {

	private List<String> joinIdList;

	@Override
	public void createCriteria(DetachedCriteria criteria) {
		if (joinIdList != null) {
			criteria.add(Restrictions.in("id", joinIdList));
		}
	}

	public List<String> getJoinIdList() {
		return joinIdList;
	}

	public void setJoinIdList(List<String> joinIdList) {
		this.joinIdList = joinIdList;
	}
}
