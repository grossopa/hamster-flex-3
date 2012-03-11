package org.hamster.dropboxTool.mediator
{
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	
	import org.hamster.dropbox.DropboxClient;
	import org.hamster.dropbox.DropboxConfig;
	import org.hamster.dropboxTool.command.AccessTokenRequestCommand;
	import org.hamster.dropboxTool.command.ConfigurationLoadCommand;
	import org.hamster.dropboxTool.command.MetadataCommand;
	import org.hamster.dropboxTool.command.RequestTokenRequestCommand;
	import org.hamster.dropboxTool.constant.AppConstants;
	import org.hamster.dropboxTool.model.ConfigurationVOProxy;
	import org.hamster.dropboxTool.model.DropboxClientProxy;
	import org.hamster.dropboxTool.model.DropboxConfigProxy;
	import org.hamster.dropboxTool.util.CommonUtil;
	import org.hamster.dropboxTool.view.components.FileWindow;
	import org.hamster.dropboxTool.view.components.FileWindowMediator;
	import org.hamster.dropboxTool.view.components.LoginWindow;
	import org.hamster.dropboxTool.view.components.LoginWindowMediator;
	import org.hamster.dropboxTool.view.components.global.ProcessMask;
	import org.hamster.framework.puremvc.HsMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	public class AppMediator extends HsMediator
	{
		public static const NAME:String = "AppMediator";
		private var processMask:ProcessMask;
		
		public function AppMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		///////////////////////////////////
		// register and remove listeners //
		///////////////////////////////////
		override public function onRegister():void
		{
			// initialize
			facade.registerCommand(AppConstants.CONFIGURATION_LOAD_REQUEST, ConfigurationLoadCommand);
			
			facade.registerCommand(AppConstants.REQUEST_TOKEN_REQUEST, RequestTokenRequestCommand);
			facade.registerCommand(AppConstants.ACCESS_TOKEN_REQUEST, AccessTokenRequestCommand);
			
			facade.registerCommand(AppConstants.METADATA_REQUEST, MetadataCommand);
			
			var dropboxClientProxy:DropboxClientProxy = new DropboxClientProxy();
			var dropboxConfigProxy:DropboxConfigProxy = new DropboxConfigProxy();
			dropboxConfigProxy.dropboxConfig = new DropboxConfig("wnl0erseogu50mk", "eypos93aukcysdw");
			dropboxClientProxy.dropboxClient = new DropboxClient(dropboxConfigProxy.dropboxConfig);
			
			facade.registerProxy(new ConfigurationVOProxy());
			facade.registerProxy(dropboxConfigProxy);
			facade.registerProxy(dropboxClientProxy);
			
			ResourceManager.getInstance().localeChain = ['en_US'];
			showLoginWindow();
		}
		
		override public function onRemove():void
		{
			facade.removeCommand(AppConstants.CONFIGURATION_LOAD_REQUEST);
			
			facade.removeProxy(ConfigurationVOProxy.NAME);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppConstants.SHOW_FILE_LIST_VIEW,
			].concat([
				AppConstants.METADATA_REQUEST,
				AppConstants.METADATA_RESULT,
				AppConstants.METADATA_FAULT,
			]);
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			switch (name) {
				case AppConstants.SHOW_FILE_LIST_VIEW:
					hideLoginWindow();
					showFileListDetailsWindow();
					break;

			}
			
			// show popup
			switch (name) {
				case AppConstants.METADATA_REQUEST:
					handleShowProcessMask(notification.getBody());
			}
			
			// hide popup
			switch (name) {
				case AppConstants.METADATA_RESULT:
				case AppConstants.METADATA_FAULT:
					handleHideProcessMask(notification.getBody());
					break;
			}
		}
		
		public function showLoginWindow():void
		{
			var loginWindow:LoginWindow = LoginWindow(CommonUtil.popup(LoginWindow, app));
			var loginWindowMediator:LoginWindowMediator = new LoginWindowMediator(loginWindow);
			facade.registerMediator(loginWindowMediator);
			
			loginWindowMediator.loadConfiguration();
		}
		
		public function hideLoginWindow():void
		{
			var loginWindowMediator:LoginWindowMediator = LoginWindowMediator(facade.retrieveMediator(LoginWindowMediator.NAME));
			CommonUtil.removePopUp(loginWindowMediator.app);
			facade.removeMediator(LoginWindowMediator.NAME);
		}
		
		public function handleShowProcessMask(data:Object):void
		{
			if (!processMask) {
				processMask = ProcessMask(PopUpManager.createPopUp(app, ProcessMask, true));
				PopUpManager.centerPopUp(processMask);
			}
		}
		
		public function handleHideProcessMask(data:Object):void
		{
			if (processMask) {
				PopUpManager.removePopUp(processMask);
				processMask = null;
			}
		}
		
		public function showFileListDetailsWindow():void
		{
			var fileWindow:FileWindow = new FileWindow();
			facade.registerMediator(new FileWindowMediator(fileWindow));
			app.addElement(fileWindow);
		}
		
		public function get app():HsDropboxTool
		{
			return HsDropboxTool(viewComponent);
		}
	}
}