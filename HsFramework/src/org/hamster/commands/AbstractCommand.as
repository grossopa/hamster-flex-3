package org.hamster.commands
{
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	
	import mx.rpc.Responder;
	
	import org.hamster.commands.events.CommandEvent;
	
	/**
	 *  Dispatched when the command is done.
	 *
	 *  @eventType org.hamster.commands.events.CommandEvent.COMMAND_RESULT
	 */
	[Event(name="commandResult", type="org.hamster.commands.events.CommandEvent")]
	
	/**
	 *  Dispatched when the command is failed.
	 *
	 *  @eventType org.hamster.commands.events.CommandEvent.COMMAND_FAULT
	 */
	[Event(name="commandFault", type="org.hamster.commands.events.CommandEvent")]
	
	public class AbstractCommand extends EventDispatcher implements ICommand
	{
		/**
		 * some ugly design of ActionScript 3 use Responder instead of IResponder
		 * as function parameter.  so this command provide a way of using serf as
		 * Responder.
		 */
		private var _fnResponder:flash.net.Responder;
		private var _mrResponder:mx.rpc.Responder;
		
		private var _cmdWrapper:ICommandWrapper;
		
		/**
		 * 
		 */
		public function set cmdWrapper(value:ICommandWrapper):void
		{
			_cmdWrapper = value;
		}
		
		public function get cmdWrapper():ICommandWrapper
		{
			return _cmdWrapper;
		}
		
		
		public function get flashNetResponder():flash.net.Responder
		{
			return this._fnResponder;
		}
		
		public function get mxRpcResponder():mx.rpc.Responder
		{
			return this._mrResponder;
		}
		
		public function AbstractCommand()
		{
			_fnResponder = new flash.net.Responder(this.result, this.fault);
			_mrResponder = new mx.rpc.Responder(this.result, this.fault);
		}
		
		public function execute():void
		{
			// abstract function
		}
		
		public function result(data:Object):void
		{
			this.dispatchEvent(new CommandEvent(CommandEvent.COMMAND_RESULT));
		}
		
		public function fault(info:Object):void
		{
			this.dispatchEvent(new CommandEvent(CommandEvent.COMMAND_FAULT));
		}

	}
}