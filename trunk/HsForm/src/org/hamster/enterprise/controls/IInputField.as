package org.hamster.enterprise.controls
{
	public interface IInputField
	{
		function set mainData(value:Object):void;
		function get mainData():Object;
		
		function get stringValue():String;
		
		function set required(value:Boolean):void;
		function get required():Boolean;
		function set emptyText(value:String):void;
		function get emptyText():String;
	}
}