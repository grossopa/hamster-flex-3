package org.hamster.test.networks.command
{
	import org.hamster.networks.command.AbstractCommand;
	import org.hamster.networks.command.ICommand;
	import org.hamster.networks.service.HTTPServiceLocator;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;

	public class GetGoogleCmd extends AbstractCommand implements ICommand, IResponder
	{
		public function GetGoogleCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var sl:HTTPServiceLocator = HTTPServiceLocator.getInstance();
			sl.sendService("google", this);
		}
		
		override public function result(data:Object):void
		{
			Alert.show(String(data.result));
			super.result(data);
		}
		
		override public function fault(info:Object):void
		{
			Alert.show(String(info));
			super.fault(info);
		}
		
	}
}