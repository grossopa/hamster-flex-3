package org.hamster.magic.common.events
{
	import flash.events.Event;
	
	public class PopupEvent extends Event
	{
		public static const APPLY_CLOSE:String = "PopupEvent_applyClose";
		public static const CANCEL:String = "PopupEvent_cancel";
		
		public function PopupEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:PopupEvent = new PopupEvent(type, bubbles, cancelable);
			return result;
		}
	}
}