/**
 * 
 */
package org.hamster.pm.main.util;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

/**
 * @author yinz
 *
 */
public class LoggerStringFormatter {
	
	/**
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static final String formatRequest(HttpServletRequest request) {
		StringBuffer result = new StringBuffer();
		result.append(request.getRemoteHost()).append(" ");
		result.append(request.getRequestURI());
		Enumeration<String> e = request.getParameterNames();
		if (e != null && e.hasMoreElements()) {
			result.append("?");
			while (e.hasMoreElements()) {
				String nextKey = e.nextElement();
				String nextValue = (String) request.getParameter(nextKey);
				result.append(nextKey).append("=").append(nextValue);
				if (e.hasMoreElements()) {
					result.append("&");
				}
			}
		}
		
		result.append(" ").append(request.getMethod()).append(" ");
		return result.toString();
	}
}
