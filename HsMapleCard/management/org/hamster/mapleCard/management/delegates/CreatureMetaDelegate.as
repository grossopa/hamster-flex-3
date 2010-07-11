package org.hamster.mapleCard.management.delegates
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.rpc.IResponder;
	
	import org.hamster.mapleCard.base.model.card.CreatureCard;
	import org.hamster.mapleCard.base.utils.FileUtil;

	public class CreatureMetaDelegate
	{
		private var responder:IResponder;
		private var fs:FileStream;
		
		public function CreatureMetaDelegate(responder:IResponder)
		{
			fs = new FileStream();
			fs.addEventListener(Event.COMPLETE, onResultHandler);
			fs.addEventListener(IOErrorEvent.IO_ERROR, onFaultHandler);
			this.responder = responder;
		}
		
		private function onResultHandler(evt:Event):void
		{
			var fs:FileStream = FileStream(evt.currentTarget);
			var str:String = fs.readUTFBytes(fs.bytesAvailable);
			this.responder.result(str);
		}
		
		private function onFaultHandler(evt:Event):void
		{
			this.responder.fault(evt);
		}
		
		public function getCreatureMeta(id:String):void 
		{
			var file:File = new File(FileUtil.creatureMetaDir.nativePath 
				+ File.separator + id.toString() + ".xml");
			fs.openAsync(file, FileMode.READ);
		}
		
		public function saveCreatureMeta(meta:CreatureCard):void 
		{
			var file:File = new File(FileUtil.creatureMetaDir.nativePath 
				+ File.separator + meta.id.toString() + ".xml");
			fs.open(file, FileMode.WRITE);
			fs.writeMultiByte(meta.encode().toString(), "utf-8");
			fs.close();
			this.responder.result(meta);
		}
	}
}