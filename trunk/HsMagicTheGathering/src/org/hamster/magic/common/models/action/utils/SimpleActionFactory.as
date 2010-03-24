package org.hamster.magic.common.models.action.utils
{
	import org.hamster.magic.common.models.action.simpleAction.SimpleLifeChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.SimpleMagicChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	
	public class SimpleActionFactory
	{
		public static const PACKAGE:String = "org.hamster.magic.common.models.action.simpleAction";
		public static const supportActions:Array = [
			{name : "SimpleLifeChangeAction",  type : SimpleLifeChangeAction}, 
			{name : "SimpleMagicChangeAction", type : SimpleMagicChangeAction}
		];
		
		public static function createAction(className:String):ISimpleAction
		{
			for each (var obj:Object in supportActions) {
				if (obj.name == className) {
					var cls:Class = Class(obj.type);
					return ISimpleAction(new cls());
				}
			}
			return null;
		}
	}
}