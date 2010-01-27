package org.hamster.commands
{
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	
	import mx.rpc.Responder;
	
	import org.hamster.commands.events.CommandEvent;
	
	/**
	 * Dispatched when the command is done. Sub-classes should call <code>super.result(data)</code>
	 * to dispatch this event or override this function and dispatch manually.
	 *
	 * @eventType org.hamster.commands.events.CommandEvent.COMMAND_RESULT
	 */
	[Event(name="commandResult", type="org.hamster.commands.events.CommandEvent")]
	
	/**
	 * Dispatched when the command is failed.
	 *
	 * @eventType org.hamster.commands.events.CommandEvent.COMMAND_FAULT
	 */
	[Event(name="commandFault", type="org.hamster.commands.events.CommandEvent")]
	
	/**
	 * Base command class.
	 * 
	 * <p>You extend this class and override <code>execute</code> function to
	 * write your own business logic. After execution (either synchronous or asynchronous),
	 * you should call <code>result(data)</code> and a <code>CommandEvent.COMMAND_RESULT</code>
	 * event contains <code>data</code> is dispatched.  If the execution is failed,
	 * you should call <code>fault(info)</code> and a <code>CommandEvent.COMMAND_FAULT</code>
	 * event contains <code>info</code> is dispatched.</p>
	 * 
	 */
	public class AbstractCommand extends EventDispatcher implements ICommand
	{
		/**
		 * Use self as <code>flash.net.Responder</code>.
		 */
		private var _fnResponder:flash.net.Responder;
		
		/**
		 * Not-null if this command is in a command wrapper.
		 */
		private var _cmdWrapper:ICommandWrapper;
		
		/**
		 * setter function of cmdWrapper, you do not set the value
		 * yourself.
		 */
		public function set cmdWrapper(value:ICommandWrapper):void
		{
			_cmdWrapper = value;
		}
		
		/**
		 * getter function of cmdWrapper
		 */
		public function get cmdWrapper():ICommandWrapper
		{
			return _cmdWrapper;
		}
		
		/**
		 * @private
		 */
		public function get flashNetResponder():flash.net.Responder
		{
			return this._fnResponder;
		}
		
		/**
		 * @private
		 * 
		 * Constructor
		 */
		public function AbstractCommand()
		{
			_fnResponder = new flash.net.Responder(this.result, this.fault);
		}
		
		/**
		 * Abstract function, sub-classes should override this function.
		 */
		public function execute():void
		{
			// abstract function
		}
		
		/**
		 * call this function and a result event is dispatched.
		 * 
		 * @param data
		 */
		public function result(data:Object):void
		{
			var evt:CommandEvent = new CommandEvent(CommandEvent.COMMAND_RESULT);
			evt.data = data;
			this.dispatchEvent(evt);
		}
		
		
		/**
		 * call this function and a fault event is dispatched.
		 * 
		 * @param data
		 */
		public function fault(info:Object):void
		{
			var evt:CommandEvent = new CommandEvent(CommandEvent.COMMAND_FAULT);
			evt.data = info;
			this.dispatchEvent(evt);
		}

	}
}