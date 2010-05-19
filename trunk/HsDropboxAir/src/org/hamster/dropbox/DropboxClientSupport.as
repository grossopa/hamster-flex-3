package org.hamster.dropbox
{
	import flash.events.EventDispatcher;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	import mx.utils.URLUtil;
	
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.dropbox.commands.DropboxCommand;
	import org.hamster.dropbox.commands.DropboxUploadCommand;
	import org.hamster.dropbox.models.DropboxModelSupport;
	import org.hamster.dropbox.test.DropboxUnitTest;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.utils.URLEncoding;

	/**
	 * Client support function, use to build DropboxCommand instance.
	 * You should not create instance of this class manaually.
	 *  
	 * @author yinzeshuo
	 * 
	 */
	public class DropboxClientSupport extends EventDispatcher
	{
		/** 
		 * This is set by Dropbox to indicate what version of the API you are using. 
		 */
		public static const API_VERSION:int = 0;
		
		/**
		 * default protocol is using http, which is non-secure but more faster.
		 */
		public static const DEFAULT_PROTOCOL:String = "http";
		
		/**
		 * secure protocol, used in authenticator API, not sure whether Dropbox supports it.
		 */
		public static const SECURE_PROTOCOL:String = "https";
		
		/**
		 * Build an instance of DropboxCommand.  everything is ready and you can 
		 * register CommandEvent.COMMAND_RESULT and CommandEvent.COMMAND_FAULT
		 * event and then call execute() function to execute it.
		 *  
		 * @param resultType define result object type, if the value is null, then the 
		 * 		             DropboxCommand.resultObject is null, otherwise a new instance
		 *                   is created and decode(object:Object) function of resultObject
		 *                   is called to set the value.
		 * @param apiHost    define the host address.
		 * @param url        sub URL of API.
		 * @param auth       authenticator instance. the value must be set to generate
		 *                   OAuth request header.
		 * @param params     parameters, optional.
		 * @param httpMethod "POST" or "GET", default is "POST"
		 * @param protocol   "http" or "https", default is "http"
		 * @param apiVersion API version, currently is 0.
		 * @param port       default value is 80;
		 * @return           an instance of DropboxCommand
		 */
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
			var urlRequest:URLRequest = buildURLRequest(apiHost, 
				url, auth, params, httpMethod, protocol, apiVersion, port);
			var cmd:DropboxCommand = new DropboxCommand(urlRequest, resultType, params);
			return cmd;
		}
		
		/**
		 * Build a instance of dropbox upload command.
		 * 
		 * There is an issue that Dropbox API use multi-part/formdata
		 * to upload file and it will check  every Content-Deposition is legal or not,
		 * if not legal, then an exception is thrown from server. default Flash upload will
		 * generate a Content-Deposition named "Upload" and with value "Submit Query"
		 * which is not allowed by Dropbox API. So in order to solve the issue I had to
		 * import a third-party class ru.inspirit.net.MultipartURLLoader and modified part of
		 * its source code to remove illegal items.
		 * 
		 * So the API only support Flash Player 10 or higher because the FileReference
		 * cannot be used directly.
		 *  
		 * @param uploadData The data to upload.
		 * @param fileName   file name of upload file
		 * @param apiHost    define the host address.
		 * @param url        sub URL of API.
		 * @param auth       authenticator instance. the value must be set to generate
		 *                   OAuth request header.
		 * @param params     parameters, optional.
		 * @param httpMethod "POST" or "GET", default is "POST"
		 * @param protocol   "http" or "https", default is "http"
		 * @param apiVersion API version, currently is 0.
		 * @param port       default value is 80.
		 * @return           an instance of DropboxCommand
		 */
		public function buildUploadCommand(
				uploadData:ByteArray,
				fileName:String,
				apiHost:String, 
				url:String, 
				auth:Authenticator,
				params:Object = null,
				httpMethod:String = URLRequestMethod.POST, 
				protocol:String = DEFAULT_PROTOCOL,
				apiVersion:int = API_VERSION,
				port:int = 80
			):DropboxUploadCommand
		{
			
			var urlRequest:URLRequest = buildURLRequest(apiHost, 
				url, auth, params, httpMethod, protocol, apiVersion, port);
			var cmd:DropboxUploadCommand = new DropboxUploadCommand(urlRequest, uploadData, fileName);
			return cmd;
		}
		
		/**
		 * build a URL request
		 * 
		 * @param apiHost
		 * @param url
		 * @param auth
		 * @param params
		 * @param httpMethod
		 * @param protocol
		 * @param apiVersion
		 * @param port
		 * @return 
		 */
		public function buildURLRequest(
				apiHost:String, 
				url:String, 
				auth:Authenticator,
				params:Object,
				httpMethod:String = URLRequestMethod.POST, 
				protocol:String = DEFAULT_PROTOCOL,
				apiVersion:int = API_VERSION,
				port:int = 80
			):URLRequest
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
			return urlRequest;
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
		
	}
}