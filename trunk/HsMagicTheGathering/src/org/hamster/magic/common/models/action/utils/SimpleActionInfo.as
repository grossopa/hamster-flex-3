package org.hamster.magic.common.models.action.utils
{
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	
	public class SimpleActionInfo
	{
		private var _name:String;
		private var _type:String;
		private var _classType:Class;
		private var _editorType:Class;
		
		public function get name():String
		{
			return this._name;
		}
		
		public function get type():String
		{
			return this._type;
		}
		
		public function get classType():Class
		{
			return this._classType;
		}
		
		public function get editorType():Class
		{
			return this._editorType;
		}
		
		public function SimpleActionInfo(name:String, type:String, classType:Class, editorType:Class)
		{
			this._name = name;
			this._type = type;
			this._classType = classType;
			this._editorType = editorType;
		}
		
		public function createAction():ISimpleAction
		{
			return ISimpleAction(new classType());
		}

	}
}