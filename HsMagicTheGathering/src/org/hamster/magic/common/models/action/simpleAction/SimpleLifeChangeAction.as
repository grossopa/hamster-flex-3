package org.hamster.magic.common.models.action.simpleAction
{
	import org.hamster.magic.common.models.Player;
	import org.hamster.magic.common.models.action.simpleAction.base.BaseSimpleAction;

	public class SimpleLifeChangeAction extends BaseSimpleAction
	{
		public var target:Object;
		public var changeValue:int;
		
		public function SimpleLifeChangeAction()
		{
			super();
		}
		
		override public function execute():void
		{
			if (target is Player) {
				Player(target).life += changeValue;
			}
		}
		
		
	}
}