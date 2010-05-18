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
	
	/**
	 * The authenicator will dispatch a DropboxEvent.REQUEST_TOKEN_RESULT event 
	 * after function retrieveRequestToken() is called and successfully get the
	 * result.
	 */
	[Event(name='requestTokenResult', type='org.hamster.dropbox.DropboxEvent')]
	
	/**
	 * The authenicator will dispatch a DropboxEvent.REQUEST_TOKEN_FAULT event 
	 * after function retrieveRequestToken() is called and failed to get the
	 * result.
	 */
	[Event(name='requestTokenFault', type='org.hamster.dropbox.DropboxEvent')]
	
	/**
	 * The authenicator will dispatch a DropboxEvent.ACCESS_TOKEN_RESULT event 
	 * after function retrieveAccessToken() is called and successfully get the
	 * result.
	 */
	[Event(name='accessTokenResult', type='org.hamster.dropbox.DropboxEvent')]
	
	/**
	 * The authenicator will dispatch a DropboxEvent.ACCESS_TOKEN_FAULT event 
	 * after function retrieveAccessToken() is called and failed to get the
	 * result.
	 */
	[Event(name='accessTokenFault', type='org.hamster.dropbox.DropboxEvent')]
	
	/**
	 * An authenticator class for dropbox authentication. The workflow of authentication
	 * via OAuth is :
	 * 
	 * 1. Prepare a consumer key/secret, which you can request it from 
	 *    <a href="https://www.dropbox.com/">dropbox</a> web site;
	 * 2. Call retrieveRequestToken() function to get a request token key/secret;
	 * 3. Ask user to go getAuthorizeUrl() and allow your application to access;
	 * 4. After user do that, let user trigger a "allowed" action and call
	 * 	  retrieveAccessToken() function to get access token key/secret, 
	 *    DO REMEMBER TO STORE the access token to somewhere!
	 * 
	 * @author yinzeshuo
	 * 
	 */
	public class Authenticator extends EventDispatcher
	{
		/**
		 * consumer key
		 */
		public var consumerKey:String = null;
		
		/**
		 * consumer secret
		 */
		public var consumerSecret:String = null;
		
		/**
		 * request token url, default value is DropboxConstants.REQUEST_TOKEN_URL
		 * set from config['request_token_url'] object.
		 */
		public var requestTokenUrl:String = null;
		
		/**
		 * access token url, default value is DropboxConstants.ACCESS_TOKEN_URL
		 * set from config['access_token_url'] object.
		 */
		public var accessTokenUrl:String = null;
		
		/**
		 * authorization url, default value is DropboxConstants.AUTHORIZATION_URL
		 * set from config['authorization_url'] object.
		 */
		public var authorizationUrl:String = null;
		
		private var _config:Object = null;
		private var _consumer:OAuthConsumer;
		private var _requestToken:OAuthToken;
		private var _accessToken:OAuthToken;
		private var _authorizeUrl:String;
		
		/**
		 * Takes a Object of configuration values (similar to what's loaded by loadConfig) and configures
		 * a for accessing the Dropbox service.
		 *
		 * You can preconfigure an access token by setting access_token_key and access_token_secret in
		 * the config map.
		 * 
		 * @param config a object contains a list of configuration.
		 * 
		 */
		public function Authenticator(config:Object)
		{
			this._config = config;
			this.consumerKey 	= config["consumer_key"];
			this.consumerSecret	= config["consumer_secret"];
			
			if (config['request_token_key'] != null) {
				this._requestToken = new OAuthToken(config['request_token_key'], config['request_token_secret']);
			}
			
			if (config['access_token_key'] != null) {
				this._accessToken = new OAuthToken(config['access_token_key'], config['access_token_secret']);
			}
			
			this.requestTokenUrl 	= config["request_token_url"];
			this.accessTokenUrl 	= config["access_token_url"];
			this.authorizationUrl 	= config["authorization_url"];
			
			this._consumer = new OAuthConsumer(this.consumerKey, this.consumerSecret);
		}
		
		/**
		 * Retrieve request token from Dropbox web site.
		 * 
		 * Either DropboxEvent.REQUEST_TOKEN_RESULT event or DropboxEvent.REQUEST_TOKEN_FAULT event
		 * is dispatched async.
		 * 
		 */
		public function retrieveRequestToken():void
		{
			var request:OAuthRequest = new OAuthRequest(OAuthRequest.HTTP_MEHTOD_POST, 
				this.requestTokenUrl, null, this.consumer, null);
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
		
		/**
		 * listener function when request token is successfully received.
		 *  
		 * @param evt result event
		 */
		protected function requestTokenResultHandler(evt:ResultEvent):void
		{
			_requestToken = OAuthUtil.getTokenFromResponse(evt.result.toString());
			if (_requestToken.isEmpty) {
				this.requestTokenFaultHandler(null);
			} else {
				_authorizeUrl = this.authorizationUrl + '?oauth_token=' + this._requestToken.key;
				
				var disEvt:DropboxEvent = new DropboxEvent(DropboxEvent.REQUEST_TOKEN_RESULT);
				disEvt.requestToken = this.requestToken;
				this.dispatchEvent(disEvt);
			}
		}
		
		/**
		 * listener function when request token is failed to receive.
		 *  
		 * @param evt fault event
		 */
		protected function requestTokenFaultHandler(evt:FaultEvent):void
		{
			this.dispatchEvent(new DropboxEvent(DropboxEvent.REQUEST_TOKEN_FAULT));
		}
		
		/**
		 * request a access token from Dropbox site, should be called after user has allowed
		 * access from Dropbox site.
		 * 
		 * Either DropboxEvent.ACCESS_TOKEN_RESULT event or DropboxEvent.ACCESS_TOKEN_FAULT event
		 * is dispatched async.
		 * 
		 */
		public function retrieveAccessToken():void
		{
			var request:OAuthRequest = new OAuthRequest(OAuthRequest.HTTP_MEHTOD_GET, 
				this.accessTokenUrl, null, this.consumer, this._requestToken);
			var paramString:String = request.buildRequest(OAuthSignatureMethod_HMAC_SHA1.getInstance(), 
				OAuthRequest.RESULT_TYPE_POST);
			
			var httpService:HTTPService = new HTTPService();
			httpService.method = OAuthRequest.HTTP_MEHTOD_GET; 
			httpService.url = DropboxConstants.ACCESS_TOKEN_URL + '?' + paramString;
			httpService.addEventListener(ResultEvent.RESULT, accessTokenResultHandler);
			httpService.addEventListener(FaultEvent.FAULT, accessTokenFaultHandler);
			var asyncToken:AsyncToken = httpService.send();
		}
		
		/**
		 * listener function when access token is successfully received.
		 *  
		 * @param evt result event
		 */
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
		
		/**
		 * listener function when access token is failed to receive.
		 * 
		 * @param evt fault event
		 * 
		 */
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