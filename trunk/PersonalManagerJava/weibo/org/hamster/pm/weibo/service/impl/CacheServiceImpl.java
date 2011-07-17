/**
 * 
 */
package org.hamster.pm.weibo.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.hamster.pm.weibo.service.ICacheService;
import org.hamster.pm.weibo.vo.WeiboUserVO;
import org.springframework.stereotype.Service;

/**
 * @author grossopa
 *
 */
@Service("cacheService")
public class CacheServiceImpl implements ICacheService {
	
	private final Map<String, WeiboUserVO> cacheMap = new HashMap<String, WeiboUserVO>();

	@Override
	public WeiboUserVO getUser(String userKey) {
		return cacheMap.get(userKey);
	}

	@Override
	public void putUser(WeiboUserVO user) {
		cacheMap.put(user.getUserKey(), user);
	}
	
	

}
