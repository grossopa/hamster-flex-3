package org.hamster.toolkit.model
{
	import mx.collections.XMLListCollection;

	public class ToolVO
	{
		private var _name:String;
		public function set name(value:String):void { _name = value; }
		public function get name():String { return _name; }
		
		private var _moduleName:String;
		public function set moduleName(value:String):void { _moduleName = value; }
		public function get moduleName():String { return _moduleName; }
		
		private var _type:String;
		public function set type(value:String):void { _type = value; }
		public function get type():String { return _type; }
		
		public function ToolVO()
		{
		}
	}
}