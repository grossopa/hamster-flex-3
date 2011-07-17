package org.hamster.pm.main.web.rest;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hamster.pm.main.constant.ControllerConstant;
import org.hamster.pm.main.pojo.DUser;
import org.hamster.pm.main.service.ICookieService;
import org.hamster.pm.main.service.ISessionService;
import org.hamster.pm.main.service.IUserService;
import org.hamster.pm.main.util.ControllerUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
	
	public static final String JSON_VIEW = "jsonView";
	
	@Resource(name = "userService")
	private IUserService userService;
	@Resource(name = "cookieService")
	private ICookieService cookieService;
	@Resource(name = "simpleSessionService")
	private ISessionService sessionService;
	
	@RequestMapping(value = "/login", method = { RequestMethod.POST })
	public String login(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			ModelMap modelMap,
			@RequestParam(value = "email", required = true) String email,
			@RequestParam(value = "password", required = true) String password,
			@RequestParam(value = "expiry", required = false, defaultValue = "7200") Integer expiry) {
		DUser user = userService.validateUser(email, password);
		if (user == null) {
			ControllerUtil.writeFailureMessage(modelMap, 
					ControllerConstant.LOGIN_EMAILPASSWORDWRONG, 
					ControllerConstant.MSG_LOGIN_EMAILPASSWORDWRONG);
		} else {
			String key = sessionService.putUser(session, email);
			cookieService.putUser(response, sessionService.getUser(session, key), expiry);
			
			ControllerUtil.mappingResponse(modelMap, "status", 0, "token", key, "user", user);
		}
		
		return JSON_VIEW;
	}
	
	@RequestMapping(value = "/register", method = { RequestMethod.POST })
	public String register(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			@RequestParam(value = "email", required = true) String email,
			@RequestParam(value = "password", required = true) String password,
			ModelMap modelMap) {
		userService.addUser(email, password);
		login(request, response, session, modelMap, email, password, 7200);
		return JSON_VIEW;
	}
	
	@RequestMapping(value = "/logout", method = { RequestMethod.POST })
	public String logout(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap modelMap) {
		String key = (String) cookieService.getCookies(request).get(ControllerConstant.COOKIE_UUID);
		Map<String, Object> userMap = sessionService.getUser(session, key);
		cookieService.removeUser(response);
		if (userMap != null) {
			sessionService.removeUser(session, key);
		}
		ControllerUtil.mappingResponse(modelMap, "status", 0);
		return JSON_VIEW;
	}
	
	
	
}
