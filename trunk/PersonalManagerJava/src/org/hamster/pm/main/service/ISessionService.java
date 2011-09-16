/**
 * 
 */
package org.hamster.pm.main.service;

import javax.servlet.http.HttpSession;

import org.hamster.pm.main.pojo.DUser;

/**
 * @author Grossopa
 *
 */
public interface ISessionService {
	
	/**
	 * put a user into session
	 * 
	 * @param user
	 */
	void putUser(HttpSession session, DUser user);
	
	/**
	 * logout a user by key from Cookie
	 * 
	 * @param key
	 * @return success or not
	 */
	Boolean removeUser(HttpSession session, String token);
	
	
	/**
	 * get user from Session
	 * 
	 * @param session
	 * @param key
	 * @return user information
	 */
	DUser getUser(HttpSession session, String token);
	
}
