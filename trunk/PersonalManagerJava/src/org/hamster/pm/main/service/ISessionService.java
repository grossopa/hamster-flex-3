/**
 * 
 */
package org.hamster.pm.main.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

/**
 * @author Grossopa
 *
 */
public interface ISessionService {
	
	/**
	 * put a user into session
	 * 
	 * @param user
	 * @return specific key
	 */
	String putUser(HttpSession session, String email);
	
	/**
	 * logout a user by key from Cookie
	 * 
	 * @param key
	 * @return success or not
	 */
	Boolean removeUser(HttpSession session, String key);
	
	
	/**
	 * get user from Session
	 * 
	 * @param session
	 * @param key
	 * @return user information
	 */
	Map<String, Object> getUser(HttpSession session, String key);
	
}
