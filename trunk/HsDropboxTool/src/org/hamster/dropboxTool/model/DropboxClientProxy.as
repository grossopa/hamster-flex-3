package org.hamster.dropboxTool.model
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	
	import org.hamster.dropbox.DropboxClient;
	import org.hamster.dropbox.DropboxEvent;
	import org.hamster.dropboxTool.constant.AppConstants;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class DropboxClientProxy extends Proxy
	{
		public static const NAME:String = "DropboxClientProxy";
		
		public var dropboxClient:DropboxClient;
		
		public function DropboxClientProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function requestToken():void
		{
			dropboxClient.requestToken();
			dropboxClient.addEventListener(DropboxEvent.REQUEST_TOKEN_RESULT, requestTokenResultHandler);
			dropboxClient.addEventListener(DropboxEvent.REQUEST_TOKEN_FAULT, requestTokenFaultHandler);
		}
		
		private function requestTokenResultHandler(event:DropboxEvent):void
		{
			dropboxClient.removeEventListener(DropboxEvent.REQUEST_TOKEN_RESULT, requestTokenResultHandler);
			this.sendNotification(AppConstants.REQUEST_TOKEN_RESULT, dropboxClient.config);
		}
		
		private function requestTokenFaultHandler(event:DropboxEvent):void
		{
			dropboxClient.removeEventListener(DropboxEvent.REQUEST_TOKEN_RESULT, requestTokenFaultHandler);
			this.sendNotification(AppConstants.REQUEST_TOKEN_FAULT, event.resultObject);
		}
		
		public function accessToken():void
		{
			dropboxClient.accessToken();
			dropboxClient.addEventListener(DropboxEvent.ACCESS_TOKEN_RESULT, accessTokenResultHandler);
			dropboxClient.addEventListener(DropboxEvent.ACCESS_TOKEN_FAULT, accessTokenFaultHandler);
		}
		
		private function accessTokenResultHandler(event:DropboxEvent):void
		{
			dropboxClient.removeEventListener(DropboxEvent.ACCESS_TOKEN_RESULT, requestTokenResultHandler);
			this.sendNotification(AppConstants.ACCESS_TOKEN_RESULT, dropboxClient.config);
		}
		
		private function accessTokenFaultHandler(event:DropboxEvent):void
		{
			dropboxClient.removeEventListener(DropboxEvent.ACCESS_TOKEN_FAULT, requestTokenFaultHandler);
			this.sendNotification(AppConstants.ACCESS_TOKEN_FAULT, event.resultObject);
		}
		
		public function metadata(path:String):void
		{
			var configurationVO:ConfigurationVO = getConfigurationVOProxy().configurationVO;
			dropboxClient.metadata(path, configurationVO.metadataSizeLimit, "", true, false);
			dropboxClient.addEventListener(DropboxEvent.METADATA_RESULT, metadataResultHandler);
			dropboxClient.addEventListener(DropboxEvent.METADATA_FAULT, metadataFaultHandler);
		}
		
		private function metadataResultHandler(event:DropboxEvent):void
		{
			dropboxClient.removeEventListener(DropboxEvent.METADATA_RESULT, requestTokenFaultHandler);
			this.sendNotification(AppConstants.METADATA_RESULT, event.resultObject);
		}
		
		private function metadataFaultHandler(event:DropboxEvent):void
		{
			dropboxClient.removeEventListener(DropboxEvent.METADATA_RESULT, requestTokenFaultHandler);
			this.sendNotification(AppConstants.METADATA_FAULT, event.resultObject);
		}
		
		private function getConfigurationVOProxy():ConfigurationVOProxy
		{
			return ConfigurationVOProxy(facade.retrieveProxy(ConfigurationVOProxy.NAME));
		}
		
		
		
		
	}
}