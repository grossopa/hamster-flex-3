package org.hamster.dropboxTool.command
{
	import org.hamster.dropbox.DropboxConfig;
	import org.hamster.dropboxTool.model.ConfigurationVOProxy;
	import org.hamster.dropboxTool.model.DropboxConfigProxy;
	import org.hamster.framework.puremvc.HsSimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	public class ConfigurationLoadCommand extends HsSimpleCommand
	{
		public function ConfigurationLoadCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var proxy:ConfigurationVOProxy = ConfigurationVOProxy(facade.retrieveProxy(ConfigurationVOProxy.NAME));
			proxy.load();
		}
	}
}