package org.hamster.upload.models
{
	import flash.events.IEventDispatcher;
	import flash.net.FileReference;

	public interface IUploadFile extends IEventDispatcher
	{
		function set file(value:FileReference):void;
		function get file():FileReference;
		function set status(value:int):void;
		function get status():int;
		function set isDeleted(value:Boolean):void;
		function get isDeleted():Boolean;
		function deleteFile():void;
	}
}