package org.hamster.upload.models
{
	import flash.events.IEventDispatcher;
	import flash.net.FileReference;
	
	[Event(name="fileStart", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileProgress", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileUploaded", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileFinished", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileDelete", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileError", type="org.hamster.upload.events.HsUploadEvent")]
	
	public interface IUploadFile extends IEventDispatcher
	{
		function set uploadUrl(value:String):void;
		function get uploadUrl():String;
		function set file(value:FileReference):void;
		function get file():FileReference;
		function set status(value:int):void;
		function get status():int;
		function set isDeleted(value:Boolean):void;
		function get isDeleted():Boolean;
		function upload(url:String):void;
		function deleteFile():void;
	}
}