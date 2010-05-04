package org.hamster.magic.configure.controls.unit.base
{
	import org.hamster.magic.common.models.type.base.ICardType;
	
	public interface ITypeEditor
	{
		function set cardType(value:ICardType):void;
		function get cardType():ICardType;
		function initType():void;
		function getTypeClone():ICardType;
		function showTypeProperties():void;
		function validateTypeProperties():void;
	}
}