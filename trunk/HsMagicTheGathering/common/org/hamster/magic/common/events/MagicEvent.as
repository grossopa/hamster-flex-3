package org.hamster.magic.common.events
{
	import flash.events.Event;
	
	import org.hamster.common.utils.ArrayUtil;
	

	public class MagicEvent extends Event
	{
		public static const CHANGE:String = "MagicEvent_Change";
		public static const MULTI_CHANGE:String = "MagicEvent_MultiChange";
		
		public var color:String;
		public var oldValue:int;
		public var newValue:int;
		
		public var colors:Array;
		public var oldValues:Array;
		public var newValues:Array;
		
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
			if (this.colors != null) {
				evt.colors = ArrayUtil.shallowCopyArray(this.colors);
			}
			if (this.oldValues != null) {
				evt.oldValues = ArrayUtil.shallowCopyArray(this.oldValues);
			}
			if (this.newValues != null) {
				evt.newValues = ArrayUtil.shallowCopyArray(this.newValues);
			}
			return evt;
		}
		
	}
}