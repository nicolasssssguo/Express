package com.nicolasguo.express.common;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.nicolasguo.express.dao.IBaseEntityDao;
import com.nicolasguo.express.dao.impl.BaseEntityDaoImpl;
import com.nicolasguo.express.entity.User;

@Configuration
public class ProjectConfig {

	public static final String PREFIX = "webtemplate";

	public static final String NAME = PREFIX + ".";
	
	@Bean(name = "userDao")
	public IBaseEntityDao<User> generateAccountDao(){
		return new BaseEntityDaoImpl<User>(User.class);
	}

}
