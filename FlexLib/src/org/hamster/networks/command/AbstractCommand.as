package org.hamster.networks.command
{
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.hamster.errors.ExtendError;
		
	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 * You can define your own service command by extends this class.
	 * 
	 * This class supports the HTTPRequest, this class is an IResponder so that
	 * you can override execute function like:
	 * 
	 * override public function execute():void
	 * {
	 * 		HTTPServiceLocator.getInstance().sendService("getContent", this);
	 * }
	 * 
	 */
	 
	public class AbstractCommand implements ICommand, IResponder
	{
		
		/**
		 * The final commandResponder, usually is a controller object.
		 */
		public var commandResponder:ICommandResponder;
		
		/**
		 * Interface to format data.
		 */
		public var dataFormatter:IDataFormatter;
		
		public function AbstractCommand()
		{
			
		}
		
		/**
		 * Abstrct function.
		 */
		public function execute():void
		{
			throw new ExtendError(ExtendError.ABSTRACT);
		}
		
		/**
		 * IResponder.result
		 */
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
		
		/**
		 * IResponder.fault
		 */
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