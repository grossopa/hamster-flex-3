package org.hamster.components.chrometab.events
{
	import flash.events.Event;
	
	import org.hamster.components.chrometab.unit.ChromeTabUnit;

	public class ChromeTabEvent extends Event
	{
		public static const TAB_ADDED:String = "chromeTabAdded";
		public static const TAB_SELECTED:String = "chromeTabSelected";
		public static const TAB_START_DRAG:String = "chromeTabStartDrag";
		public static const TAB_END_DRAG:String = "chromeTabEndDrag";
		
		/**
		 * move/select/delete
		 */
		public var selectdTab:ChromeTabUnit;
		
		public function ChromeTabEvent(type:String, 
				bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}