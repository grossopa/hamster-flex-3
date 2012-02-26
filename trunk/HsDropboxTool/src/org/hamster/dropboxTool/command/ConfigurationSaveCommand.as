package org.hamster.dropboxTool.command
{
	import org.hamster.dropboxTool.model.ConfigurationVOProxy;
	import org.hamster.framework.puremvc.HsSimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	public class ConfigurationSaveCommand extends HsSimpleCommand
	{
		public function ConfigurationSaveCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var proxy:ConfigurationVOProxy = ConfigurationVOProxy(facade.retrieveProxy(ConfigurationVOProxy.NAME));
			proxy.save();
		}
	}
}