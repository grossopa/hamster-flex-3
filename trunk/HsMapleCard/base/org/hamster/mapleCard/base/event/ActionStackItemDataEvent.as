package org.hamster.mapleCard.base.event
{
	import flash.events.Event;
	
	import org.hamster.mapleCard.base.model.IActionStackItemData;
	
	public class ActionStackItemDataEvent extends Event
	{
		public static const ACTIONPROGRESS_CHANGED:String = "ActionStackItemDataEvent_actionProgressChanged";
		public static const ACTIONPSTATUS_CHANGED:String = "ActionStackItemDataEvent_actionStatusChanged";
		public static const PICK_UP_NEXT_ACTION_ITEM:String = "ActionStackItemDataEvent_pickUpNextActionItem";
		
		public var oldValue:*;
		public var newValue:*;
		
		public var pickUpItemData:IActionStackItemData;
		
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