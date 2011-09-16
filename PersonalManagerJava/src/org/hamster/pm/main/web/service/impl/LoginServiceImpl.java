/**
 * 
 */
package org.hamster.pm.main.web.service.impl;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hamster.pm.main.constant.ControllerConstant;
import org.hamster.pm.main.model.ResultVO;
import org.hamster.pm.main.pojo.DUser;
import org.hamster.pm.main.service.ICookieService;
import org.hamster.pm.main.service.ISessionService;
import org.hamster.pm.main.service.IUserService;
import org.hamster.pm.main.util.ServiceUtil;
import org.hamster.pm.main.web.service.ILoginService;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

/**
 * @author Grossopa
 *
 */
@Service("loginService")
@RemotingDestination(channels={"my-amf"})
public class LoginServiceImpl implements ILoginService {
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	@Resource(name = "userService")
	private IUserService userService;
	@Resource(name = "cookieService")
	private ICookieService cookieService;
	@Resource(name = "simpleSessionService")
	private ISessionService sessionService;

	@Override
	@RemotingInclude
	public ResultVO login(String email, String password) {
		ResultVO resultVO = ServiceUtil.createResultVO();
		
		DUser user = userService.validateUser(email, password);
		if (user == null) {
			resultVO.setStatus(ControllerConstant.S_LOGIN_FAILED);
		} else {
			resultVO.setResult(user);
			cookieService.putUser(response, user, 7200);
			sessionService.putUser(request.getSession(), user);
		}
		return resultVO;
	}

	@Override
	public ResultVO resume(String token) {
		ResultVO resultVO = ServiceUtil.createResultVO();
		
		DUser user = sessionService.getUser(request.getSession(), token);
		if (user  == null) {
			resultVO.setStatus(ControllerConstant.S_TOKEN_INVALID);
		} else {
			resultVO.setResult(user);
			sessionService.putUser(request.getSession(), user);
			cookieService.putUser(response, user, 7200);
		}
		return resultVO;
	}

	@Override
	public ResultVO logout(DUser user) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public ResultVO register(String email, String password) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

}
