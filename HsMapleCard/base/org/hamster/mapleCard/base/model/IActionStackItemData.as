package org.hamster.mapleCard.base.model
{
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	
	[Event(name="actionprogressChanged", type="org.hamster.mapleCard.base.event.ActionStackItemDataEvent")]

	public interface IActionStackItemData extends IEventDispatcher
	{
		function set actionProgress(value:Number):void;
		function get actionProgress():Number;
		
		function get actionStackIcon():BitmapData;
	}
}