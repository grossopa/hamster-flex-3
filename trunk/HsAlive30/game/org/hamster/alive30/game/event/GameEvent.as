package org.hamster.alive30.game.event
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const PLANE_HIT:String = "PlaneHit";
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:GameEvent = new GameEvent(type, bubbles, cancelable);
			return result;
		}
	}
}