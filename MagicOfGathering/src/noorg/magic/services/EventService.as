package noorg.magic.services
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import noorg.magic.events.CardEvent;
	import noorg.magic.events.PlayCardEvent;
	import noorg.magic.models.Card;
	import noorg.magic.models.PlayCard;

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
		
		public function removeSelectedCard(card:Card):void
		{
			var cardEvent:CardEvent = new CardEvent(CardEvent.REMOVE);
			cardEvent.card = card;
			_instance.dispatchEvent(cardEvent);
		}
		
		
		/**
		 * For play
		 */
		public function dragPlayCard(playCard:PlayCard):void
		{
			var playCardEvent:PlayCardEvent = new PlayCardEvent(PlayCardEvent.DRAW_CARD);
			playCardEvent.card = playCard;
			_instance.dispatchEvent(playCardEvent);
		}
		
	}
}