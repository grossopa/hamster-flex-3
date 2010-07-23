package org.hamster.mapleCard.base.model.base
{
	import flash.events.EventDispatcher;
	
	import org.hamster.mapleCard.base.model.IBaseModel;
	
	[Bindable]
	public class BaseModel extends EventDispatcher implements IBaseModel
	{
		private var _id:String;
		
		public function BaseModel()
		{
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function get id():String
		{
			return _id;
		}
	}
}