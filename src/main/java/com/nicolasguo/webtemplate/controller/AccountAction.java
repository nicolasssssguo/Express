package com.nicolasguo.webtemplate.controller;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icloud.condition.impl.TokenCondition;
import com.icloud.constrants.Constants;
import com.icloud.controller.util.ActionResult;
import com.icloud.controller.util.ReturnResult;
import com.icloud.entity.Account;
import com.icloud.entity.Folder;
import com.icloud.entity.Token;
import com.icloud.service.AccountService;
import com.icloud.service.FolderService;
import com.icloud.service.HadoopService;
import com.icloud.service.MailService;
import com.icloud.service.TokenService;
import com.icloud.util.FileUtils;
import com.icloud.util.TokenProcessor;
import com.icloud.util.UUID;

@Controller
@RequestMapping("/account")
public class AccountAction {

	@Autowired
	TokenService<Token, String> tokenService;

	@Autowired
	AccountService<Account, String> userDetailsService;
	
	@Autowired
	FolderService<Folder, String> folderSerivlce;
	
	@Autowired
	private HadoopService hadoopService;

	@Autowired
	MailService mailService;

	@Autowired
	@Qualifier("org.springframework.security.authenticationManager")
	protected AuthenticationManager authenticationManager;
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request){
		Account account = (Account)userDetailsService.loadUserByUsername("admin");
		Authentication authenticatedUser = new UsernamePasswordAuthenticationToken(account, null, account.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
		request.getSession().setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,SecurityContextHolder.getContext());
		return "redirect:/main.jsp";
	}

	@RequestMapping("/retrieveByName")
	@ResponseBody
	public Object retrieveByName(@RequestParam String username) {
		if (StringUtils.isNotBlank(username)) {
			Account account = (Account)userDetailsService.loadUserByUsername(username);
			if(account != null){
				return new ActionResult(ReturnResult.SUCCESS);
			}
		}
		return new ActionResult(ReturnResult.FAILURE);
	}

	@RequestMapping("/retrieveByEmail")
	@ResponseBody
	public Object retrieveByEmail(@RequestParam String email) {
		if (StringUtils.isNotBlank(email)) {
			List<Account> list = userDetailsService.findAccountByProperty("email",
					email);
			if (list.size() > 0) {
				return new ActionResult(ReturnResult.SUCCESS);
			}
		}
		return new ActionResult(ReturnResult.FAILURE);
	}

	public boolean validateAccount(HttpServletRequest request) {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String passwd = request.getParameter("passwd");
		String passwd2 = request.getParameter("passwd2");

		if (StringUtils.isBlank(name) || StringUtils.isBlank(email)
				|| StringUtils.isBlank(passwd) || StringUtils.isBlank(passwd2)) {
			return false;
		}

		Pattern pattern = Pattern.compile("^[0-9a-zA-Z\u0391-\uFFE5]{4,16}$");
		if (!pattern.matcher(name).matches()) {
			return false;
		}

		if (userDetailsService.findAccountByProperty("username", name).size() > 0) {
			return false;
		}

		if (userDetailsService.findAccountByProperty("email", email).size() > 0) {
			return false;
		}

		pattern = Pattern
				.compile("^[\\w.\\-]+@(?:[a-z0-9]+(?:-[a-z0-9]+)*\\.)+[a-z]{2,3}$");
		if (!pattern.matcher(email).matches()) {
			return false;
		}

		if (passwd.length() < 6) {
			return false;
		}

		if (passwd2.length() < 6) {
			return false;
		}

		if (!passwd.equals(passwd2)) {
			return false;
		}

		return true;
	}

	@RequestMapping("/regAccount")
	public ModelAndView regAccount(HttpServletRequest request) {
		if (!validateAccount(request)) {
			return new ModelAndView("redirect:/reg.jsp");
		}
		String userid = UUID.generateUUID();
		Account account = new Account(request.getParameter("name"), request.getParameter("passwd"), new HashSet<GrantedAuthority>());
		account.setId(userid);
		account.setLoginName(request.getParameter("name"));
		account.setEmail(request.getParameter("email"));
		userDetailsService.saveAccount(account);

		Token evt = new Token();
		evt.setId(UUID.generateUUID());
		evt.setExpireTime(new Date(System.currentTimeMillis() + Constants.VALIDTIME));
		evt.setToken(TokenProcessor.generateToken(userid, true));
		evt.setUserid(userid);
		evt.setEmail(account.getEmail());
		tokenService.saveToken(evt);

		mailService.sendRegValidatorMail(userid + "_" + evt.getToken(), account.getEmail());

		ModelAndView mav = new ModelAndView();
		mav.addObject("regMail", account.getEmail());
		mav.addObject("tokenid", evt.getId());
		mav.setViewName("forward:/WEB-INF/page/reg-success.jsp");

		return mav;
	}

	@RequestMapping("/{tokenid}/sendActiveCode")
	@ResponseBody
	public Object sendActiveCode(@PathVariable String tokenid) {
		Token token = tokenService.getToken(tokenid);
		Account account = userDetailsService.getAccount(token.getUserid());
		mailService.sendRegValidatorMail(token.getUserid() + "_" + token.getToken(), account.getEmail());
		return new ActionResult(ReturnResult.SUCCESS);
	}

	@RequestMapping("/activeAccount")
	public ModelAndView activeAccount(HttpServletRequest request, @RequestParam String token) {
		if (StringUtils.isNotBlank(token)) {
			if (token.split("_").length > 1) {
				Account account = userDetailsService.getAccount(token.split("_")[0]);
				if (account != null && !account.isEnabled()) {
					TokenCondition condition = new TokenCondition();
					condition.setToken(token.split("_")[1]);
					condition.setExpireTime(new Date());
					List<Token> list = tokenService.findTokenByCondition(condition);
					ModelAndView mav = new ModelAndView();
					if (list.size() > 0) {
						//Token tk = list.get(0);
						//tokenService.deleteToken(tk);
						account.setEnabled(true);
						userDetailsService.updateAccount(account);
						String[] folderNames = {"视频","图片","文档","音乐"};
						for(String folderName: folderNames){
							Folder favFolder = new Folder();
							favFolder.setTitle(folderName);
							favFolder.setCreated(account);
							favFolder.setFavorite(true);
							folderSerivlce.saveFolder(favFolder);
							hadoopService.createFolder(FileUtils.generateURL(favFolder));
						}
						try {
							Authentication authenticatedUser = new UsernamePasswordAuthenticationToken(account, null, account.getAuthorities());
							SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
							request.getSession().setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,SecurityContextHolder.getContext());
							mav.setViewName("redirect:/main.jsp");
						} catch (AuthenticationException e) {
							e.printStackTrace();
							mav.setViewName("redirect:/reg.jsp");
						}
					}
					return mav;
				}
			}
		}
		return new ModelAndView("redirect:/login.jsp");
	}

	@RequestMapping("/findpasswd")
	@ResponseBody
	public Object findpasswd(@RequestParam String email) {
		Pattern pattern = Pattern.compile("^[\\w.\\-]+@(?:[a-z0-9]+(?:-[a-z0-9]+)*\\.)+[a-z]{2,3}$");
		if (!pattern.matcher(email).matches()) {
			return new ActionResult(ReturnResult.FAILURE);
		}

		if (userDetailsService.findAccountByProperty("email", email).size() == 0) {
			return new ActionResult(ReturnResult.FAILURE);
		}

		Account account = userDetailsService.findAccountByProperty("email", email)
				.get(0);
		Token evt = new Token();
		evt.setId(UUID.generateUUID());
		evt.setExpireTime(new Date(System.currentTimeMillis()
				+ Constants.VALIDTIME));
		evt.setToken(TokenProcessor.generateToken(account.getId(), true));
		evt.setUserid(account.getId());
		evt.setEmail(account.getEmail());
		evt.setType(1);
		tokenService.saveToken(evt);
		mailService.sendNewPasswdMail(account.getId() + "_" + evt.getToken(),
				email);

		return new ActionResult(ReturnResult.SUCCESS);
	}

	@RequestMapping("/newpasswd")
	public ModelAndView newpasswd(@RequestParam String token) {
		if (StringUtils.isNotBlank(token)) {
			if (token.split("_").length == 2) {
				String[] tokenArr = token.split("_");
				Account account = userDetailsService.getAccount(tokenArr[0]);
				if (account != null && account.isEnabled()) {
					TokenCondition condition = new TokenCondition();
					condition.setToken(tokenArr[1]);
					condition.setExpireTime(new Date());
					List<Token> list = tokenService.findTokenByCondition(condition);
					ModelAndView mav = new ModelAndView();
					if (list.size() > 0) {
						Token tk = list.get(0);
						tokenService.deleteToken(tk);
						mav.addObject("userid", account.getId());
						mav.setViewName("forward:/WEB-INF/page/newpasswd.jsp");
					} else {
						mav.addObject("message", "该链接已失效，请再次发送密码重设邮件");
						mav.addObject("link", "findpassword.jsp");
						mav.addObject("linkmsg", "找回密码");
						mav.setViewName("forward:/WEB-INF/page/error-message.jsp");
					}
					return mav;
				}
			}
		}
		return new ModelAndView("forward:/login.jsp");
	}

	@RequestMapping("/{userid}/setNewpasswd")
	@ResponseBody
	public Object setNewpasswd(@PathVariable String userid,
			@RequestParam String passwd, @RequestParam String passwd2) {
		if (StringUtils.isNotBlank(userid)) {
			if (StringUtils.isNotBlank(passwd) && StringUtils.isNotBlank(passwd2)) {
				if (passwd.equals(passwd2)) {
					Account account = userDetailsService.getAccount(userid);
					if (account != null) {
						Md5PasswordEncoder passwordEncoder = new Md5PasswordEncoder();
						account.setPassword(passwordEncoder.encodePassword(passwd, account.getUsername()));
						userDetailsService.updateAccount(account);
						return new ActionResult(ReturnResult.SUCCESS);
					}
				}
			}
		}
		return new ActionResult(ReturnResult.FAILURE);
	}
}
