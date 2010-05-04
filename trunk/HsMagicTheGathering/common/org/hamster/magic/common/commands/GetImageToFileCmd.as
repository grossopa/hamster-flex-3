package org.hamster.magic.common.commands
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.magic.common.models.Card;

	public class GetImageToFileCmd extends AbstractCommand
	{
		public var card:Card;
		public var folder:File;
		
		public function GetImageToFileCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var urlReq:URLRequest = new URLRequest(this.card.imgUrl);
			var urlLoader:URLLoader = new URLLoader(urlReq);
			urlLoader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.load(urlReq);
		}
		
		private function loadCompleteHandler(evt:Event):void
		{
			var urlLoader:URLLoader = URLLoader(evt.currentTarget);
			var byteArray:ByteArray = ByteArray(urlLoader.data);
			var file:File = new File(folder.nativePath + File.separator + card.pid.toString() + ".jpg");
			var fs:FileStream = new FileStream();
			fs.openAsync(file, FileMode.WRITE);
			fs.writeBytes(byteArray, 0, byteArray.length);
			fs.addEventListener(Event.COMPLETE, imageCompleteHandler);
			
			var infoFile:File = new File(folder.nativePath + File.separator + card.pid.toString() + ".xml");
			var infoFs:FileStream = new FileStream();
			infoFs.openAsync(infoFile, FileMode.WRITE);
			infoFs.writeUTFBytes(card.toXMLString());
			infoFs.addEventListener(Event.COMPLETE, completeHandler);
		}
		
		private function imageCompleteHandler(evt:Event):void
		{
			var fs:FileStream = FileStream(evt.currentTarget);
			fs.close();
		}
		
		private function completeHandler(evt:Event):void
		{
			var fs:FileStream = FileStream(evt.currentTarget);
			fs.close();
			this.result(null);			
		}
		
	}
}