package org.hamster.magic.common.commands
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.magic.common.utils.FileUtil;
	
	public class LoadCardXMLCmd extends AbstractCommand
	{
		public var collection:String;
		public var pid:int;
		
		public var xml:XML;
		
		private var _file:File;
		
		public function LoadCardXMLCmd()
		{
			super();

		}
		
		override public function execute():void
		{
            _file = FileUtil.getCardInfoByPid(collection, pid);
            var fs:FileStream = new FileStream();
            fs.addEventListener(Event.COMPLETE, loadCompleteHandler);
            //fs.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            //TODO: strange....
            fs.open(_file, FileMode.READ);
            this.xml = new XML(fs.readUTFBytes(fs.bytesAvailable));
            fs.close();
			this.result(null);
		}
		
		private function loadCompleteHandler(evt:Event):void
		{
			var fs:FileStream = FileStream(evt.currentTarget);
			//fs.removeEventListener(Event.COMPLETE, loadCompleteHandler);
            //fs.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            this.xml = new XML(fs.readUTFBytes(fs.bytesAvailable));
            fs.close();
			
			this.result(null);
		}
		
		private function ioErrorHandler(evt:Event):void
        {
            var fs:FileStream = FileStream(evt.currentTarget);
            fs.removeEventListener(Event.COMPLETE, loadCompleteHandler);
            fs.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            fs.close();
            this.fault(null);
        }

	}
}