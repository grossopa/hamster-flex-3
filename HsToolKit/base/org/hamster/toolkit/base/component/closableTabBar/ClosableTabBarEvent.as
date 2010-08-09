package org.hamster.toolkit.base.component.closableTabBar
{
	import flash.events.Event;
	
	public class ClosableTabBarEvent extends Event
	{
		public static const CLOSE_TAB:String = "ClosableTabBarEvent_CloseTab";
		
		public var index:int;
		
		public function ClosableTabBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:ClosableTabBarEvent = new ClosableTabBarEvent(type, bubbles, cancelable);
			result.index = index;
			return result;
		}
	}
}