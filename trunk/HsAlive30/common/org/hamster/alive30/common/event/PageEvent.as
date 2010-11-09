package org.hamster.alive30.common.event
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class PageEvent extends Event
	{
		public static const PAGE_CHANGE:String = "pageChange";
		
		public var oldPageMediatorName:String;
		public var newPageMediatorName:String;
		public var oldContainer:DisplayObjectContainer;
		public var newContainer:DisplayObjectContainer;
		public var data:Object;
		
		public function PageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:PageEvent = new PageEvent(type, bubbles, cancelable);
			result.oldPageMediatorName = oldPageMediatorName;
			result.newPageMediatorName = newPageMediatorName;
			result.oldContainer = oldContainer;
			result.newContainer = newContainer;
			result.data = data;
			return result;
		}
	}
}