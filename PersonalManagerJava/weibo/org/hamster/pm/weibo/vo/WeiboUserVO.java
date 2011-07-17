package org.hamster.pm.weibo.vo;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hamster.pm.weibo.pojo.DWeibo;
import org.hamster.pm.weibo.pojo.DWeiboUser;
import org.hamster.pm.weibo.util.WeiboUtil;

public class WeiboUserVO {
	
	private Long id;
	private String userKey;
	private final Map<Enum<WeiboType>, AbstractWeiboVO> weiboList = new HashMap<Enum<WeiboType>, AbstractWeiboVO>();
	
	public WeiboUserVO(DWeiboUser user) {
		this.setId(user.getId());
		this.setUserKey(user.getUserKey());
		
		List<DWeibo> dWeiboList = user.getWeiboList();
		if (dWeiboList != null) {
			Iterator<DWeibo> iter = dWeiboList.iterator();
			while (iter.hasNext()) {
				DWeibo dWeibo = iter.next();
				AbstractWeiboVO w = WeiboUtil.createWeiboVO(dWeibo);
				this.weiboList.put(WeiboType.valueOf(dWeibo.getType()), w);
			}
		}
		
	}
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getUserKey() {
		return userKey;
	}
	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}
	public Map<Enum<WeiboType>, AbstractWeiboVO> getWeiboList() {
		return weiboList;
	}
	
}
