package com.nicolasguo.express.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nicolasguo.express.condition.impl.ExpressCondition;
import com.nicolasguo.express.dao.IBaseEntityDao;
import com.nicolasguo.express.entity.Express;
import com.nicolasguo.express.service.ExpressService;

@Service("expressService")
public class ExpressServiceImpl implements ExpressService<Express, String> {

	@Resource(name = "expressDao")
	IBaseEntityDao<Express> expressDao;

	@Override
	public Express getExpress(String id) {
		return expressDao.get(id);
	}

	@Override
	public Express loadExpress(String id) {
		return expressDao.load(id);
	}

	@Override
	public List<Express> findExpressByProperty(String propertyName, Object propertyValue) {
		return expressDao.findByProperty(propertyName, propertyValue);
	}

	@Override
	public List<Express> findExpressByCondition(ExpressCondition condition) {
		return expressDao.findByCondition(condition);
	}

	@Override
	public void updateExpress(Express entity) {
		expressDao.update(entity);
	}

	@Override
	public void saveExpress(Express entity) {
		expressDao.save(entity);
	}

	@Override
	public void deleteExpress(Express entity) {
		expressDao.delete(entity);
	}

	@Override
	public void deleteExpresss(List<Express> list) {
		expressDao.deleteEntitys(list);
	}

}
