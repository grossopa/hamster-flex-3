package org.hamster.magic.common.events
{
	import flash.events.Event;

	public class PlayerEvent extends Event
	{
		public static const LIFE_CHANGE:String = "PlayerEventLifeChanged";
		public static const MAGIC_CHANGE:String = "PlayerEventMagicChanged";
		
		public var magicType:uint;
		public var magicCount:uint;
		
		public function PlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}