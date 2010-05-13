package org.hamster.dropbox
{
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectUtil;
	import mx.utils.URLUtil;
	
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.dropbox.commands.DropboxCommand;
	import org.hamster.dropbox.models.DropboxModelSupport;
	import org.hamster.dropbox.test.DropboxUnitTest;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.utils.URLEncoding;

	public class DropboxClientSupport extends EventDispatcher
	{
		/** This is set by Dropbox to indicate what version of the API you are using. */
		public static const API_VERSION:int = 0;
		public static const DEFAULT_PROTOCOL:String = "http";
		public static const SECURE_PROTOCOL:String = "https";
		
		public function buildRequestCommand(
				resultType:Class,
				apiHost:String, 
				url:String, 
				auth:Authenticator,
				params:Object = null,
				httpMethod:String = URLRequestMethod.POST, 
				protocol:String = DEFAULT_PROTOCOL,
				apiVersion:int = API_VERSION,
				port:int = 80
			):DropboxCommand
		{
			var fullURL:String = buildFullURL(apiHost, "/" + apiVersion + url, port, protocol);
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.method = httpMethod;
			urlRequest.url = fullURL;
			if (params != null) {
				urlRequest.data = URLUtil.objectToString(params, "&");
			}
			
			var oauthRequest:OAuthRequest = new OAuthRequest(
				httpMethod, fullURL, params, auth.consumer, auth.accessToken);
			var urlHeader:URLRequestHeader = oauthRequest.buildRequest(
				OAuthSignatureMethod_HMAC_SHA1.getInstance(), OAuthRequest.RESULT_TYPE_HEADER);
			urlRequest.requestHeaders = [urlHeader];
			
			var cmd:DropboxCommand = new DropboxCommand();
			cmd.urlRequest = urlRequest;
			cmd.resultType = resultType;
			cmd.params = params;
			return cmd;
		}
		
		
//		public static function buildStreamRequestCommand(
//			resultType:Class,
//			apiHost:String, 
//			url:String, 
//			auth:Authenticator,
//			params:Object = null,
//			httpMethod:String = URLRequestMethod.POST, 
//			protocol:String = DEFAULT_PROTOCOL,
//			apiVersion:int = API_VERSION,
//			port:int = 80
//		):DropboxCommand 
//		{
//			var fullURL:String = null;
//			
//			var urlRequest:URLRequest = new URLRequest();
//			fullURL = buildFullURL(apiHost, "/" + apiVersion + url, port, protocol);
//			urlRequest.method = httpMethod;
//			urlRequest.url = fullURL;
//			
//			var oauthRequest:OAuthRequest = new OAuthRequest(
//				httpMethod, fullURL, params, auth.consumer, auth.accessToken);
//			var urlHeader:URLRequestHeader = oauthRequest.buildRequest(
//				OAuthSignatureMethod_HMAC_SHA1.getInstance(), OAuthRequest.RESULT_TYPE_HEADER);
//			var ddd:String = urlHeader.value;
//			httpService.headers['Authorization'] = urlHeader.value;
//			
//			var cmd:DropboxCommand = new DropboxCommand();
//			cmd.httpService = httpService;
//			cmd.resultType = resultType;
//			cmd.params = params;
//			return cmd;			
//		}
		/**
		 * Used internally to construct a complete URL to a given host, which can sometimes
		 * be the "API host" or the "content host" depending on the type of call.
		 */
		public static function buildFullURL(
			host:String, target:String, port:int = 80,
			protocol:String = DEFAULT_PROTOCOL):String
		{
			var portString:String = (port == 80) ? "" : (":" + port);
			return protocol + "://" + host + portString + target; 
		}
		
	}
}