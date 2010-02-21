package org.hamster.magic.common.commands
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.magic.common.utils.FileUtil;

	public class SaveUserCardCollCmd extends AbstractCommand
	{
		public var folder:File;
		public var name:String;
		public var cards:ArrayCollection;
		
		public function SaveUserCardCollCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var xml:XML = new XML(<saved-collection name={name}></saved-collection>);
					
			for each (var card:Card in cards) {
				xml.appendChild(card.toUserXML());
			}
			
			var file:File = FileUtil.getUserSaveMetaFileByCollection(name);
			var fs:FileStream = new FileStream();
			fs.openAsync(file, FileMode.WRITE);
			fs.writeUTFBytes(xml.toXMLString());
			fs.close();
			this.result(null);
		//	fs.addEventListener(Event.COMPLETE, completeHandler);
		}
		
//		private function completeHandler(evt:Event):void
//		{
//			var fs:FileStream = FileStream(evt.currentTarget);
//			fs.close();
//			this.result(null);
//		}
		
	}
}