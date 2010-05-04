package org.hamster.magic.common.events
{
	import flash.events.Event;

	public class MagicEvent extends Event
	{
		public static const CHANGE:String = "MagicEventChange";
		
		public var color:String;
		public var oldValue:int;
		public var newValue:int;
		
		public function MagicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var evt:MagicEvent = new MagicEvent(type, bubbles, cancelable);
			evt.color = this.color;
			evt.oldValue = this.oldValue;
			evt.newValue = this.newValue;
			return evt;
		}
		
	}
}