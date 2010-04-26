package org.hamster.magic.configure.controls.unit.simpleActions
{
	import org.hamster.magic.common.controls.units.MagicUnit;
	import org.hamster.magic.common.models.action.simpleAction.SimpleMagicChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	import org.hamster.magic.configure.controls.unit.simpleActions.base.BaseSimpleActionEditor;

	public class SimpleMagicChangeEditor extends BaseSimpleActionEditor
	{
		private var _magicUnit:MagicUnit;
		
		protected function get simpleMagicChange():SimpleMagicChangeAction
		{
			return this.simpleAction == null 
					? null : SimpleMagicChangeAction(this.simpleAction);
			
		}
		
		public function SimpleMagicChangeEditor()
		{
			super();
			
			this._name = "魔法变化";
			this.simpleAction = new SimpleMagicChangeAction();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_magicUnit = new MagicUnit();
			_magicUnit.editable = true;
			_magicUnit.height = 24;
			this.addChild(_magicUnit);
		}

		override protected function initProperties():void
		{
			_magicUnit.magic = this.simpleMagicChange.changeValue.clone();
		}
		
		override public function applyChanges():ISimpleAction
		{
			_magicUnit.applyChanges();
			SimpleMagicChangeAction(this.simpleAction).changeValue
					.decodeString(this._magicUnit.magic.encodeString());
			return this.simpleAction;
		}
		
		
		
	}
}