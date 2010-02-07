package org.hamster.gamesaver.events
{
	import flash.events.Event;
	
	import org.hamster.commands.ICommand;

	public class CommandProgressEvent extends Event
	{
		public static const PROGRESS_CHANGE:String = "CommandProgressEventProgressChange";
		
		public var percent:Number;
		public var currentCmd:ICommand;
		public var currentResult:String;
		
		public function CommandProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:CommandProgressEvent = new CommandProgressEvent(type, bubbles, cancelable);
			result.percent = this.percent;
			return result;
		}
		
	}
}