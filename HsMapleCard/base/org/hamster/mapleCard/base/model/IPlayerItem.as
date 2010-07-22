package org.hamster.mapleCard.base.model
{
	import org.hamster.mapleCard.base.model.player.Player;

	public interface IPlayerItem extends IBaseModel
	{
		function set parentPlayer(value:Player):void;
		function get parentPlayer():Player;
	}
}