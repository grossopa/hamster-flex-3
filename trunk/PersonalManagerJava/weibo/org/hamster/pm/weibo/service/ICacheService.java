package org.hamster.pm.weibo.service;

import org.hamster.pm.weibo.vo.WeiboUserVO;

public interface ICacheService {
	
	WeiboUserVO getUser(String userKey);
	
	void putUser(WeiboUserVO user);
}
