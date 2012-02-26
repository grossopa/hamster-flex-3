package org.hamster.dropboxTool.command
{
	import flash.net.URLLoader;
	
	import org.hamster.dropboxTool.model.DropboxClientProxy;
	import org.hamster.framework.puremvc.HsSimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	public class AccessTokenRequestCommand extends HsSimpleCommand
	{
		public function AccessTokenRequestCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var clientProxy:DropboxClientProxy = DropboxClientProxy(facade.retrieveProxy(DropboxClientProxy.NAME));
			clientProxy.accessToken();
		}
	}
}