package noorg.magic.events
{
	import flash.events.Event;

	public class GameFlowEvent extends Event
	{
		public static const START_GAME:String = "GameFlowEvent_startGame";
		public static const QUIT_GAME:String = "GameFlowEvent_quitGame";
		
		public function GameFlowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}