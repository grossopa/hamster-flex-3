package weibo4j.examples.tags;

import weibo4j.Weibo;
import weibo4j.org.json.JSONObject;

public class DestroyTag {
	@SuppressWarnings("unused")
	public static void main(String[] args) {
		System.setProperty("weibo4j.oauth.consumerKey", Weibo.CONSUMER_KEY);
    	System.setProperty("weibo4j.oauth.consumerSecret", Weibo.CONSUMER_SECRET);
        try {
        	Weibo weibo = getWeibo(true,args);
            JSONObject destroytag=weibo.destoryTag(args[2]);
             } catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static Weibo getWeibo(boolean isOauth,String ... args) {
		Weibo weibo = new Weibo();
		if(isOauth) {//oauthéªŒè¯�æ–¹å¼� args[0]:è®¿é—®çš„tokenï¼›args[1]:è®¿é—®çš„å¯†åŒ™
			weibo.setToken(args[0], args[1]);
			
		}else {//ç”¨æˆ·ç™»å½•æ–¹å¼�
    		weibo.setUserId(args[0]);//ç”¨æˆ·å��/ID
    		weibo.setPassword(args[1]);//å¯†ç �
		}
		return weibo;
	}
}

