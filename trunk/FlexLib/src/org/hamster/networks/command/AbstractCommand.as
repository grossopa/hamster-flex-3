package org.hamster.networks.command
{
	import mx.rpc.IResponder;
	
	public class AbstractCommand implements ICommand, IResponder
	{
		
		public var commandResponder:ICommandResponder;
		
		public function AbstractCommand()
		{
			
		}
		
		public function execute():void
		{
			
		}
		
		public function result(data:Object):void
		{
			if (commandResponder != null) {
				commandResponder.commandResult(this);
			}
		}
		
		public function fault(info:Object):void
		{
			if (commandResponder != null){
				commandResponder.commandFault(this);
			}
		}
		

	}
}