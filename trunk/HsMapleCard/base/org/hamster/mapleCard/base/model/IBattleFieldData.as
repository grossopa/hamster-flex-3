package org.hamster.mapleCard.base.model
{
	public interface IBattleFieldData
	{
		function set hp(value:Number):void;
		function get hp():Number;
		function set status(value:String):void;
		function get status():String;
		function set actionProgress(value:Number):void;
		function get actionProgress():Number;
	}
}