package org.hamster.mapleCard.base.commands
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import org.hamster.commands.AbstractCommand;
	
	public class BaseFileLoaderCmd extends AbstractCommand
	{
		public var key:String;
		public var filePath:String;
		public var fileMode:String = FileMode.READ;
		public var byteArray:ByteArray;
		
		protected var fs:FileStream;
		
		public function BaseFileLoaderCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var file:File = new File(filePath);
			fs = new FileStream();
			fs.addEventListener(Event.COMPLETE, result);
			fs.addEventListener(IOErrorEvent.IO_ERROR, fault);
			fs.openAsync(file, FileMode.READ);
		}
		
		override public function result(data:Object):void
		{
			byteArray = new ByteArray();
			fs.readBytes(byteArray, 0, fs.bytesAvailable);
			super.result(data);
		}
		
		override public function fault(info:Object):void
		{
			super.fault(info);
		}
		
		protected function afterResult(data:Object):void{
			super.result(data);	
		}
	}
}