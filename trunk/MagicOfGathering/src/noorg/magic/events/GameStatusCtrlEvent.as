package noorg.magic.events
{
	import flash.events.Event;

	/**
	 * for game status control
	 */
	public class GameStatusCtrlEvent extends Event
	{
		public static const START_TURN:String = "GameStatusCtrlEventStartTurn";
		public static const DRAW_CARD:String = "GameStatusCtrlEventDrawCard";
		public static const PLAY_CARD:String = "GameStatusCtrlEventPlayCard";
		public static const END_TURN:String = "GameStatusCtrlEventEndTurn";
		
		public function GameStatusCtrlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}