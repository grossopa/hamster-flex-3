package noorg.magic.events
{
	import flash.events.Event;
	
	import noorg.magic.models.Card;

	public class CardEvent extends Event
	{
		public static const SELECT_CHANGED:String = "cardSelectChanged";
		
		public var card:Card;
		
		public function CardEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}