/**
 * 
 */
package org.hamster.pm.weibo.vo;

/**
 * @author grossopa
 *
 */
public abstract class AbstractWeiboVO {
	
	private String apiKey;
	private String apiSecret;
	private String requestTokenKey;
	private String requestTokenSecret;
	private String accessTokenKey;
	private String accessTokenSecret;
	
	public String getApiKey() {
		return apiKey;
	}
	public void setApiKey(String apiKey) {
		this.apiKey = apiKey;
	}
	public String getApiSecret() {
		return apiSecret;
	}
	public void setApiSecret(String apiSecret) {
		this.apiSecret = apiSecret;
	}
	public String getRequestTokenKey() {
		return requestTokenKey;
	}
	public void setRequestTokenKey(String requestTokenKey) {
		this.requestTokenKey = requestTokenKey;
	}
	public String getRequestTokenSecret() {
		return requestTokenSecret;
	}
	public void setRequestTokenSecret(String requestTokenSecret) {
		this.requestTokenSecret = requestTokenSecret;
	}
	public String getAccessTokenKey() {
		return accessTokenKey;
	}
	public void setAccessTokenKey(String accessTokenKey) {
		this.accessTokenKey = accessTokenKey;
	}
	public String getAccessTokenSecret() {
		return accessTokenSecret;
	}
	public void setAccessTokenSecret(String accessTokenSecret) {
		this.accessTokenSecret = accessTokenSecret;
	}
	
	abstract public String authenticationUrl();
	
	abstract public String updateStatus(String message);
}
