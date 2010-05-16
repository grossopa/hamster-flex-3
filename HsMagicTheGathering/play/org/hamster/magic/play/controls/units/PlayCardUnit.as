package org.hamster.magic.play.controls.units
{
	import mx.controls.Alert;
	import mx.effects.Rotate;
	import mx.events.EffectEvent;
	
	import org.hamster.magic.common.controls.units.CardUnit;
	import org.hamster.magic.common.events.PlayCardEvent;
	import org.hamster.magic.common.models.Card;
	import org.hamster.magic.common.models.PlayCard;
	import org.hamster.magic.common.models.utils.CardStatus;
	import org.hamster.magic.common.utils.Constants;
	
	[Event(name="statusChanged", type="org.hamster.magic.common.events.PlayCardEvent")]

	public class PlayCardUnit extends CardUnit
	{
		public function get playCard():PlayCard
		{
			return PlayCard(card);
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			if (card != null) {
				playCard.enabled = value;
			}
		}
		
		override public function set card(value:Card):void
		{
			if (super.card != null) {
				playCard.removeEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
				playCard.removeEventListener(PlayCardEvent.ENABLE_CHANGED, enableChangedHandler);
			}
			
			super.card = value;
			if (card != null) {
				playCard.addEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
				playCard.addEventListener(PlayCardEvent.ENABLE_CHANGED, enableChangedHandler);
			}
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
		
		private function enableChangedHandler(evt:PlayCardEvent):void
		{
			if (this.playCard.enabled) {
				this.alpha = 1;
			} else {
				this.alpha = 0.5;
			}
			this.dispatchEvent(evt);
		}
	}
}