package org.hamster.magic.common.models.action.simpleAction
{
	import org.hamster.magic.common.models.PlayCard;
	import org.hamster.magic.common.models.Player;
	import org.hamster.magic.common.models.action.simpleAction.base.BaseSimpleAction;
	import org.hamster.magic.common.models.base.ILifeTarget;

	public class SimpleLifeChangeAction extends BaseSimpleAction
	{
		public var target:ILifeTarget;
		public var changeValue:int;
		
		public function SimpleLifeChangeAction()
		{
			super();
		}
		
		override public function execute():void
		{
			target.life += changeValue;
		}
		
		
	}
}