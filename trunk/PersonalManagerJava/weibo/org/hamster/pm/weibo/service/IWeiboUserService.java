package org.hamster.pm.weibo.service;

import org.hamster.pm.weibo.vo.WeiboUserVO;

public interface IWeiboUserService {
	
	public WeiboUserVO addUser(String userKey);
	
	public WeiboUserVO getUser(String userKey);
}
