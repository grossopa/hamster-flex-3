package org.hamster.test.networks.command
{
	import mx.rpc.IResponder;
	
	import org.hamster.networks.command.AbstractCommand;
	import org.hamster.networks.command.ICommand;
	import org.hamster.networks.service.HTTPServiceLocator;
	import org.hamster.test.networks.command.formatter.TestFormatter;

	public class GetGoogleCmd extends AbstractCommand implements ICommand, IResponder
	{
		public function GetGoogleCmd()
		{
			super();
			this.dataFormatter = TestFormatter.getInstance();
		}
		
		override public function execute():void
		{
			var sl:HTTPServiceLocator = HTTPServiceLocator.getInstance();
			sl.sendService("google", this);
		}
		
	}
}