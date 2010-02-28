package org.hamster.magic.play.controls.units
{
	import mx.core.mx_internal;
	
	import org.hamster.magic.common.controls.units.CardUnit;
	import org.hamster.magic.common.events.PlayCardEvent;
	import org.hamster.magic.common.models.Card;
	import org.hamster.magic.common.models.PlayCard;
	import org.hamster.magic.common.utils.Constants;
	
	use namespace mx_internal;

	public class PlayCardUnit extends CardUnit
	{
		override public function set card(value:Card):void
		{
			if (super.card != null) {
				card.removeEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
			}
			
			super.card = value;
			PlayCard(card).addEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
		}
		
		public function PlayCardUnit()
		{
			super();
			this.width = Constants.PLAY_CARD_WIDTH;
			this.height = Constants.PLAY_CARD_HEIGHT;
		}
		
		private function statusChangedHandler(evt:PlayCardEvent):void
		{
			
		}
		
	}
}