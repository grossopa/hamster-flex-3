package org.hamster.magic.common.events
{
	import flash.events.Event;

	public class ViewEvent extends Event
	{
		public static const CLOSE:String = "ViewEventClose";
		
		public function ViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:ViewEvent = new ViewEvent(type, bubbles, cancelable);
			return result;
		}
		
	}
}