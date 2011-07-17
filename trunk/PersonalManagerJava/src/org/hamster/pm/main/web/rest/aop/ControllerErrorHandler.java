/**
 * 
 * #OK
 * 0=Correct response
 * # 1)      Client Application has not been authorized
 * # 2)      Other than printcast application send requests.
 * -1=Unauthorized
 * #     maybe some request parameters are wrong or missing.
 * -2=Bad request
 * # 1)      the PrintCastID does not exist
 * # 2)      the PrintCastID is not owned by the user
 * -3=Invalid PrintCastId
 * #       The content id does not exist.
 * -4=Invalid contentID
 * #     1)      It is a malformed URL. Either no legal protocol could be found in a specification string or the string could not be parsed.
 * #     2)      Cannot get the web page by this url.
 * -5=Invalid url
 * #      The type is not in {letter, booklet}
 * -6=Invalid print type
 * #      The type is not in { letter vertical, letter horizontal, booklet vertica, booklet horizontal}
 * -7=Invalid print preview type
 * #        The page num is out of boundary.
 * -8=Invalid page num
 * #   The duration number is greater than the limit days.(Maybe 30 days)
 * -9=Invalid duration days
 * #    Internal Server Exception
 * -100=Unexpected exception
 */
package org.hamster.pm.main.web.rest.aop;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.hamster.pm.main.constant.ControllerConstant;
import org.hamster.pm.main.exception.ControllerException;
import org.hamster.pm.main.util.LoggerStringFormatter;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author yinz
 * 
 */
public class ControllerErrorHandler implements HandlerExceptionResolver {

	public static final Logger log = Logger.getLogger("acw.rest");
	public static final Map<Integer, String> codeMap = new HashMap<Integer, String>(
			0);

	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception e) {
		try {
			if (e instanceof ControllerException) {
				processControllerException((ControllerException) e, response);
			}
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		log.error(LoggerStringFormatter.formatRequest(request), e);
		return new ModelAndView();
	}

	private void processControllerException(ControllerException e,
			HttpServletResponse response) throws IOException {
		String type = e.getType();
		if (ControllerException.USER_INVALID.equals(type)) {
			String str = errJSON(ControllerConstant.USER_INVALID,
					ControllerConstant.MSG_USER_INVALID);
			IOUtils.write(str, response.getOutputStream());
		}
	}

	/**
	 * response format : {"status":-1, "message":"blablablabla"}
	 * 
	 * @param code
	 * @param message
	 * @return
	 */
	public static String errJSON(int code, String message) {
		StringBuffer sb = new StringBuffer("{\"status\":");
		sb.append(code).append(",\"message\":\"").append(message).append("\"}");
		return sb.toString();
	}

}
