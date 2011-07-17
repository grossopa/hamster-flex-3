/**
 * 
 */
package org.hamster.pm.main.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.hamster.pm.main.constant.ControllerConstant;
import org.hamster.pm.main.service.ISessionService;
import org.hamster.pm.main.util.CommonUtil;
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
	public String putUser(HttpSession session, String email) {
		Map<String, Object> userInfo = null;
		String key = CommonUtil.generateUUID();
		userInfo = new HashMap<String, Object>();
		userInfo.put(ControllerConstant.COOKIE_UUID, key);
		userInfo.put(ControllerConstant.EMAIL, email);
		session.setAttribute(key, userInfo);
		return key;
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
	public Map<String, Object> getUser(HttpSession session, String key) {
		Object att = session.getAttribute(key);
		if (att == null) {
			return null;
		} else {
			return (Map<String, Object>) att;
		}
	}
	

}
