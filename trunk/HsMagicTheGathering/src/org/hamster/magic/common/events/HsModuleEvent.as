package org.hamster.magic.common.events
{
	import flash.events.Event;

	public class HsModuleEvent extends Event
	{
		public static const CLOSE:String = "ViewEventClose";
		
		public function HsModuleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:HsModuleEvent = new HsModuleEvent(type, bubbles, cancelable);
			return result;
		}
		
	}
}