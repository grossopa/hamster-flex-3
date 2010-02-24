package org.hamster.magic.common.events
{
	import flash.events.Event;
	
	import org.hamster.magic.common.models.Card;

	public class CardUnitEvent extends Event
	{
		public static const HIDE_DETAIL:String = "PlayCardEventHideDetail";
		public static const SHOW_DETAIL:String = "PlayCardEventShowDetail";
		
		public var card:Card;
		
		public function CardUnitEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:CardUnitEvent = new CardUnitEvent(type, bubbles, cancelable);
			result.card = this.card;
			return result;
		}
		
	}
}