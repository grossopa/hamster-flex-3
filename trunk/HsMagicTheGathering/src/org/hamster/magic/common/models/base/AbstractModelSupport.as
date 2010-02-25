package org.hamster.magic.common.models.base
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class AbstractModelSupport extends EventDispatcher
	{
		public var preventFromChangeEvent:Boolean;
		
		public function AbstractModelSupport()
		{
		}
		
		override public function dispatchEvent(event:Event):Boolean
		{
			if (!preventFromChangeEvent) {
				return super.dispatchEvent(event);
			} else {
				return false;
			}
		}
		
	}
}