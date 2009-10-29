package noorg.magic.events
{
	import flash.events.Event;
	
	import noorg.magic.models.Card;

	public class CardEvent extends Event
	{
		public static const SELECT_CHANGED:String = "cardSelectChanged";
		public static const ADD:String = "addCard";
		
		public var card:Card;
		
		public function CardEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:CardEvent = new CardEvent(type, bubbles, cancelable);
			result.card = card;
			return result;
		}
		
	}
}