package org.hamster.magic.common.models.action.utils
{
	import org.hamster.magic.common.models.action.simpleAction.SimpleLifeChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.SimpleMagicChangeAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	import org.hamster.magic.configure.controls.unit.simpleActions.SimpleLifeChangeEditor;
	import org.hamster.magic.configure.controls.unit.simpleActions.SimpleMagicChangeEditor;
	import org.hamster.magic.configure.controls.unit.simpleActions.base.BaseSimpleActionEditor;
	
	public class SimpleActionFactory
	{
		public static const PACKAGE:String = "org.hamster.magic.common.models.action.simpleAction";
		public static const supportActions:Array = [
			new SimpleActionInfo("SimpleLifeChangeAction", "SimpleLifeChangeAction", 
			SimpleLifeChangeAction, SimpleLifeChangeEditor),
			new SimpleActionInfo("SimpleMagicChangeAction", "SimpleMagicChangeAction", 
			SimpleMagicChangeAction, SimpleMagicChangeEditor)
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
		
		public static function createEditor(type:String):BaseSimpleActionEditor
		{
			for each (var info:SimpleActionInfo in supportActions) {
				if (info.type == type) {
					return new info.editorType();
				}
			}
			return null;
		}
	}
}