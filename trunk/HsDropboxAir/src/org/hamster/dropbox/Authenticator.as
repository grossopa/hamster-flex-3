package org.hamster.dropbox
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.messaging.Consumer;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.hamster.dropbox.utils.DropboxConstants;
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;
	import org.iotashan.utils.OAuthUtil;
	
	[Event(name='requestTokenResult', type='org.hamster.dropbox.DropboxEvent')]
	[Event(name='requestTokenFault', type='org.hamster.dropbox.DropboxEvent')]
	
	public class Authenticator extends EventDispatcher
	{
		public var consumer_key:String = null;
		public var consumer_secret:String = null;
		public var request_token_url:String = null;
		public var access_token_url:String = null;
		public var authorization_url:String = null;
		
		private var _config:Object = null;
		private var _consumer:OAuthConsumer;
		private var _requestToken:OAuthToken;
		private var _accessToken:OAuthToken;
		private var _authorizeUrl:String;
		
		/**
		 * Takes a Map of configuration values (similar to what's loaded by loadConfig) and configures
		 * a for accessing the Dropbox service.
		 *
		 * You can preconfigure an access token by setting access_token_key and access_token_secret in
		 * the config map.
		 */
		public function Authenticator(config:Object)
		{
			this._config = config;
			this.consumer_key 		= config["consumer_key"];
			this.consumer_secret	= config["consumer_secret"];
			
			if (config['request_token_key'] != null) {
				this._requestToken = new OAuthToken(config['request_token_key'], config['request_token_secret']);
			}
			
			if (config['access_token_key'] != null) {
				this._accessToken = new OAuthToken(config['access_token_key'], config['access_token_secret']);
			}
			
			this.request_token_url 	= config["request_token_url"];
			this.access_token_url 	= config["access_token_url"];
			this.authorization_url 	= config["authorization_url"];
			
			this._consumer = new OAuthConsumer(this.consumer_key, this.consumer_secret);
		}
		
		public function retrieveRequestToken():void
		{
			var request:OAuthRequest = new OAuthRequest(OAuthRequest.HTTP_MEHTOD_POST, 
				this.request_token_url, null, this.consumer, null);
			request.buildRequest(OAuthSignatureMethod_HMAC_SHA1.getInstance(), 
				OAuthRequest.RESULT_TYPE_POST);
			
			var params:Object = request.requestParams;
			var httpService:HTTPService = new HTTPService();
			httpService.method = URLRequestMethod.POST; 
			httpService.url = DropboxConstants.REQUEST_TOKEN_URL;
			httpService.addEventListener(ResultEvent.RESULT, requestTokenResultHandler);
			httpService.addEventListener(FaultEvent.FAULT, requestTokenFaultHandler);
			var asyncToken:AsyncToken = httpService.send(params);
		}
		
		protected function requestTokenResultHandler(evt:ResultEvent):void
		{
			_requestToken = OAuthUtil.getTokenFromResponse(evt.result.toString());
			if (_requestToken.isEmpty) {
				this.requestTokenFaultHandler(null);
			} else {
				_authorizeUrl = this.authorization_url + '?oauth_token=' + this._requestToken.key;
				
				var disEvt:DropboxEvent = new DropboxEvent(DropboxEvent.REQUEST_TOKEN_RESULT);
				disEvt.requestToken = this.requestToken;
				this.dispatchEvent(disEvt);
			}
		}
		
		protected function requestTokenFaultHandler(evt:FaultEvent):void
		{
			this.dispatchEvent(new DropboxEvent(DropboxEvent.REQUEST_TOKEN_FAULT));
		}
		
		public function retrieveAccessToken():void
		{
			var request:OAuthRequest = new OAuthRequest(OAuthRequest.HTTP_MEHTOD_GET, 
				this.access_token_url, null, this.consumer, this._requestToken);
			var paramString:String = request.buildRequest(OAuthSignatureMethod_HMAC_SHA1.getInstance(), 
				OAuthRequest.RESULT_TYPE_POST);
			
			var httpService:HTTPService = new HTTPService();
			httpService.method = OAuthRequest.HTTP_MEHTOD_GET; 
			httpService.url = DropboxConstants.ACCESS_TOKEN_URL + '?' + paramString;
			httpService.addEventListener(ResultEvent.RESULT, accessTokenResultHandler);
			httpService.addEventListener(FaultEvent.FAULT, accessTokenFaultHandler);
			var asyncToken:AsyncToken = httpService.send();
		}
		
		protected function accessTokenResultHandler(evt:ResultEvent):void
		{
			_accessToken = OAuthUtil.getTokenFromResponse(evt.result.toString());
			if (_accessToken.isEmpty) {
				this.accessTokenFaultHandler(null);
			} else {
				var disEvt:DropboxEvent = new DropboxEvent(DropboxEvent.ACCESS_TOKEN_RESULT);
				disEvt.requestToken = this.requestToken;
				disEvt.accessToken = this.accessToken;
				this.dispatchEvent(disEvt);
			}		
		}
		
		protected function accessTokenFaultHandler(evt:FaultEvent):void
		{
			this.dispatchEvent(new DropboxEvent(DropboxEvent.ACCESS_TOKEN_FAULT));
		}
		
		public function get requestToken():OAuthToken
		{
			return this._requestToken == null || this._requestToken.isEmpty ? null : this._requestToken;
		}
		
		public function get accessToken():OAuthToken
		{
			return this._accessToken == null || this._accessToken.isEmpty ? null : this._accessToken;
		}
		
		public function get consumer():OAuthConsumer
		{
			return this._consumer;
		}
		
		public function get config():Object
		{
			return this._config;
		}
		
		public function getAuthorizeUrl():String 
		{
			return this._authorizeUrl;
		}
		
		
	}
}