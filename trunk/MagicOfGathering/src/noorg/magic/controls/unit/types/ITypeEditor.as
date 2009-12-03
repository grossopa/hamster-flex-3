package noorg.magic.controls.unit.types
{
	import noorg.magic.models.Card;
	import noorg.magic.models.types.base.ICardType;
	
	public interface ITypeEditor
	{
		function initType():void;
		function getTypeClone():ICardType;
		function showTypeProperties():void;
		function validateTypeProperties():void;
	}
}