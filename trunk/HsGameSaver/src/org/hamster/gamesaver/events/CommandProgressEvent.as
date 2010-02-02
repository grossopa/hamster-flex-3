package org.hamster.gamesaver.events
{
	import flash.events.Event;

	public class CommandProgressEvent extends Event
	{
		public static const PROGRESS_CHANGE:String = "CommandProgressEventProgressChange";
		
		public var percent:Number;
		
		public function CommandProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}