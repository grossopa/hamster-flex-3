/**
 * 
 */
package org.hamster.pm.main.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hamster.pm.main.constant.ControllerConstant;
import org.hamster.pm.main.pojo.DUser;
import org.hamster.pm.main.service.ICookieService;
import org.springframework.stereotype.Service;

/**
 * @author Grossopa
 *
 */
@Service("cookieService")
public class CookieServiceImpl implements ICookieService {

	/* (non-Javadoc)
	 * @see org.hamster.pm.main.service.ICookieService#putUser(java.util.Map, long)
	 */
	@Override
	public void putUser(HttpServletResponse response, DUser user, int expiry) {
		List<Cookie> cookieList = new ArrayList<Cookie>();
		if (user != null) {
			cookieList.add(new Cookie(ControllerConstant.COOKIE_UUID, user.getToken()));
		} else {
			cookieList.add(new Cookie(ControllerConstant.COOKIE_UUID, ""));
		}
		
		for (Cookie cookie : cookieList) {
			cookie.setMaxAge(expiry);
			response.addCookie(cookie);
		}
	}

	/* (non-Javadoc)
	 * @see org.hamster.pm.main.service.ICookieService#removeUser(javax.servlet.http.HttpServletResponse, java.util.Map)
	 */
	@Override
	public void removeUser(HttpServletResponse response) {
		putUser(response, null, 0);
	}
	
//	/**
//	 * @param userMap
//	 * @return
//	 */
//	private Cookie[] convertMapToCookies(Map<String, Object> userMap) {
//		Iterator<String> iter = userMap.keySet().iterator();
//		Cookie[] cookies = new Cookie[userMap.keySet().size()];
//		int i = 0;
//		while (iter.hasNext()) {
//			String key = iter.next();
//			if (!key.startsWith(ControllerConstant.COOKIE)) {
//				continue;
//			}
//			Object value = userMap.get(key);
//			cookies[i] = new Cookie(key, value == null ? "" : value.toString());
//			i++;
//		}
//		return cookies;
//	}

	@Override
	public Map<String, Object> getCookies(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		Map<String, Object> result = new HashMap<String, Object>();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().startsWith(ControllerConstant.COOKIE)) {
					result.put(cookie.getName(), cookie.getValue());
				}
			}
		}
		return result;
	}

}
