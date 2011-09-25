package org.hamster.enterprise.controls
{
	import flash.events.Event;
	
	public class InputFieldEvent extends Event
	{
		public static const HS_REQUIRED_CHANGE:String = "hsRequiredChange";
		
		public function InputFieldEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}