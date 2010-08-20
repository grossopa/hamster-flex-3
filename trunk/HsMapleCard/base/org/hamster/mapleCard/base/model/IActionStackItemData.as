package org.hamster.mapleCard.base.model
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	
	[Event(name="actionprogressChanged", type="org.hamster.mapleCard.base.event.ActionStackItemDataEvent")]

	public interface IActionStackItemData extends IEventDispatcher, IPlayerItem, IBaseModel
	{
		function set actionProgress(value:Number):void;
		function get actionProgress():Number;
		function set itemIcon(value:Bitmap):void;
		function get itemIcon():Bitmap;
	}
}