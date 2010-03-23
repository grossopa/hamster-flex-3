package org.hamster.magic.common.models.action.utils
{
	import org.hamster.magic.common.models.action.simpleAction.SimpleLifeChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.SimpleMagicChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	
	public class SimpleActionFactory
	{
		public static const PACKAGE = "org.hamster.magic.common.models.action.simpleAction";
		public static const supportActions:Array = [
			SimpleLifeChangeAction, SimpleMagicChangeAction
		];
		
		public static function createAction(className:String):ISimpleAction
		{
			return (ISimpleAction) _global[PACKAGE + "." + className]();
		}
	}
}