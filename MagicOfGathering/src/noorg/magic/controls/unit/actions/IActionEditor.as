package noorg.magic.controls.unit.actions
{
	import noorg.magic.models.actions.base.ICardAction;
	import noorg.magic.models.Card;
	import noorg.magic.models.PlayCard;
	
	public interface IActionEditor
	{
		function setActionClass(value:Class):void;
		function getActionClone():ICardAction;
		
	}
}