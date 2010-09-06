package org.hamster.closableTab
{
	import flash.events.Event;
	
	public class HsClosableTabBarEvent extends Event
	{
		public static const CLOSE_TAB:String = "ClosableTabBarEvent_CloseTab";
		
		public var index:int;
		
		public function HsClosableTabBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:HsClosableTabBarEvent = new HsClosableTabBarEvent(type, bubbles, cancelable);
			result.index = index;
			return result;
		}
	}
}