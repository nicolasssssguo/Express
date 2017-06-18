package com.nicolasguo.webtemplate.common;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.nicolasguo.webtemplate.dao.IBaseEntityDao;
import com.nicolasguo.webtemplate.dao.impl.BaseEntityDaoImpl;
import com.nicolasguo.webtemplate.entity.User;

@Configuration
public class ProjectConfig {

	public static final String PREFIX = "webtemplate";

	public static final String NAME = PREFIX + ".";
	
	@Bean(name = "userDao")
	public IBaseEntityDao<User> generateAccountDao(){
		return new BaseEntityDaoImpl<User>(User.class);
	}

}
