package org.hamster.commands
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.hamster.commands.events.CommandEvent;
	
	public class AbstractCommand extends EventDispatcher implements ICommand
	{
		
		public function AbstractCommand()
		{
		}
		
		public function execute():void
		{
			// abstract function
		}
		
		public function result(evt:Event = null):void
		{
			this.dispatchEvent(new CommandEvent(CommandEvent.COMMAND_RESULT));
		}
		
		public function fault(evt:Event = null):void
		{
			this.dispatchEvent(new CommandEvent(CommandEvent.COMMAND_FAULT));
		}

	}
}