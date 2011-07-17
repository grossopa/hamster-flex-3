/**
 * 
 */
package org.hamster.pm.weibo.vo;

import org.hamster.pm.weibo.pojo.DWeibo;

import weibo4j.Status;
import weibo4j.Weibo;
import weibo4j.WeiboException;


/**
 * @author grossopa
 *
 */
public class SinaVO extends AbstractWeiboVO {
	
	private final Weibo weibo = new Weibo();
	
	public SinaVO(DWeibo dWeibo) {
		weibo.setOAuthConsumer(Weibo.CONSUMER_KEY, Weibo.CONSUMER_SECRET);
		weibo.setOAuthAccessToken(dWeibo.getAccessTokenKey(), dWeibo.getAccessTokenSecret());
	}
	
	@Override
	public String authenticationUrl() {
		try {
			return weibo.getOAuthRequestToken().getAuthenticationURL();
		} catch (WeiboException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public final Weibo getWeibo() {
		return weibo;
	}

	@Override
	public String updateStatus(String message) {
		try {
			@SuppressWarnings("unused")
			Status status = getWeibo().updateStatus(message);
		} catch (WeiboException e) {
			e.printStackTrace();
			return "failed";
		}
		return "Success";
	}

}
