package com.nicolasguo.express.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class URLResolver {

	@RequestMapping("/index")
	public String index(){
        return "index"; 
	}
	
	@RequestMapping("/login")
	public String login(){
        return "login"; 
	}
}
