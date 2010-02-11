package org.hamster.gamesaver.events
{
	import flash.events.Event;

	public class TextInputEvent extends Event
	{
		public static const APPLY_CHANGE:String = "textInputEventApplyChange";
		
		public function TextInputEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var newEvt:TextInputEvent = new TextInputEvent(type, bubbles, cancelable);
			return newEvt;
		}
		
	}
}