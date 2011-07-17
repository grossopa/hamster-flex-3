package org.hamster.pm.weibo.service.impl;

import org.hamster.pm.common.service.impl.CRUDServiceImpl;
import org.hamster.pm.weibo.pojo.DWeibo;
import org.springframework.stereotype.Service;

@Service("weiboCRUDService")
public class WeiboCRUDServiceImpl extends CRUDServiceImpl<DWeibo> {
	public WeiboCRUDServiceImpl() {
		this.setEntityClass(DWeibo.class);
	}
}
