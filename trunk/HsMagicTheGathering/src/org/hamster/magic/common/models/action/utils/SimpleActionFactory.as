package org.hamster.magic.common.models.action.utils
{
	import org.hamster.magic.common.models.action.simpleAction.SimpleLifeChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.SimpleMagicChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	
	public class SimpleActionFactory
	{
		public static const PACKAGE:String = "org.hamster.magic.common.models.action.simpleAction";
		public static const supportActions:Array = [
			new SimpleActionInfo("SimpleLifeChangeAction", "SimpleLifeChangeAction", SimpleLifeChangeAction, null),
			new SimpleActionInfo("SimpleMagicChangeAction", "SimpleMagicChangeAction", SimpleMagicChangeAction, null)
		];
		
		public static function createAction(type:String):ISimpleAction
		{
			for each (var info:SimpleActionInfo in supportActions) {
				if (info.type == type) {
					return info.createAction();
				}
			}
			return null;
		}
	}
}