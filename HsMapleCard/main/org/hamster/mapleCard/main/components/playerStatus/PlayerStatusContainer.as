package org.hamster.mapleCard.main.components.playerStatus
{
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.event.ActionStackItemDataEvent;
	import org.hamster.mapleCard.base.event.BattleFieldItemDataEvent;
	import org.hamster.mapleCard.base.model.player.Player;
	
	public class PlayerStatusContainer extends SimpleContainer
	{
		private var _player:Player;
		public function set player(value:Player):void
		{
			if (_player != null) {
				removePlayerListener(_player);
			}
			_player = value;
			addPlayerListener(_player);
		}
		
		public function PlayerStatusContainer()
		{
			super();
		}
		
		
		private function removePlayerListener(player:Player):void
		{
			player.removeEventListener(BattleFieldItemDataEvent.HP_CHANGED, hpChangedHandler);
			player.removeEventListener(BattleFieldItemDataEvent.INDEX_CHANGED, indexChangedHandler);
			player.removeEventListener(BattleFieldItemDataEvent.STATUS_CHANGED, statusChangedHandler);
			player.removeEventListener(ActionStackItemDataEvent.ACTIONPROGRESS_CHANGED, actionProgressChangedHandler);
		}
		
		private function addPlayerListener(player:Player):void
		{
			player.addEventListener(BattleFieldItemDataEvent.HP_CHANGED, hpChangedHandler);
			player.addEventListener(BattleFieldItemDataEvent.INDEX_CHANGED, indexChangedHandler);
			player.addEventListener(BattleFieldItemDataEvent.STATUS_CHANGED, statusChangedHandler);
			player.addEventListener(ActionStackItemDataEvent.ACTIONPROGRESS_CHANGED, actionProgressChangedHandler);
		}
	}
}