/**
 * 
 */
package org.hamster.pm.main.web.rest.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.hamster.pm.main.constant.ControllerConstant;
import org.hamster.pm.main.util.ControllerUtil;
import org.springframework.ui.ModelMap;

/**
 * @author Grossopa
 * 
 */
public class SessionInterceptor implements MethodInterceptor {

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.aopalliance.intercept.MethodInterceptor#invoke(org.aopalliance.intercept
	 * .MethodInvocation)
	 */
	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		Object[] args = invocation.getArguments();
		HttpServletRequest request = null;
		ModelMap modelMap = null;
		for (int i = 0; i < args.length; i++) {
			if (args[i] instanceof HttpServletRequest) {
				request = (HttpServletRequest) args[i];
			} else if (args[i] instanceof ModelMap) {
				modelMap = (ModelMap) args[i];
			}
		}
		
		
		if (request == null) {
			ControllerUtil.writeFailureMessage(modelMap, 
					ControllerConstant.USER_INVALID,
					ControllerConstant.MSG_USER_INVALID);
			return "jsonView";
		}
		
		Object userMapObj = request.getSession().getAttribute(ControllerConstant.COOKIE_UUID);
		if (userMapObj == null) {
			ControllerUtil.writeFailureMessage(modelMap, 
					ControllerConstant.USER_INVALID,
					ControllerConstant.MSG_USER_INVALID);
			return "jsonView";
		} else {
			for (int i = 0; i < args.length; i++) {
				if (args[i] instanceof Map) {
					args[i] = userMapObj;
				}
			}
		}
		return invocation.proceed();
	}

}
