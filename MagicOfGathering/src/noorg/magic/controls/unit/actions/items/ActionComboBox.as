package noorg.magic.controls.unit.actions.items
{
	import mx.controls.ComboBox;
	
	import noorg.magic.models.ActionAttribute;

	public class ActionComboBox extends ComboBox implements IActionEditorItem
	{
		private var _actionAttribute:ActionAttribute;
		
		public function ActionComboBox()
		{
			super();
		}
		
		public function set actionAttribute(value:ActionAttribute):void
		{
			this._actionAttribute = value;
		}
		
		public function get actionAttribute():ActionAttribute
		{
			return this._actionAttribute;
		}
		
		public function get actionValue():Object
		{
			return this.selectedItem;
		}
		
	}
}