package com.nicolasguo.express.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nicolasguo.express.condition.impl.UserCondition;
import com.nicolasguo.express.entity.User;
import com.nicolasguo.express.service.UserService;

@Controller
@RequestMapping("/user")
public class UserAction {
	
	@Resource(name = "userService")
	private UserService<User, String> userService;
	
	@RequestMapping("/login.action")
	@ResponseBody
	public String login(@RequestParam String username, @RequestParam String password, HttpSession session){
		UserCondition condition = new UserCondition();
		condition.setUsername(username);
		condition.setPassword(password);
		List<User> result = userService.findUserByCondition(condition);
		if(result.size() > 0){
			session.setAttribute("LOGIN_USER", new User());
			return "success"; 
		}
		return "fail";
	}
	
	@RequestMapping("/logout.action")
	public String login(HttpSession session){
		session.invalidate();
		return "redirect:/login.jsp";
	}
}
