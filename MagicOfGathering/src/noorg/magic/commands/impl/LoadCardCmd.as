package noorg.magic.commands.impl
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import noorg.magic.models.Card;
	
	import org.hamster.commands.AbstractCommand;

	public class LoadCardCmd extends AbstractCommand
	{
		public var collection:String;
		public var card:Card;
		
		public var file:File;
		
		public function LoadCardCmd()
		{
			super();
		}
		
		override public function execute():void
		{
//			var folder:File = Configures.getCardFolderByCollection(collectionName);
//			var files:Array = folder.getDirectoryListing();
//			cards = new Array();
//			for each (var file:File in files) {
//				if (!file.isDirectory && file.name.indexOf(".xml") != -1) {
			var fs:FileStream = new FileStream();
			fs.addEventListener(Event.COMPLETE, fileCompleteHandler);
			fs.openAsync(file, FileMode.READ);
	//			}
//			}
		}
		
		private function fileCompleteHandler(evt:Event):void
		{
			var fs:FileStream = FileStream(evt.currentTarget);
			card = new Card();
			card.decodeXML(new XML(fs.readUTFBytes(fs.bytesAvailable)));
			card.imgPath = file.nativePath.replace(/.xml$/, ".jpg");
			card.collection = this.collection;
			fs.close();
			
			this.result(null);
		}
		
	}
}