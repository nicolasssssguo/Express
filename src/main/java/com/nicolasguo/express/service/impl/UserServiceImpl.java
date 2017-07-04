package com.nicolasguo.express.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.nicolasguo.express.condition.impl.UserCondition;
import com.nicolasguo.express.dao.IBaseEntityDao;
import com.nicolasguo.express.entity.User;
import com.nicolasguo.express.service.UserService;

@Service("userDetailsService")
public class UserServiceImpl implements UserService<User, String> {

	@Resource(name = "userDao")
	IBaseEntityDao<User> userDao;
	
	@Override
	public User getUser(String id) {
		return null;
	}

	@Override
	public User loadUser(String id) {
		return null;
	}

	@Override
	public void updateUser(User entity) {
	}

	@Override
	public void saveUser(User entity) {
	}

	@Override
	public void deleteUser(User entity) {
	}

	@Override
	public void deleteUsers(List<User> list) {
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		List<User> list = userDao.findByProperty("username", username);
		if(list.size() > 0){
			User user = list.get(0);
			if(user.isEnabled()){
				return user;
			}
		}
		return null;
	}

	@Override
	public List<User> findUserByProperty(String propertyName, String propertyValue) {
		return null;
	}

	@Override
	public List<User> findUserByCondition(UserCondition condition) {
		return null;
	}

}
