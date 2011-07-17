package weibo4j.examples.tags;

import java.util.List;

import weibo4j.Tag;
import weibo4j.Weibo;


public class CreateTag {
	@SuppressWarnings("unused")
	public static void main(String[] args) {
		System.setProperty("weibo4j.oauth.consumerKey", Weibo.CONSUMER_KEY);
    	System.setProperty("weibo4j.oauth.consumerSecret", Weibo.CONSUMER_SECRET);
        try {
        	Weibo weibo = getWeibo(true,args);
        	List<Tag> tag= weibo.createTags(args[2]);
        	 for(Tag t:tag){
        		System.out.println( tag.toString());
        	 }
        	
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

