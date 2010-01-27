package org.hamster.commands.impl
{
	import flash.events.Event;
	
	import org.hamster.commands.AbstractCommandWrapper;
	import org.hamster.commands.ICommand;
	import org.hamster.commands.events.CommandEvent;
	
	/**
	 * A command Queue enables a list of commands execute one by one.
	 */
	public class CommandQueue extends AbstractCommandWrapper implements ICommand
	{
		/**
		 * If this property is set to <code>true</code>, then once a command
		 * is failed during execute, then the Queue is stopped and dispatch
		 * a CommandEvent.COMMAND_FAULT event.
		 *
		 * <p>Default value is <code>false</code>.
		 */
		public var failedThenQuit:Boolean;
		
		/**
		 * Constructor
		 * 
		 * @param cmdArray ICommand Array.
		 * @param failedThenQuit
		 */
		public function CommandQueue(cmdArray:Array, failedThenQuit:Boolean = false)
		{
			this.cmdArray = cmdArray;
			this.failedThenQuit = failedThenQuit;
		}
		
		/**
		 * Execute commands one by one. After finished, a 
		 * <code>CommandEvent.COMMAND_RESULT</code> event is dispatched.
		 */
		override public function execute():void
		{
			_curIndex = 0;
			
			if (cmdArray == null || cmdArray.length == 0) {
				return;
			} else {
				for each (var cmd:ICommand in this.cmdArray) {
					cmd.cmdWrapper = this;
				}
				this.executeNext(ICommand(cmdArray[_curIndex]));
			}
		}
		
		/**
		 * @private
		 * 
		 * execute next command 
		 */
		private function executeNext(cmd:ICommand):void
		{
			addListener(cmd);
			cmd.cmdWrapper = this;
			cmd.execute();
		}
		
		/**
		 * @private
		 */
		private function cmdResult(evt:Event = null):void
		{
			var cmd:ICommand = ICommand(evt.currentTarget);
			removeListener(cmd);
			
			if (cmdArray.length == _curIndex + 1) {
				this.result(null);
			} else {
				this.executeNext(ICommand(cmdArray[_curIndex]));
			}
		}
		
		/**
		 * @private
		 */
		private function cmdFault(evt:Event = null):void
		{
			var cmd:ICommand = ICommand(evt.currentTarget);
			removeListener(cmd);
			_curIndex++;
			if (this.failedThenQuit) {
				this.fault(null);
			} else if (cmdArray.length == _curIndex + 1) {
				this.result(null);
			} else {
				this.executeNext(ICommand(cmdArray[_curIndex]));
			} 
		}
		
		/**
		 * _curIndex is set to -1.
		 */
		override public function result(data:Object):void
		{
			_curIndex = -1;
			super.result(data);
		}
		
		/**
		 * _curIndex is set to -1.
		 */
		override public function fault(info:Object):void
		{
			_curIndex = -1;
			super.fault(info);
		}
		
		/**
		 * @private
		 */
		private function addListener(cmd:ICommand):void
		{
			cmd.addEventListener(CommandEvent.COMMAND_RESULT, cmdResult);
			cmd.addEventListener(CommandEvent.COMMAND_FAULT, cmdFault);			
		}
		
		/**
		 * @private
		 */
		private function removeListener(cmd:ICommand):void
		{
			cmd.removeEventListener(CommandEvent.COMMAND_RESULT, cmdResult);
			cmd.removeEventListener(CommandEvent.COMMAND_FAULT, cmdFault);
		}
		
		

	}
}
