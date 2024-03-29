package org.hamster.commands.impl
{
	import flash.events.Event;
	
	import org.hamster.commands.AbstractCommandWrapper;
	import org.hamster.commands.ICommand;
	import org.hamster.commands.ICommandWrapper;
	import org.hamster.commands.events.CommandEvent;
	
	public class CommandQueue extends AbstractCommandWrapper implements ICommand
	{
		public var failedThenQuit:Boolean;
		
		public function CommandQueue(cmdArray:Array, failedThenQuit:Boolean = false)
		{
			this.cmdArray = cmdArray;
			this.failedThenQuit = failedThenQuit;
		}
		
		override public function execute():void
		{
			nextIndex = 0;
			
			if (cmdArray == null || cmdArray.length == 0) {
				return;
			} else {
				this.executeNext(ICommand(cmdArray[0]));
			}
		}
		
		private function executeNext(cmd:ICommand):void
		{
			addListener(cmd);
			cmd.cmdWrapper = this;
			cmd.execute();
		}
		
		private function cmdResult(evt:Event = null):void
		{
			var cmd:ICommand = ICommand(evt.currentTarget);
			removeListener(cmd);
			nextIndex++;	
			if (cmdArray.length == nextIndex) {
				this.result(null);
			} else {
				this.executeNext(ICommand(cmdArray[nextIndex]));
			}
		}
		
		private function cmdFault(evt:Event = null):void
		{
			var cmd:ICommand = ICommand(evt.currentTarget);
			removeListener(cmd);
			nextIndex++;	
			if (this.failedThenQuit) {
				this.fault(null);
			} else if (cmdArray.length == nextIndex) {
				this.result(null);
			} else {
				this.executeNext(ICommand(cmdArray[nextIndex]));
			} 
		}
		
		private function addListener(cmd:ICommand):void
		{
			cmd.addEventListener(CommandEvent.COMMAND_RESULT, cmdResult);
			cmd.addEventListener(CommandEvent.COMMAND_FAULT, cmdFault);			
		}
		
		private function removeListener(cmd:ICommand):void
		{
			cmd.removeEventListener(CommandEvent.COMMAND_RESULT, cmdResult);
			cmd.removeEventListener(CommandEvent.COMMAND_FAULT, cmdFault);
		}
		
		

	}
}