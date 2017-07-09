package com.nicolasguo.express.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nicolasguo.express.condition.impl.CustomerCondition;
import com.nicolasguo.express.entity.Customer;
import com.nicolasguo.express.service.CustomerService;

@Controller
@RequestMapping("/customer")
public class CustomerAction {
	
	@Resource(name = "customerService")
	private CustomerService<Customer, String> customerService;

	@RequestMapping("/search")
	public @ResponseBody List<Customer> customerList(@RequestParam String keynumber){
		CustomerCondition condition = new CustomerCondition();
		condition.setKeynumber(keynumber);
		List<String> result = new ArrayList<String>();
		List<Customer> customerList = customerService.findCustomerByCondition(condition);
		customerList.forEach(customer->result.add(customer.toString()));
		return customerList;
	}
	
}
