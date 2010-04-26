package org.hamster.magic.configure.controls.unit.simpleActions
{
	import mx.controls.NumericStepper;
	
	import org.hamster.magic.common.models.action.simpleAction.SimpleLifeChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	import org.hamster.magic.configure.controls.unit.simpleActions.base.BaseSimpleActionEditor;

	public class SimpleLifeChangeEditor extends BaseSimpleActionEditor
	{
		private var _numStepper:NumericStepper;
		
		protected function get simpleLifeChange():SimpleLifeChangeAction
		{
			return this.simpleAction == null 
					? null : SimpleLifeChangeAction(this.simpleAction);
		}
		
		public function SimpleLifeChangeEditor()
		{
			super();
			
			this._name = "生命变化";
			this.simpleAction = new SimpleLifeChangeAction();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_numStepper = new NumericStepper();
			this.addChild(_numStepper);
		}
		
		override protected function initProperties():void
		{
			_numStepper.value = this.simpleLifeChange.changeValue;
		} 
		
		override public function applyChanges():ISimpleAction
		{
			if (this.simpleAction == null) {
				this.simpleAction = new SimpleLifeChangeAction();
			}
			SimpleLifeChangeAction(this.simpleAction).changeValue = _numStepper.value;
			return this.simpleAction;
		}
		
	}
}