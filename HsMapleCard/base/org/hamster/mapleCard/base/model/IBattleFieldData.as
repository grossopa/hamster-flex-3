package org.hamster.mapleCard.base.model
{
	import flash.events.IEventDispatcher;

	[Event(name="hpChanged", type="org.hamster.mapleCard.base.event.BattleFieldDataEvent")]
	[Event(name="statusChanged", type="org.hamster.mapleCard.base.event.BattleFieldDataEvent")]
	[Event(name="actionprogressChanged", type="org.hamster.mapleCard.base.event.BattleFieldDataEvent")]
	[Event(name="indexChanged", type="org.hamster.mapleCard.base.event.BattleFieldDataEvent")]
	
	public interface IBattleFieldData extends IEventDispatcher
	{
		function set hp(value:Number):void;
		function get hp():Number;
		function set status(value:String):void;
		function get status():String;
		function set actionProgress(value:Number):void;
		function get actionProgress():Number;
		function set xIndex(value:int):void;
		function get xIndex():int;
		function set yIndex(value:int):void;
		function get yIndex():int;
		
		function setIndex(xIdx:int, yIdx:int):void;
		
		function get maxHp():Number;
	}
}