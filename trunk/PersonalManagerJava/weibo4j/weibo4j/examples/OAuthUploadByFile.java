package weibo4j.examples;

import java.io.File;
import java.net.URLEncoder;

import weibo4j.Status;
import weibo4j.Weibo;

public class OAuthUploadByFile {
	/**
	 * Usage: java -DWeibo4j.oauth.consumerKey=[consumer key]
	 * -DWeibo4j.oauth.consumerSecret=[consumer secret]
	 * Weibo4j.examples.OAuthUpload [accessToken] [accessSecret]
	 * [imageFilePath]
	 * 
	 * @param args
	 *            message
	 */
	public static void main(String[] args) {
		try {
			if (args.length < 3) {
	            System.out.println(
	                "Usage: java weibo4j.examples.OAuthUploadByFile token tokenSecret filePath");
	            System.exit( -1);
	        }
			
			System.setProperty("weibo4j.oauth.consumerKey", Weibo.CONSUMER_KEY);
			System.setProperty("weibo4j.oauth.consumerSecret", Weibo.CONSUMER_SECRET);

			Weibo weibo = new Weibo();
			
			/*
			 * æ­¤å¤„éœ€è¦�å¡«å†™AccessTokençš„keyå’ŒSecretï¼Œå�¯ä»¥ä»ŽOAuthUpdateçš„æ‰§è¡Œç»“æžœä¸­æ‹·è´�è¿‡æ�¥
             */
			weibo.setToken(args[0], args[1]);
			try {
				File file=new File(args[2]);
//				if(file==null){
//					System.out.println("file is null");
//					System.exit(-1);
//				}
				
				String msg = URLEncoder.encode("ä¸­æ–‡å†…å®¹", "UTF-8");
				Status status = weibo.uploadStatus(msg + "cvvbqwe1343", file);

				System.out.println("Successfully upload the status to ["
						+ status.getText() + "].");
				
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} catch (Exception ioe) {
			System.out.println("Failed to read the system input.");
		}
	}

}
