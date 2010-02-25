package org.hamster.magic.common.models.action.simpleAction.base
{
	public interface ISimpleAction
	{
		function execute():void;
		function clone():ISimpleAction;
		function toXML():XML;
		function decodeXML(xml:XML):void;
	}
}