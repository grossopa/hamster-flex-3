package org.hamster.pm.main.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ICookieService {
	
	/**
	 * put user's information to cookie
	 * 
	 * @param response
	 * @param userMap
	 * @param expiry in seconds
	 */
	void putUser(HttpServletResponse response, Map<String, Object> userMap, int expiry);
	
	/**
	 * remove cookie information
	 * 
	 * @param response
	 * @param userMap
	 */
	void removeUser(HttpServletResponse response);
	
	Map<String, Object> getCookies(HttpServletRequest request);
}
