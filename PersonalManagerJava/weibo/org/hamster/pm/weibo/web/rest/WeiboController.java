package org.hamster.pm.weibo.web.rest;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hamster.pm.main.constant.ControllerConstant;
import org.hamster.pm.main.service.ICookieService;
import org.hamster.pm.main.util.CommonUtil;
import org.hamster.pm.main.util.HashUtil;
import org.hamster.pm.weibo.service.IWeiboService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller("weibo")
public class WeiboController {
	
	public static final String JSON_VIEW = "jsonView";
	
	@Resource(name = "cookieService")
	private ICookieService cookieService;
	@Resource(name = "weiboService")
	private IWeiboService weiboService;
	
	@RequestMapping(value = "/authentication", method = { RequestMethod.POST })
	public String register(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "requestToken", required = true) String email,
			@RequestParam(value = "password", required = true) String password,
			ModelMap modelMap) {
		return JSON_VIEW;	
	}
	
	@RequestMapping(value = "/", method = { RequestMethod.GET })
	public ModelAndView index(
			HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> cookies = cookieService.getCookies(request);
		String userKey = (String) cookies.get(ControllerConstant.COOKIE_UUID);
		if (CommonUtil.isEmpty(userKey)) {
			userKey = HashUtil.hash(String.valueOf(new Date().getTime()));
			cookies.put(ControllerConstant.COOKIE_UUID, userKey);
		}
		cookieService.putUser(response, cookies, 864000000 * 365);
		ModelAndView modelAndView = new ModelAndView("index");
		
		modelAndView.addObject(ControllerConstant.COOKIE_UUID, userKey);
		
		return modelAndView;
	}
	
	@RequestMapping(value="/updateStatus", method={RequestMethod.POST})
	public String updateStatus(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "userKey", required = true) String userKey,
			@RequestParam(value = "message", required = true) String message) {
		weiboService.updateStatus(userKey, message);
		return JSON_VIEW;
	}
}
