package com.nicolasguo.express.condition.impl;

import java.util.Date;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.nicolasguo.express.condition.HibernateCondition;
import com.nicolasguo.express.entity.Customer;
import com.nicolasguo.express.entity.Express;

public class ExpressCondition extends HibernateCondition<Express> {

	private Date startDate;

	private Date endDate;

	private Customer recipient;

	private int status = -1;

	@Override
	public void createCriteria(DetachedCriteria criteria) {
		if (startDate != null) {
			criteria.add(Restrictions.ge("createTime", startDate));
		}
		if (endDate != null) {
			criteria.add(Restrictions.le("createTime", endDate));
		}
		if (recipient != null) {
			criteria.add(Restrictions.eq("recipient", recipient));
		}
		if (status != -1) {
			criteria.add(Restrictions.eq("status", status));
		}

	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public void setRecipient(Customer recipient) {
		this.recipient = recipient;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
