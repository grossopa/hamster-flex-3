package org.hamster.magic.common.services
{
	import flash.events.EventDispatcher;
	
	import org.hamster.magic.common.events.CardUnitEvent;
	import org.hamster.magic.common.models.Card;
	
	[Event(name="showDetail", type="org.hamster.magic.common.events.CardUnitEvent")]
	[Event(name="hideDetail", type="org.hamster.magic.common.events.CardUnitEvent")]
	
	public class EventService extends EventDispatcher
	{
		private static var _instance:EventService;
		
		public static function getInstance():EventService
		{
			if (_instance == null) {
				_instance = new EventService();
			}
			return _instance;
		}
		
		public function showDetail(card:Card):void
		{
			var disEvt:CardUnitEvent = new CardUnitEvent(CardUnitEvent.SHOW_DETAIL);
			disEvt.card = card;
			this.dispatchEvent(disEvt);			
		}
		
		public function hideDetail():void
		{
			var disEvt:CardUnitEvent = new CardUnitEvent(CardUnitEvent.HIDE_DETAIL);
			this.dispatchEvent(disEvt);
		}

	}
}