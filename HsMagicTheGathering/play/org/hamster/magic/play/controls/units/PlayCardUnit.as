package org.hamster.magic.play.controls.units
{
	import mx.controls.Alert;
	import mx.effects.Rotate;
	import mx.events.EffectEvent;
	
	import org.hamster.magic.common.controls.units.CardUnit;
	import org.hamster.magic.common.events.PlayCardEvent;
	import org.hamster.magic.common.models.Card;
	import org.hamster.magic.common.models.PlayCard;
	import org.hamster.magic.common.utils.Constants;
	
	[Event(name="statusChanged", type="org.hamster.magic.common.events.PlayCardEvent")]

	public class PlayCardUnit extends CardUnit
	{
		override public function set card(value:Card):void
		{
			if (super.card != null) {
				card.removeEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
			}
			
			super.card = value;
			if (card != null) {
				card.addEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
			}
		}
		
		public function get playCard():PlayCard
		{
			return this.card as PlayCard;
		}
		
		public function PlayCardUnit()
		{
			super();
			this.width = Constants.PLAY_CARD_WIDTH;
			this.height = Constants.PLAY_CARD_HEIGHT;
		}
		
		private function statusChangedHandler(evt:PlayCardEvent):void
		{
			this.dispatchEvent(evt);
		}
		
	}
}