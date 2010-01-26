package org.hamster.gamesaver.commands
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.gamesaver.utils.FileUtil;
	

	public class SaveUserDataCmd extends AbstractCommand
	{
		public var xml:XML;
		
		private var _fs:FileStream;
		
		public function SaveUserDataCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var file:File = FileUtil.getConfFile();
			_fs = new FileStream();
			//_fs.addEventListener(Event.COMPLETE, openCompleteHandler);
			_fs.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_fs.addEventListener(Event.CLOSE, closeCompleteHandler);
			_fs.openAsync(file, FileMode.WRITE);
			_fs.writeUTFBytes(this.xml.toXMLString());
			_fs.close();
			
		}
		
		private function closeCompleteHandler(evt:Event):void
		{
			this.result(null);
		}
		
		private function ioErrorHandler(evt:IOErrorEvent):void
		{
			this.fault(null);
		}
		
		
		
	}
}