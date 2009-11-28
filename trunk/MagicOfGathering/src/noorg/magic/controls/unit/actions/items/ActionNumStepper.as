package noorg.magic.controls.unit.actions.items
{
	import mx.controls.NumericStepper;
	
	import noorg.magic.models.ActionAttribute;

	public class ActionNumStepper extends NumericStepper implements IActionEditorItem
	{
		private var _actionAttribute:ActionAttribute;
		
		public function ActionNumStepper()
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
			return this.value;
		}
		
	}
}