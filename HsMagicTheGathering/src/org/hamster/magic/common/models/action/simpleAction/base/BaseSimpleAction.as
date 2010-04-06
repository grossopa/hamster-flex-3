package org.hamster.magic.common.models.action.simpleAction.base
{
	// instance = new _global[myString]();
	public class BaseSimpleAction implements ISimpleAction
	{
		private var _target:Object;
		protected var _type:String;
		
		public function get type():String
		{
			return this._type;
		}
		
		public function set target(value:Object):void
		{
			this._target = value;
		}
		
		public function get target():Object
		{
			return this._target;
		}
		
		public function BaseSimpleAction()
		{
		}
		
		public function execute():void
		{
			
		}
		
		public function clone():ISimpleAction
		{
			return null;
		}
		
		public function decodeXML(xml:XML):void
		{
			
		}
		
		public function toXML():XML
		{
			return new XML(<simple-action></simple-action>);;
		}

	}
}