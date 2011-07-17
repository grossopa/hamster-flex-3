/**
 * 
 */
package org.hamster.pm.weibo.service.impl;

import javax.annotation.Resource;

import org.hamster.pm.common.service.CRUDService;
import org.hamster.pm.weibo.pojo.DWeibo;
import org.hamster.pm.weibo.pojo.DWeiboUser;
import org.hamster.pm.weibo.service.ICacheService;
import org.hamster.pm.weibo.service.IWeiboUserService;
import org.hamster.pm.weibo.vo.WeiboUserVO;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Expression;
import org.springframework.stereotype.Service;

/**
 * @author grossopa
 *
 */
@Service("weiboUserService")
public class WeiboUserServiceImpl implements IWeiboUserService {
	
	@Resource(name = "weiboUserCRUDService")
	CRUDService<DWeiboUser> weiboUserCRUDService;
	
	@Resource(name = "weiboCRUDService")
	CRUDService<DWeibo> weiboCRUDService;
	
	@Resource(name = "cacheService")
	ICacheService cacheService;
	
	public WeiboUserServiceImpl() {
	}

	/* (non-Javadoc)
	 * @see org.hamster.pm.weibo.service.IWeiboUserService#addUser(java.lang.String)
	 */
	@Override
	public WeiboUserVO addUser(String userKey) {
		weiboUserCRUDService.setEntityClass(DWeiboUser.class);
		weiboCRUDService.setEntityClass(DWeibo.class);
		
		
		DWeiboUser newWeiboUser = new DWeiboUser();
		newWeiboUser.setUserKey(userKey);
		weiboCRUDService.save(newWeiboUser);
		
		WeiboUserVO userVO = new WeiboUserVO(newWeiboUser);
		cacheService.putUser(userVO);
		return userVO;
	}

	/* (non-Javadoc)
	 * @see org.hamster.pm.weibo.service.IWeiboUserService#getUser(java.lang.String)
	 */
	@Override
	public WeiboUserVO getUser(String userKey) {
		weiboUserCRUDService.setEntityClass(DWeiboUser.class);
		weiboCRUDService.setEntityClass(DWeibo.class);
		
		
		WeiboUserVO userVO = cacheService.getUser(userKey);
		if (userVO == null) {
			DWeiboUser dWeiboUser = getUserFromDB(userKey);
			if (dWeiboUser != null) {
				userVO = new WeiboUserVO(dWeiboUser);
				cacheService.putUser(userVO);
			}
		}
		return userVO;
	}
	
	public DWeiboUser getUserFromDB(String userKey) {
		weiboUserCRUDService.setEntityClass(DWeiboUser.class);
		
		
		Criterion[] criterions = {
			Expression.eq("userKey", userKey)
		};
		return weiboUserCRUDService.getFirst(criterions);
	}

}
