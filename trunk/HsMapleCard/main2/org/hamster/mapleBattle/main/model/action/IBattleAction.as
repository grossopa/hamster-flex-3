package org.hamster.mapleBattle.main.model.action
{
	import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;

	public interface IBattleAction
	{
		function set actionStackCost(value:int):void;
		function get actionStackCost():int;
		function execute(item:BattleFieldItem):void;
	}
}