package noorg.magic.controls.unit.actions.items
{
	import noorg.magic.models.actions.base.ICardAction;
	import noorg.magic.models.ActionAttribute;
	
	public interface IActionEditorItem
	{
		function set actionAttribute(value:ActionAttribute):void;
		function get actionAttribute():ActionAttribute;
		function get actionValue():Object;
		
		function set action(value:ICardAction):void;
		function get action():ICardAction;
	}
}