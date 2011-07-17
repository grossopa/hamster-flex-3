/**
 * 
 */
package org.hamster.pm.weibo.service.impl;

import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import org.hamster.pm.weibo.service.IWeiboService;
import org.hamster.pm.weibo.service.IWeiboUserService;
import org.hamster.pm.weibo.vo.AbstractWeiboVO;
import org.hamster.pm.weibo.vo.WeiboType;
import org.hamster.pm.weibo.vo.WeiboUserVO;
import org.springframework.stereotype.Service;

/**
 * @author grossopa
 *
 */
@Service("weiboService")
public class WeiboServiceImpl implements IWeiboService {
	
	@Resource(name = "weiboUserService")
	IWeiboUserService weiboUserService;
	
	@Override
	public AbstractWeiboVO requestToken() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String authenticationUrl() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AbstractWeiboVO accessToken() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String updateStatus(String userKey, String message) {
		WeiboUserVO weiboUserVO = weiboUserService.getUser(userKey);
		if (weiboUserVO != null && weiboUserVO.getWeiboList() != null) {
			Iterator<Map.Entry<Enum<WeiboType>, AbstractWeiboVO>> iter = weiboUserVO.getWeiboList().entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry<Enum<WeiboType>, AbstractWeiboVO> next = iter.next();
				AbstractWeiboVO nextWeiboVO = next.getValue();
				nextWeiboVO.updateStatus(message);
			}
		}
		return "Success";
	}

}
