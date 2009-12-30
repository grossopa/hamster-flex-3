package noorg.magic.events
{
	import flash.events.Event;

	public class GameFlowEvent extends Event
	{
		public static const START_GAME:String = "GameFlowEvent_startGame";
		
		public function GameFlowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}