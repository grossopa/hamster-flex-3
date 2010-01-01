package noorg.magic.events
{
	import flash.events.Event;

	public class PlayMenuEvent extends Event
	{
		public static const SWITCH_PLAYER1:String = "PlayMenuEventSwitchPlayer1";
		public static const SWITCH_PLAYER2:String = "PlayMenuEventSwitchPlayer2";
		public static const LEAVE:String = "PlayMenuEventLeave";
		
		public function PlayMenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}