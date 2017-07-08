package com.nicolasguo.express.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nicolasguo.express.entity.User;

@Controller
@RequestMapping("/user")
public class LoginAction {
	
	@RequestMapping("/login.action")
	public String login(HttpServletRequest request){
		request.getSession().setAttribute("loginuser", new User());
        return "redirect:/index"; 
	}

}
