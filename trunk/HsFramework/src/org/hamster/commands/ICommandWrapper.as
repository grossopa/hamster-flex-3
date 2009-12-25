package org.hamster.commands
{
	public interface ICommandWrapper
	{
		function get cmdArray():Array;
		function set cmdArray(value:Array):void;
		function get curIndex():int;
		function get curCmd():ICommand;
	}
}