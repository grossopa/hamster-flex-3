package noorg.magic.events
{
	import flash.events.Event;

	public class PlayerEvent extends Event
	{
		public static const HP_CHANGED:String = "PlayerEventHpChanged";
		
		public function PlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}