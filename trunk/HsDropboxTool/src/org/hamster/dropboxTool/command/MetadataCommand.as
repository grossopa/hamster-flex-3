package org.hamster.dropboxTool.command
{
	import org.hamster.dropboxTool.model.DropboxClientProxy;
	import org.hamster.dropboxTool.util.CommonUtil;
	import org.hamster.framework.puremvc.HsSimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	public class MetadataCommand extends HsSimpleCommand
	{
		public function MetadataCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var dropboxClientProxy:DropboxClientProxy = DropboxClientProxy(facade.retrieveProxy(DropboxClientProxy.NAME));
			var path:String = notification.getBody() == null ? "" : notification.getBody() as String;
			dropboxClientProxy.metadata(CommonUtil.correctDropboxPath(path));
		}
	}
}