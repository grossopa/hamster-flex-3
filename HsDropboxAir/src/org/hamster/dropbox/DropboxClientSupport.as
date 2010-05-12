package org.hamster.dropbox
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
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
		
		public function sendRequest(
			apiHost:String, 
			url:String, 
			auth:Authenticator,
			params:Object = null,
			httpMethod:String = URLRequestMethod.POST, 
			protocol:String = DEFAULT_PROTOCOL,
			apiVersion:int = API_VERSION,
			port:int = 80
			):void
		{
			var fullURL:String = null;
			
			var httpService:HTTPService = new HTTPService();
			httpService.addEventListener(ResultEvent.RESULT, httpResultHandler);
			httpService.addEventListener(FaultEvent.FAULT, httpFaultHandler);
			
			if (httpMethod == URLRequestMethod.GET) {
				fullURL = buildFullURL(apiHost, buildURL(url, apiVersion, null), port, protocol);
				httpService.method = URLRequestMethod.GET;
			} else if (httpMethod == URLRequestMethod.POST) {
				fullURL = buildFullURL(apiHost, buildURL(url, apiVersion, null), port, protocol);
				httpService.method = URLRequestMethod.POST;
			}
			httpService.url = fullURL;
			
			var oauthRequest:OAuthRequest = new OAuthRequest(httpMethod, fullURL, null, auth.consumer, auth.accessToken);
			var urlHeader:URLRequestHeader = oauthRequest.buildRequest(
				OAuthSignatureMethod_HMAC_SHA1.getInstance(), OAuthRequest.RESULT_TYPE_HEADER);
			var ddd:String = urlHeader.value;
			httpService.headers['Authorization'] = urlHeader.value;
			httpService.send(params);
		}
		
		protected function httpResultHandler(evt:ResultEvent):void
		{
			var disEvt:DropboxEvent = new DropboxEvent(DropboxEvent.HTTP_RESULT);
			disEvt.relatedEvent = evt;
			this.dispatchEvent(disEvt);
		}
		
		protected function httpFaultHandler(evt:FaultEvent):void
		{
			var disEvt:DropboxEvent = new DropboxEvent(DropboxEvent.HTTP_FAULT);
			disEvt.relatedEvent = evt;
			this.dispatchEvent(disEvt);			
		}
		
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
		
		/**
		 * Used internally to build a URL path + params (if given) according to the API_VERSION.
		 */
		public static function buildURL(url:String, apiVersion:int, params:Object):String
		{
			url = URLEncoding.encode("/" + apiVersion + url);
			url = url.replace("%2F", "/").replace("+", "%20");
			if (params != null && params.length > 0) {
				url +=  "?" + urlEncode(params);
			} 
			return url;
		}
		
		/**
		 * Used internally to URL encode a list of parameters, which makes it easier to do params than with a map.
		 * If you want to use this, the params are organized as key=value pairs in a row, and should convert to Strings.
		 */
		public static function urlEncode(params:Object):String
		{
			var result:String = "";
			var firstTime:Boolean = true;
			for(var p:Object in params) {
				if (firstTime) {
					firstTime = false;
				} else {
					result += "&";
				}
				result += URLEncoding.encode(params[p]) 
					+ "=" + URLEncoding.encode(p.toString());
			}
			return result;
		}
	}
}