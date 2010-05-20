package org.hamster.dropbox
{
	import com.adobe.serialization.json.JSON;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import mx.containers.Canvas;
	import mx.utils.ObjectUtil;
	import mx.utils.URLUtil;
	
	import org.hamster.dropbox.models.AccountInfo;
	import org.hamster.dropbox.models.DropboxFile;
	import org.hamster.dropbox.utils.OAuthHelper;
	
	import ru.inspirit.net.MultipartURLLoader;

	[Event(name="requestTokenResult", type="org.hamster.dropbox.DropboxEvent")]
	[Event(name="requestTokenFault", type="org.hamster.dropbox.DropboxEvent")]
	[Event(name="accessTokenResult", type="org.hamster.dropbox.DropboxEvent")]
	[Event(name="accessTokenFault", type="org.hamster.dropbox.DropboxEvent")]
	
	public class DropboxAPI extends EventDispatcher
	{
		protected static const REQUEST_TOKEN:String = 'request_token';
		protected static const ACCESS_TOKEN:String = 'access_token';
		protected static const ACCOUNT_INFO:String = 'account_info';
		protected static const DROPBOX_FILE:String = 'dropbox_file';
		
		private var _config:DropboxConfig;
		
		public function get config():DropboxConfig
		{
			return this._config;
		}
		
		public function DropboxAPI(config:DropboxConfig)
		{
			_config = config;
		}
		
		public function requestToken():URLLoader
		{
			var url:String = config.requestTokenUrl;
			var urlRequest:URLRequest = buildURLRequest(url, "", null, URLRequestMethod.POST);
			return this.load(urlRequest, DropboxEvent.REQUEST_TOKEN_RESULT, 
				DropboxEvent.REQUEST_TOKEN_FAULT, REQUEST_TOKEN);
		}
		
		public function accessToken():URLLoader
		{
			var url:String = config.accessTokenUrl;
			var urlReqHeader:URLRequestHeader = OAuthHelper.buildURLRequestHeader(url, null, 
				config.consumerKey, config.consumerSecret, 
				config.requestTokenKey, config.requestTokenSecret, URLRequestMethod.POST);
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.requestHeaders = [urlReqHeader];
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.url = url;
			return this.load(urlRequest, DropboxEvent.ACCESS_TOKEN_RESULT, 
				DropboxEvent.ACCESS_TOKEN_FAULT, ACCESS_TOKEN);
		}
		
		public function get authorizationUrl():String
		{
			if (config.requestTokenKey != null) {
				return this.config.authorizationUrl + '?oauth_token=' + config.requestTokenKey;
			} else {
				return "";
			}
		}
		
		/**
		 * The account/info API call to Dropbox for getting info about an account attached to the access token.
		 * Return status and account information in JSON format.
		 * 
		 * @param statusInResponse
		 * @param callback
		 * @return DropboxCommand
		 */
		public function accountInfo():URLLoader
		{
			var urlRequest:URLRequest = buildURLRequest(
				config.server, "/account/info", null);
			return this.load(urlRequest, DropboxEvent.ACCOUNT_INFO_RESULT, 
				DropboxEvent.ACCOUNT_INFO_FAULT, ACCOUNT_INFO);
		}
		
		/**
		 * Copy a file from one path to another, with root being either "sandbox" or "dropbox".
		 * return copied file metadata information in JSON format.
		 * 
		 * @param fromPath
		 * @param toPath
		 * @param callback
		 * @return dropboxCommand
		 */
		public function fileCopy(fromPath:String, toPath:String, 
								 root:String = DropboxConfig.SANDBOX):URLLoader
		{
			var params:Object = { 
				"root": root, 
				"from_path": fromPath,
				"to_path": toPath
			};
			var urlRequest:URLRequest = buildURLRequest(
				config.server, "/fileops/copy", params, URLRequestMethod.POST);
			return this.load(urlRequest, DropboxEvent.FILE_COPY_RESULT, 
				DropboxEvent.FILE_COPY_FAULT, DROPBOX_FILE);
		}
		
		/**
		 * Create a folder at the given path.
		 * return created folder metadata information in JSON format.
		 * 
		 * @param path
		 * @param callback
		 * @return dropboxCommand
		 */
		public function fileCreateFolder(path:String, 
										 root:String = DropboxConfig.SANDBOX):URLLoader
		{
			var params:Object = { 
				"root": root, 
				"path": path
			};
			var urlRequest:URLRequest = buildURLRequest(
				config.server, "/fileops/create_folder", params, URLRequestMethod.POST);
			return this.load(urlRequest, DropboxEvent.FILE_CREATE_FOLDER_RESULT, 
				DropboxEvent.FILE_CREATE_FOLDER_FAULT, DROPBOX_FILE);
		}
		
		/** 
		 * Delete a file.
		 * 
		 * @param path
		 * @param callback
		 * @return dropboxCommand
		 */
		public function fileDelete(path:String, 
								   root:String = DropboxConfig.SANDBOX):URLLoader
		{
			var params:Object = { 
				"root": root, 
				"path": path
			};
			
			var urlRequest:URLRequest = buildURLRequest(
				config.server, "/fileops/delete", params, URLRequestMethod.POST);
			return this.load(urlRequest, DropboxEvent.FILE_DELETE_RESULT, 
				DropboxEvent.FILE_DELETE_FAULT, "");
		}
		
		/** 
		 * Move a file.
		 * 
		 * @param fromPath
		 * @param toPath
		 * @param callback
		 * @return dropboxCommand
		 */
		public function fileMove(fromPath:String, toPath:String, 
								 root:String = DropboxConfig.SANDBOX):URLLoader
		{
			var params:Object = { 
				"root" : root, 
				"from_path": fromPath,
				"to_path": toPath
			};
			var urlRequest:URLRequest = buildURLRequest(
				config.server, "/fileops/move", params, URLRequestMethod.POST);
			return this.load(urlRequest, DropboxEvent.FILE_MOVE_RESULT, 
				DropboxEvent.FILE_MOVE_FAULT, DROPBOX_FILE);
		}
		
		/**
		 * Get metadata about directories and files, such as file listings and such.
		 */
		public function metadata(path:String, 
								 fileLimit:int, 
								 hash:String, 
								 list:Boolean,
								 root:String = DropboxConfig.SANDBOX
		):URLLoader
		{
			var params:Object = {
				"file_limit" : fileLimit,
				"hash": hash,
				"list": list
			};
			
			var urlRequest:URLRequest = buildURLRequest(
				config.server, "/metadata/" + root + '/' + path, params);
			return this.load(urlRequest, DropboxEvent.METADATA_RESULT, 
				DropboxEvent.METADATA_FAULT, DROPBOX_FILE);
		}		
		
		/**
		 * Get a file from the content server, returning the raw Apache HTTP Components response object
		 * so you can stream it or work with it how you need. 
		 * You *must* call .getEntity().consumeContent() on the returned HttpResponse object or you might leak 
		 * connections.
		 * 
		 * @param filePath
		 * @return dropboxCommand
		 * 
		 */
		public function getFile(filePath:String, 
								root:String=DropboxConfig.SANDBOX):URLLoader
		{
			var urlRequest:URLRequest = buildURLRequest(
				config.contentServer, "/files/" + root + '/' + filePath, null);
			return this.load(urlRequest, DropboxEvent.GET_FILE_RESULT, 
				DropboxEvent.GET_FILE_FAULT, "", URLLoaderDataFormat.BINARY);
			
//			return this.buildRequestCommand(ByteArray,
//				content_host, "/files/" + SANDBOX + '/' + filePath, auth, null, URLRequestMethod.GET);	
		}
		
		public function putFile(filePath:String, 
								fileName:String, 
								data:ByteArray, 
								box:String = DropboxConfig.SANDBOX):MultipartURLLoader
		{
			var url:String = this.buildFullURL(config.contentServer, '/files/' + box + '/' + filePath);
			var params:Object = { 
				"file" : fileName
			};
			var urlReqHeader:URLRequestHeader = OAuthHelper.buildURLRequestHeader(url, params, 
				config.consumerKey, config.consumerSecret, 
				config.accessTokenKey, config.accessTokenSecret, URLRequestMethod.POST);
			var m:MultipartURLLoader = new MultipartURLLoader();
			m.requestHeaders = [urlReqHeader];
			m.addFile(data, fileName, 'file');
			m.addEventListener(Event.COMPLETE, uploadCompleteHandler);
			m.addEventListener(IOErrorEvent.IO_ERROR, uploadIOErrorHandler);
			m.addEventListener(SecurityErrorEvent.SECURITY_ERROR, uploadSecurityErrorHandler);
			m.load(url);
			return m;
//			var cmd:DropboxUploadCommand = this.buildUploadCommand(fileRef.data, fileRef.name,
//				content_host, "/files/" + SANDBOX + '/' + filePath, auth, params);
//			return cmd;
		}
		
		protected function buildURLRequest(apiHost:String, target:String, params:Object,
									    httpMethod:String = URLRequestMethod.GET,
									    protocol:String = 'http'):URLRequest
		{
			var url:String = this.buildFullURL(apiHost, target, protocol);
			
			var urlReqHeader:URLRequestHeader = OAuthHelper.buildURLRequestHeader(url, params, 
				config.consumerKey, config.consumerSecret, 
				config.accessTokenKey, config.accessTokenSecret, httpMethod);
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.requestHeaders = [urlReqHeader];
			urlRequest.method = httpMethod;
			urlRequest.data = URLUtil.objectToString(params, '&');
			urlRequest.url = url;
			return urlRequest;
		}
		
		protected function load(urlRequest:URLRequest, 
								evtResultType:String, evtFaultType:String,
								resultType:String = null,
								dataFormat:String = URLLoaderDataFormat.TEXT):URLLoader
		{
			var urlLoader:DropboxURLLoader = new DropboxURLLoader();
			urlLoader.dataFormat = dataFormat;
			urlLoader.eventResultType = evtResultType;
			urlLoader.eventFaultType = evtFaultType;
			urlLoader.resultType = resultType;
			
			urlLoader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			
			urlLoader.load(urlRequest);
			return urlLoader;
		}
		
		protected function loadCompleteHandler(evt:Event):void
		{
			var urlLoader:DropboxURLLoader = DropboxURLLoader(evt.target);
			var resultObject:*;
			
			if (urlLoader.resultType == REQUEST_TOKEN) {
				var requestToken:Object = OAuthHelper.getTokenFromResponse(urlLoader.data);
				this.config.requestTokenKey = requestToken.key;
				this.config.requestTokenSecret = requestToken.secret;
				resultObject = requestToken;
			} else if (urlLoader.resultType == ACCESS_TOKEN) {
				var accessToken:Object = OAuthHelper.getTokenFromResponse(urlLoader.data);
				this.config.accessTokenKey = accessToken.key;
				this.config.accessTokenSecret = accessToken.secret;
				resultObject = accessToken;
			} else if (urlLoader.resultType == ACCOUNT_INFO) {
				var accountInfo:AccountInfo = new AccountInfo();
				accountInfo.decode(JSON.decode(urlLoader.data));
				resultObject = accountInfo;
			} else if (urlLoader.resultType == DROPBOX_FILE) {
				var dropboxFile:DropboxFile = new DropboxFile();
				dropboxFile.decode(JSON.decode(urlLoader.data));
				resultObject = dropboxFile;
			} else {
				resultObject = urlLoader.data;
			}
			
			this.dispatchDropboxEvent(urlLoader.eventResultType, evt, resultObject);
		}
		
		protected function uploadCompleteHandler(evt:Event):void
		{
			var m:MultipartURLLoader = MultipartURLLoader(evt.target);
			this.dispatchDropboxEvent(DropboxEvent.PUT_FILE_RESULT, evt, m.loader.data);
		}
		
		protected function uploadIOErrorHandler(evt:IOErrorEvent):void
		{
			this.dispatchDropboxEvent(DropboxEvent.PUT_FILE_FAULT, evt, null);
		}
		
		protected function uploadSecurityErrorHandler(evt:SecurityErrorEvent):void
		{
			this.dispatchDropboxEvent(DropboxEvent.PUT_FILE_FAULT, evt, null);
		}
		
		protected function dispatchDropboxEvent(
			evtType:String, relatedEvent:Event, resultObject:Object):void
		{
			var dropboxEvent:DropboxEvent = new DropboxEvent(evtType);
			dropboxEvent.resultObject = resultObject;
			dropboxEvent.relatedEvent = relatedEvent;
			this.dispatchEvent(dropboxEvent);
		}
		
		protected function ioErrorHandler(evt:IOErrorEvent):void
		{
			var urlLoader:DropboxURLLoader = DropboxURLLoader(evt.target);
			this.dispatchDropboxEvent(urlLoader.eventFaultType, evt, null);
		}
		
		protected function securityErrorHandler(evt:SecurityErrorEvent):void
		{
			var urlLoader:DropboxURLLoader = DropboxURLLoader(evt.target);
			this.dispatchDropboxEvent(urlLoader.eventFaultType, evt, null);
		}
			
		protected function buildFullURL(host:String, target:String, protocol:String = 'http'):String
		{
			var portString:String = (_config.port == 80) ? "" : (":" + _config.port);
			if (host.indexOf('http://') == 0 || host.indexOf('https://') == 0) {
				protocol = '';
			} else {
				protocol += "://";
			}
			return protocol + host + portString + '/' + config.apiVersion + target; 
		}
	}
}

import flash.net.URLLoader;

internal class DropboxURLLoader extends URLLoader
{
	public var resultType:String;
	public var eventResultType:String;
	public var eventFaultType:String;
}