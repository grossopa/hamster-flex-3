package org.hamster.networks.command
{
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.hamster.errors.ExtendError;
		
	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 * 
	 */
	 
	public class AbstractCommand implements ICommand, IResponder
	{
		public var commandResponder:ICommandResponder;
		public var dataFormatter:IDataFormatter;
		
		public function AbstractCommand()
		{
			
		}
		
		public function execute():void
		{
			throw new ExtendError(ExtendError.ABSTRACT);
		}
		
		public function result(data:Object):void
		{
			var formattedData:*;
			if(data is ResultEvent && this.dataFormatter != null) {
				formattedData = dataFormatter.formatResult(ResultEvent(data));
			}
			if (commandResponder != null) {
				commandResponder.commandResult(this, formattedData);
			}
		}
		
		public function fault(info:Object):void
		{
			var formattedData:*;
			if(info is FaultEvent && this.dataFormatter != null) {
				formattedData = dataFormatter.formatFault(FaultEvent(info));
			}
			if (commandResponder != null){
				commandResponder.commandFault(this, formattedData);
			}
		}
		

	}
}