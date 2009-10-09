package org.hamster.commands
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.IResponder;
	
	public interface ICommand extends IEventDispatcher, IResponder
	{
		function execute():void;
		function set cmdWrapper(value:ICommandWrapper):void;
		function get cmdWrapper():ICommandWrapper;
	}
}