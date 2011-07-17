/**
 * 
 */
package org.hamster.pm.weibo.util;

import org.hamster.pm.weibo.pojo.DWeibo;
import org.hamster.pm.weibo.vo.AbstractWeiboVO;
import org.hamster.pm.weibo.vo.SinaVO;
import org.hamster.pm.weibo.vo.WeiboType;

/**
 * @author grossopa
 *
 */
public class WeiboUtil {
	
	public static AbstractWeiboVO createWeiboVO(DWeibo dWeibo) {
		if (dWeibo.getType().equalsIgnoreCase(WeiboType.SINA.name())) {
			return new SinaVO(dWeibo);
		} else if (dWeibo.getType().equalsIgnoreCase(WeiboType.TWITTER.name())) {
			return null;
		}
		return null;
	}
}
