package org.hamster.gamesaver.events
{
	import flash.events.Event;

	public class ChildComponentEvent extends Event
	{
		public static const DELETE:String = "ChildComponentEventDelete";
		
		public function ChildComponentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var evt:ChildComponentEvent = new ChildComponentEvent(type, bubbles, cancelable);
			return evt;
		}
		
	}
}