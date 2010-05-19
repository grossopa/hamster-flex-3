package org.hamster.dropbox
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import org.hamster.dropbox.utils.OAuthHelper;

	public class DropboxAPI
	{
		private var _config:DropboxConfig;
		
		public function get config():DropboxConfig
		{
			return this._config;
		}
		
		public function DropboxAPI(config:DropboxConfig)
		{
			_config = config;
		}
		
		public function requestToken():URLRequest
		{
			var url:String = config.requestTokenUrl;
			var urlReqHeader:URLRequestHeader = OAuthHelper.buildURLRequestHeader(url, null, 
				config.consumerKey, config.consumerSecret, null, null, URLRequestMethod.POST);
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.requestHeaders = [urlReqHeader];
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.url = url;
			var urlLoader:URLLoader = new URLLoader(urlRequest);
			return urlRequest;
		}
		
		
		public function buildURLRequest(apiHost:String, target:String, params:Object,
										protocol:String = 'http',
										httpMethod:String = URLRequestMethod.GET):URLRequest
		{
			var url:String = this.buildFullURL(apiHost, target, protocol);
			
			var urlReqHeader:URLRequestHeader = OAuthHelper.buildURLRequestHeader(url, params, 
				config.consumerKey, config.consumerSecret, 
				config.accessTokenKey, config.accessTokenSecret, httpMethod);
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.requestHeaders = [urlReqHeader];
			urlRequest.method = httpMethod;
			urlRequest.data = params;
			urlRequest.url = url;
			return urlRequest;
		}
			
		public function buildFullURL(host:String, target:String, protocol:String = 'http'):String
		{
			var portString:String = (_config.port == 80) ? "" : (":" + _config.port);
			return protocol + "://" + host + portString + target; 
		}
	}
}