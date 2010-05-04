package org.hamster.magic.common.events
{
	import flash.events.Event;
	
	import org.hamster.magic.common.models.Player;

	public class GameStepEvent extends Event
	{
		public function GameStepEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var player:Player;
		public var step:int;
		
		override public function clone():Event
		{
			var result:GameStepEvent = new GameStepEvent(type, bubbles, cancelable);
			result.player = this.player;
			result.step = this.step;
			return result;
		}
		
	}
}