package com.nicolasguo.express.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserAction {
	
	@RequestMapping("/login.action")
	public String login(Model model,  
            @RequestParam(value = "error", required = false) String error){
		if (error != null) {  
            model.addAttribute("error", "用户名或密码错误");  
        }  
        return "login"; 
	}

}
