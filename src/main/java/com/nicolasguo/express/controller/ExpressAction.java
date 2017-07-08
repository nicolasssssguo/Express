package com.nicolasguo.express.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nicolasguo.express.condition.impl.ExpressCondition;
import com.nicolasguo.express.entity.Express;
import com.nicolasguo.express.service.ExpressService;

@Controller
@RequestMapping("/exp")
public class ExpressAction {
	
	@Resource(name = "expressService")
	private ExpressService<Express, String> expressService;
	
	@RequestMapping("/new.action")
	public @ResponseBody String newExpress(){
		return "";
	}

	@RequestMapping("/search.action")
	public @ResponseBody List<Express> searchExpress(){
		return expressService.findExpressByCondition(new ExpressCondition());
	}
	
	@RequestMapping("/list.action")
	public @ResponseBody List<Express> expressList(){
		return expressService.findExpressByCondition(new ExpressCondition());
	}
}
