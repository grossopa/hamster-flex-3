package org.hamster.components.pagination
{
	import flash.events.Event;
	
	public class PaginationEvent extends Event
	{
		public static const CHANGE:String = "change";
		
		public var oldIndex:int;
		public var newIndex:int;
		
		public function PaginationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:PaginationEvent = new PaginationEvent(type, bubbles, cancelable);
			result.oldIndex = this.oldIndex;
			result.newIndex = this.newIndex;
			return result;
		}
	}
}