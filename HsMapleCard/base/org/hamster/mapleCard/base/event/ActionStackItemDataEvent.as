package org.hamster.mapleCard.base.event
{
	import flash.events.Event;
	
	public class ActionStackItemDataEvent extends Event
	{
		public static const ACTIONPROGRESS_CHANGED:String = "ActionStackItemEvent_actionProgressChanged";
		
		public var oldValue:*;
		public var newValue:*;
		
		public function ActionStackItemDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:ActionStackItemDataEvent = new ActionStackItemDataEvent(type, bubbles, cancelable);
			result.oldValue = this.oldValue;
			result.newValue = this.newValue;
			return result;
		}
	}
}