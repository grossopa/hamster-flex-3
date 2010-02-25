package org.hamster.magic.common.models.action.simpleAction
{
	import org.hamster.magic.common.models.Magic;
	import org.hamster.magic.common.models.action.simpleAction.base.BaseSimpleAction;

	public class SimpleMagicChangeAction extends BaseSimpleAction
	{
		public var target:Magic;
		
		public var changeValue:Magic;
		
		public function SimpleMagicChangeAction()
		{
			super();
		}
		
		override public function execute():void
		{
			target.red += changeValue.red;
			target.black += changeValue.black;
			target.blue += changeValue.blue;
			target.white += changeValue.white;
			target.green += changeValue.green;
			target.colorless += changeValue.colorless;
		}
		
		
		
	}
}