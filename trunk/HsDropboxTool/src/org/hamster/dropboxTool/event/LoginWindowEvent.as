package org.hamster.dropboxTool.event
{
	import flash.events.Event;
	
	public class LoginWindowEvent extends Event
	{
		public function LoginWindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}