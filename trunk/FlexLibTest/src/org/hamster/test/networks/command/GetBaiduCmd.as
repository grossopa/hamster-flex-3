package org.hamster.test.networks.command
{
	import org.hamster.networks.command.AbstractCommand;
	import org.hamster.networks.command.ICommand;
	import org.hamster.networks.service.HTTPServiceLocator;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;

	public class GetBaiduCmd extends AbstractCommand implements ICommand, IResponder
	{
		public function GetBaiduCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var sl:HTTPServiceLocator = HTTPServiceLocator.getInstance();
			sl.sendService("baidu", this, null, "http://www.baidu.com");
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