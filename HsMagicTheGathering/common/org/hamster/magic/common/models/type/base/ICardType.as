package org.hamster.magic.common.models.type.base
{
	import org.hamster.magic.common.models.Card;
	
	public interface ICardType
	{
		function set card(value:Card):void;
		function get card():Card;
		
		function set type(value:int):void;
		function get type():int;
		
		function decodeXML(xml:XML):void;
		function encodeXML():XML;
		
		function get defaultActions():Array;
		function get attributes():Array;
		
		function clone():ICardType;
	}
}