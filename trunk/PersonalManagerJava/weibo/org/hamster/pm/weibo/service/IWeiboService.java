package org.hamster.pm.weibo.service;

import org.hamster.pm.weibo.vo.AbstractWeiboVO;

public interface IWeiboService {
	
	AbstractWeiboVO requestToken(); 
	
	String authenticationUrl();
	
	AbstractWeiboVO accessToken();
	
	String updateStatus(String userKey, String message);
}
