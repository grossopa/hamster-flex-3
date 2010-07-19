package org.hamster.mapleCard.base.model
{
	import flash.events.IEventDispatcher;

	[Event(name="hpChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	[Event(name="statusChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	[Event(name="indexChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	
	public interface IBattleFieldItemData extends IActionStackItemData
	{
		function set hp(value:Number):void;
		function get hp():Number;
		function set status(value:String):void;
		function get status():String;
		function set xIndex(value:int):void;
		function get xIndex():int;
		function set yIndex(value:int):void;
		function get yIndex():int;
		
		function setIndex(xIdx:int, yIdx:int):void;
		
		function get maxHp():Number;
	}
}