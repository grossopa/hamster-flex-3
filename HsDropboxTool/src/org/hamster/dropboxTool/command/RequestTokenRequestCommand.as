package org.hamster.dropboxTool.command
{
	import org.hamster.dropboxTool.model.DropboxClientProxy;
	import org.hamster.dropboxTool.model.DropboxConfigProxy;
	import org.hamster.framework.puremvc.HsSimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	public class RequestTokenRequestCommand extends HsSimpleCommand
	{
		public function RequestTokenRequestCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var dropboxClientProxy:DropboxClientProxy = DropboxClientProxy(facade.retrieveProxy(DropboxClientProxy.NAME));
			dropboxClientProxy.requestToken();
		}
	}
}