package org.hamster.magic.play.controls.units
{
	import org.hamster.magic.common.events.PlayerEvent;
	import org.hamster.magic.common.models.Player;
	import org.hamster.magic.common.utils.Constants;
	import org.hamster.magic.play.controls.items.MagicCircleItem;

	public class LifeUnit extends MagicCircleItem
	{
		private var _player:Player;
		
		public function set player(value:Player):void
		{
			if (this.player != null) {
				this.player.removeEventListener(PlayerEvent.LIFE_CHANGE, lifeChangeHandler);
			}
			this._player = player;
			this._player.addEventListener(PlayerEvent.LIFE_CHANGE, lifeChangeHandler);
		}
		
		public function get player():Player
		{
			return this._player;
		}
		
		public function LifeUnit()
		{
			super();
			
			this.color = 0xAA7900;
		}
		
		private function lifeChangeHandler(evt:PlayerEvent):void
		{
			this.magicValue = player.life;
		}
		
	}
}