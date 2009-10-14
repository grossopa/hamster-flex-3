package noorg.magic.services
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import noorg.magic.events.CardEvent;
	import noorg.magic.models.Card;

	public class EventService extends EventDispatcher
	{
		public function EventService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private static var _instance:EventService;
		
		public static function getInstance():EventService
		{
			if (_instance == null) {
				_instance = new EventService(null);
			}
			return _instance;
		}
		
		public function cardChanged(card:Card):void
		{
			var cardEvent:CardEvent = new CardEvent(CardEvent.SELECT_CHANGED);
			cardEvent.card = card;
			_instance.dispatchEvent(cardEvent);
		}
		
		public function addCard(card:Card):void
		{
			var cardEvent:CardEvent = new CardEvent(CardEvent.ADD);
			cardEvent.card = card;
			_instance.dispatchEvent(cardEvent);
		}
		
	}
}