package org.hamster.pm.weibo.service.impl;

import org.hamster.pm.common.service.impl.CRUDServiceImpl;
import org.hamster.pm.weibo.pojo.DWeiboUser;
import org.springframework.stereotype.Service;

@Service("weiboUserCRUDService")
public class WeiboUserCRUDServiceImpl extends CRUDServiceImpl<DWeiboUser> {
	public WeiboUserCRUDServiceImpl() {
		this.setEntityClass(DWeiboUser.class);
	}
}
