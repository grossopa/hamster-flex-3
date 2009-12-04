package noorg.magic.controls.unit.types
{
	import noorg.magic.models.types.base.ICardType;
	
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