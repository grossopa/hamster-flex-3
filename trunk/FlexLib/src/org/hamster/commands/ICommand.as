package org.hamster.commands
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public interface ICommand extends IEventDispatcher
	{
		function execute():void;
		function result(evt:Event = null):void;
		function fault(evt:Event = null):void;
	}
}