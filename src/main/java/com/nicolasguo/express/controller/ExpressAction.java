package com.nicolasguo.express.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nicolasguo.express.condition.impl.ExpressCondition;
import com.nicolasguo.express.entity.Area;
import com.nicolasguo.express.entity.Customer;
import com.nicolasguo.express.entity.Express;
import com.nicolasguo.express.entity.Page;
import com.nicolasguo.express.service.AreaService;
import com.nicolasguo.express.service.CustomerService;
import com.nicolasguo.express.service.ExpressService;
import com.nicolasguo.express.util.UUID;

@Controller
@RequestMapping("/express")
public class ExpressAction {

	@Resource(name = "expressService")
	private ExpressService<Express, String> expressService;

	@Resource(name = "areaService")
	private AreaService<Area, String> areaService;

	@Resource(name = "customerService")
	private CustomerService<Customer, String> customerService;

	@RequestMapping("/index")
	public @ResponseBody ModelAndView index(
			@RequestParam(value = "pageNo", defaultValue = "1", required = false) int pageNo) {
		Page<Express> pageEntity = new Page<Express>();
		pageEntity.setPageNo(pageNo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("index");
		mav.addObject("expressPage", expressService.findAll(pageEntity));
		mav.addObject("action", "index");
		return mav;
	}

	@RequestMapping("/createOrUpdate.action")
	public @ResponseBody String createOrUpdateExpress(@RequestParam(value = "id", required = false) String id,
			@RequestParam("name") String name, @RequestParam("phoneNumber") String phoneNumber,
			@RequestParam("area") String areacode, @RequestParam("arriveDate") String arriveDate,
			@RequestParam("status") int status) throws ParseException {
		Area area = areaService.findAreaByProperty("code", areacode).get(0);
		List<Customer> customerList = customerService.findCustomerByProperty("phoneNumber", phoneNumber);
		Customer recipient = null;
		if (customerList.size() == 0) {
			recipient = new Customer();
			recipient.setId(UUID.generateUUID());
			recipient.setName(name);
			recipient.setPhoneNumber(phoneNumber);
			recipient.setArea(area);
			customerService.saveCustomer(recipient);
			recipient = customerService.loadCustomer(recipient.getId());
		} else {
			recipient = customerList.get(0);
		}
		Express express = expressService.getExpress(id);
		if(express == null){
			express = new Express();
			express.setId(UUID.generateUUID());
			express.setCreateTime(new Date());
		}
		express.setDest(area);
		express.setRecipient(recipient);
		express.setStatus(status);
		SimpleDateFormat format = new SimpleDateFormat("yyyy年MM月dd日");
		express.setArriveDate(format.parse(arriveDate));
		
		if(StringUtils.isEmpty(id)){
			expressService.saveExpress(express);
			return "create";
		}else{
			express.setModifyTime(new Date());
			expressService.updateExpress(express);
			return "update";
		}
	}
	
	@RequestMapping("/remove.action")
	public @ResponseBody String removeExpress(@RequestParam("ids[]") List<String> ids) {
		ExpressCondition condition = new ExpressCondition();
		condition.setIds(ids);
		List<Express> removeList = expressService.findExpressByCondition(condition);
		expressService.deleteExpresss(removeList);
		return "success";
	}

	@RequestMapping("/search.action")
	public ModelAndView searchExpress(@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate,
			@RequestParam("phoneNumber") String phoneNumber,
			@RequestParam(value = "status", required = false) int status,
			@RequestParam(value = "pageNo", defaultValue = "1", required = false) int pageNo) throws ParseException {
		ExpressCondition expressCondition = new ExpressCondition();
		SimpleDateFormat format = new SimpleDateFormat("yyyy年MM月dd日");
		if (StringUtils.isNotEmpty(startDate)) {
			expressCondition.setStartDate(format.parse(startDate));
		}
		if (StringUtils.isNotEmpty(endDate)) {
			expressCondition.setEndDate(format.parse(endDate));
		}
		List<Customer> customerList = customerService.findCustomerByProperty("phoneNumber", phoneNumber);
		Customer recipient = (customerList.size() > 0) ? customerList.get(0) : null;
		expressCondition.setRecipient(recipient);
		expressCondition.setStatus(status);
		Page<Express> pageEntity = new Page<Express>();
		pageEntity.setPageNo(pageNo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("index");
		mav.addObject("expressPage", expressService.findExpressByCondition(expressCondition, pageEntity));
		mav.addObject("action", "search.action");
		return mav;
	}

	@RequestMapping("/list.action")
	public @ResponseBody List<Express> expressList() {
		return expressService.findAll();
	}

	@RequestMapping("/sign.action")
	public String signExpress(@RequestParam String id) {
		Express express = expressService.getExpress(id);
		express.setStatus(1);
		expressService.updateExpress(express);
		return "redirect:/express/index";
	}

	@RequestMapping("/fetch.action")
	public @ResponseBody Express fetchExpress(@RequestParam String id) {
		Express express = expressService.getExpress(id);
		return express;
	}
}
