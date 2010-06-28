package org.hamster.commands.events
{
	import flash.events.Event;

	public class CommandEvent extends Event
	{
		public var data:Object;
		
		public static const COMMAND_RESULT:String = "CommandEventCommandResult";
		public static const COMMAND_FAULT:String = "CommandEventCommandFault";
		
		public function CommandEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}