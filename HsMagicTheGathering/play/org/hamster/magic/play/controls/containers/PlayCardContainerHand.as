package org.hamster.magic.play.controls.containers
{
	import org.hamster.magic.common.events.MagicEvent;
	import org.hamster.magic.common.models.Magic;
	import org.hamster.magic.common.models.Player;
	import org.hamster.magic.play.controls.units.PlayCardUnit;

	public class PlayCardContainerHand extends PlayCardContainer
	{
		protected function get magic():Magic
		{
			if (this.player != null) {
				return this.player.magic;
			} else {
				return null;
			}
		}
		
		override public function set player(value:Player):void
		{
			if (this.player != null) {
				this.removeMagicListener(this.player);
			}
			super.player = value;
			if (this.player != null) {
				this.registMagicListener(this.player);
			}
		}
		
		public function PlayCardContainerHand()
		{
			super();
		}
		
		protected function registMagicListener(value:Player):void
		{
			value.magic.addEventListener(MagicEvent.CHANGE, playerMagicChangeHandler);
			value.magic.addEventListener(MagicEvent.MULTI_CHANGE, playerMagicChangeHandler);
		}
		
		protected function removeMagicListener(value:Player):void
		{
			value.magic.removeEventListener(MagicEvent.CHANGE, playerMagicChangeHandler);
			value.magic.removeEventListener(MagicEvent.MULTI_CHANGE, playerMagicChangeHandler);
		}
		
		override protected function arrangePlayCards():void
		{
			var nextX:Number = 0;
			for each (var playCardUnit:PlayCardUnit in this.mainContainer.getChildren()) {
				if (this.player.magic.gt(playCardUnit.playCard.magic)) {
					playCardUnit.enabled = true;
				} else {
					playCardUnit.enabled = false;
				}
				playCardUnit.move(nextX, playCardUnit.y);
				nextX += HORIZONTAL_GAP + playCardUnit.width;
			}			
		}
		
		private function playerMagicChangeHandler(evt:MagicEvent):void
		{
			this.arrangePlayCards();
		}
		
		
	}
}