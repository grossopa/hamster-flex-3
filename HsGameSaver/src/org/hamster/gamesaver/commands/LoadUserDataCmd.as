package org.hamster.gamesaver.commands
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.gamesaver.utils.FileUtil;

	public class LoadUserDataCmd extends AbstractCommand
	{
		public var xml:XML;
		private var _fs:FileStream;
		
		public function LoadUserDataCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var file:File = FileUtil.getConfFile();
			_fs = new FileStream();
			_fs.addEventListener(Event.COMPLETE, openCompleteHandler);
			_fs.addEventListener(IOErrorEvent.IO_ERROR, this.fault);
			_fs.openAsync(file, FileMode.READ);
		}
		
		private function openCompleteHandler(evt:Event):void
		{
			xml = new XML(_fs.readUTFBytes(_fs.bytesAvailable));
			_fs.close();
			this.result(null);
		}
		
	}
}