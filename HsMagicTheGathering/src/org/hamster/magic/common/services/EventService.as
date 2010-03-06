package org.hamster.magic.common.services
{
	import flash.events.EventDispatcher;
	
	import org.hamster.magic.common.controls.units.CardUnit;
	import org.hamster.magic.common.events.CardUnitEvent;
	import org.hamster.magic.common.models.Card;
	
	[Event(name="showDetail", type="org.hamster.magic.common.events.CardUnitEvent")]
	[Event(name="hideDetail", type="org.hamster.magic.common.events.CardUnitEvent")]
	[Event(name="selectCard", type="org.hamster.magic.common.events.CardUnitEvent")]
	[Event(name="unselectCard", type="org.hamster.magic.common.events.CardUnitEvent")]

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
		
		public var curSelectedCardUnit:CardUnit;
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, true);
		}
		
		public function showDetail(card:Card):void
		{
			if (curSelectedCardUnit != null) {
				return;
			}
			var disEvt:CardUnitEvent = new CardUnitEvent(CardUnitEvent.SHOW_DETAIL);
			disEvt.card = card;
			this.dispatchEvent(disEvt);			
		}
		
		public function hideDetail():void
		{
			if (curSelectedCardUnit != null) {
				return;
			}
			var disEvt:CardUnitEvent = new CardUnitEvent(CardUnitEvent.HIDE_DETAIL);
			this.dispatchEvent(disEvt);
		}
		
		public function selectCard(cardUnit:CardUnit):void
		{
			curSelectedCardUnit = cardUnit;
			
			var disEvt:CardUnitEvent = new CardUnitEvent(CardUnitEvent.SELECT_CARD);
			disEvt.card = curSelectedCardUnit.card;
			this.dispatchEvent(disEvt);				
		}
		
		public function unselectCard():void
		{
			curSelectedCardUnit = null;
			
			var disEvt:CardUnitEvent = new CardUnitEvent(CardUnitEvent.UNSELECT_CARD);
			this.dispatchEvent(disEvt);				
		}
		
		public function gotoNextStep():void
		{
			
		}
		

	}
}