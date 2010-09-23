package org.hamster.closableTab
{
	import flash.events.Event;
	
	public class HsClosableTabEvent extends Event
	{
		public static const CLOSE_TAB:String = "closeTab";
		
		public var index:int;
		
		public function HsClosableTabEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:HsClosableTabEvent = new HsClosableTabEvent(type, bubbles, cancelable);
			result.index = index;
			return result;
		}
	}
}