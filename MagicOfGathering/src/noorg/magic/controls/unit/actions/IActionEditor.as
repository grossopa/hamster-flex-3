package noorg.magic.controls.unit.actions
{
	import noorg.magic.actions.base.ICardAction;
	import noorg.magic.models.PlayCard;
	
	public interface IActionEditor
	{
		function set playCard(value:PlayCard):void;
		function get playCard():PlayCard;
		
		function setActionClass(value:Class):void;
		function get action():ICardAction;
		
	}
}