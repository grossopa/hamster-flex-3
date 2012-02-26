package org.hamster.dropboxTool.view.components
{
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.hamster.common.util.StringUtil;
	import org.hamster.dropbox.DropboxConfig;
	import org.hamster.dropboxTool.constant.AppConstants;
	import org.hamster.dropboxTool.model.ConfigurationVO;
	import org.hamster.dropboxTool.model.ConfigurationVOProxy;
	import org.hamster.dropboxTool.model.DropboxClientProxy;
	import org.hamster.framework.puremvc.HsMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	public class LoginWindowMediator extends HsMediator
	{
		public static const NAME:String = "LoginWindowMediator";
		
		public function LoginWindowMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			app.accessTokenBtn.addEventListener(MouseEvent.CLICK, accessTokenBtnClickHandler);
		}
		
		override public function onRemove():void
		{
			app.accessTokenBtn.removeEventListener(MouseEvent.CLICK, accessTokenBtnClickHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppConstants.CONFIGURATION_SAVE_RESULT,
				AppConstants.CONFIGURATION_LOAD_FAULT,
				AppConstants.CONFIGURATION_LOAD_RESULT,
				AppConstants.REQUEST_TOKEN_FAULT,
				AppConstants.REQUEST_TOKEN_RESULT,
				AppConstants.ACCESS_TOKEN_RESULT,
				AppConstants.ACCESS_TOKEN_FAULT,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			switch (name) {
				case AppConstants.CONFIGURATION_LOAD_RESULT:
					handleConfigurationLoadResult(notification.getBody());
					break;
				case AppConstants.CONFIGURATION_LOAD_FAULT:
					handleConfigurationLoadFault(notification.getBody());
					break;
				case AppConstants.CONFIGURATION_SAVE_RESULT:
					handleConfigurationSaveResult(notification.getBody());
					break;
				case AppConstants.REQUEST_TOKEN_RESULT:
					handleRequestTokenResult(notification.getBody());
					break;
				case AppConstants.REQUEST_TOKEN_FAULT:
					handleRequestTokenFault(notification.getBody());
					break;
				case AppConstants.ACCESS_TOKEN_RESULT:
					handleAccessTokenResult(notification.getBody());
					break;
				case AppConstants.ACCESS_TOKEN_FAULT:
					handleAccessTokenFault(notification.getBody());
					break;
			}
		}
		
		public function loadConfiguration():void
		{
			app.processMaskLbl.text = app.getRBString("loginWindow.loadUserProfile");
			this.sendNotification(AppConstants.CONFIGURATION_LOAD_REQUEST);
		}
		
		public function fetchRequestToken():void
		{
			app.processMaskLbl.text = app.getRBString("loginWindow.fetchingRequestToken");
			
			this.sendNotification(AppConstants.REQUEST_TOKEN_REQUEST);
		}
		public function fetchAccessToken():void
		{
			app.processMaskLbl.text = app.getRBString("loginWindow.fetchingAccessToken");
			app.processMask.visible = true;
			
			this.sendNotification(AppConstants.ACCESS_TOKEN_REQUEST);
		}
		
		public function accessTokenBtnClickHandler(event:MouseEvent):void
		{
			fetchAccessToken();
		}
		
		public function handleConfigurationLoadResult(data:Object):void
		{
			var configurationVO:ConfigurationVO = ConfigurationVOProxy(facade.retrieveProxy(ConfigurationVOProxy.NAME)).configurationVO;
			if (configurationVO) {
				if (StringUtil.isEmpty(configurationVO.requestTokenKey)) {
					this.fetchRequestToken();
				} else if (StringUtil.isEmpty(configurationVO.accessTokenKey)) {
					this.fetchAccessToken();
				} else {
					sendNotification(AppConstants.SHOW_FILE_LIST_VIEW);
				}
			} else {
				this.fetchRequestToken();
			}
		}
		
		public function handleConfigurationLoadFault(data:Object):void
		{
			this.fetchRequestToken();
		}
		
		public function handleConfigurationSaveResult(data:Object):void
		{
			this.sendNotification(AppConstants.SHOW_FILE_LIST_VIEW);
		}
		
		public function handleRequestTokenResult(data:Object):void
		{
			//app.processMaskLbl.text = app.getRBString("loginWindow.requestTokenResult");
			app.authenticationConfirmCont.visible = true;
			app.processMask.visible = false;
			
			var configurationVOProxy:ConfigurationVOProxy = ConfigurationVOProxy(facade.retrieveProxy(ConfigurationVOProxy.NAME));
			var configurationVO:ConfigurationVO  	= configurationVOProxy.configurationVO;
			configurationVO.requestTokenKey 		= DropboxConfig(data).requestTokenKey;
			configurationVO.requestTokenSecret 		= DropboxConfig(data).requestTokenSecret;
			
			var dropboxClientProxy:DropboxClientProxy = DropboxClientProxy(facade.retrieveProxy(DropboxClientProxy.NAME));
			navigateToURL(new URLRequest(dropboxClientProxy.dropboxClient.authorizationUrl));
		}
		
		public function handleRequestTokenFault(data:Object):void
		{
			app.processMaskLbl.text = app.getRBString("loginWindow.requestTokenFault");
		}
		
		public function handleAccessTokenResult(data:Object):void
		{
			var configurationVOProxy:ConfigurationVOProxy = ConfigurationVOProxy(facade.retrieveProxy(ConfigurationVOProxy.NAME));
			var configurationVO:ConfigurationVO  	= configurationVOProxy.configurationVO;
			configurationVO.accessTokenKey 			= DropboxConfig(data).accessTokenKey;
			configurationVO.accessTokenSecret 		= DropboxConfig(data).accessTokenSecret;
			
			sendNotification(AppConstants.CONFIGURATION_SAVE_REQUEST);
			// this.sendNotification(AppConstants.SHOW_FILE_LIST_VIEW);
		}
		
		public function handleAccessTokenFault(data:Object):void
		{
			app.processMaskLbl.visible = false;
		}
		
		public function get app():LoginWindow
		{
			return LoginWindow(viewComponent);
		}
	}
}