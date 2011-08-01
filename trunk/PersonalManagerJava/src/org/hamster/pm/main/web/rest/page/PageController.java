package org.hamster.pm.main.web.rest.page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller("page")
public class PageController {
	
	@RequestMapping(value = "/login.page", method = { RequestMethod.GET })
	public ModelAndView login(
			HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("login");
		return modelAndView;
	}
	
	@RequestMapping(value = "/index.page", method = { RequestMethod.GET })
	public ModelAndView index(
			HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("index");
		return modelAndView;
	}
}
