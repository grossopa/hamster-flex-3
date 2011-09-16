/**
 * 
 */
package org.hamster.pm.main.service.impl;

import javax.servlet.http.HttpSession;

import org.hamster.pm.main.pojo.DUser;
import org.hamster.pm.main.service.ISessionService;
import org.springframework.stereotype.Service;

/**
 * a simple session service implementation
 * 
 * @author Grossopa
 *
 */
@Service("simpleSessionService")
public class SimpleSessionService implements ISessionService {

	/* (non-Javadoc)
	 * @see org.hamster.pm.main.service.ISessionService#putUser(javax.servlet.http.HttpSession, java.lang.String)
	 */
	@Override
	public void putUser(HttpSession session, DUser user) {
		session.setAttribute(user.getToken(), user);
	}

	/* (non-Javadoc)
	 * @see org.hamster.pm.main.service.ISessionService#removeUser(javax.servlet.http.HttpSession, java.lang.String)
	 */
	@Override
	public Boolean removeUser(HttpSession session, String key) {
		if (session.getAttribute(key) == null) {
			return false;
		} else {
			session.removeAttribute(key);
			return true;
		}
	}

	/* (non-Javadoc)
	 * @see org.hamster.pm.main.service.ISessionService#getUser(javax.servlet.http.HttpSession, java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public DUser getUser(HttpSession session, String key) {
		Object att = session.getAttribute(key);
		if (att == null) {
			return null;
		} else {
			return (DUser) att;
		}
	}
	

}
