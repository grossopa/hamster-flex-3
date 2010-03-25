package org.hamster.magic.common.models.action.simpleAction.base
{
	public interface ISimpleAction
	{
		function set target(value:Object):void;
		function get target():Object;
		function execute():void;
		function clone():ISimpleAction;
		function toXML():XML;
		function decodeXML(xml:XML):void;
	}
}