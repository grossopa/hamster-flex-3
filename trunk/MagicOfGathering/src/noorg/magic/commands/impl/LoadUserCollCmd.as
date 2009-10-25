package noorg.magic.commands.impl
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	
	import noorg.magic.models.Card;
	import noorg.magic.utils.Configures;
	
	import org.hamster.commands.AbstractCommand;

	public class LoadUserCollCmd extends AbstractCommand
	{
		public var name:String;
		
		public var cards:ArrayCollection;
		
		public function LoadUserCollCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			cards = new ArrayCollection();
			var file:File = Configures.getUserSaveMetaFileByCollection(name);
			var fs:FileStream = new FileStream();
			fs.addEventListener(Event.COMPLETE, loadCompleteHandler);
			fs.openAsync(file, FileMode.READ);
		}
		
		private function loadCompleteHandler(evt:Event):void
		{
			var fs:FileStream = FileStream(evt.currentTarget);
			fs.removeEventListener(Event.COMPLETE, loadCompleteHandler);
			var xml:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
			
			for each (var childXML:XML in xml.children()) {
				var card:Card = new Card();
				card.decodeUserXML(childXML);
				cards.addItem(card);
			}
			
			this.result(null);
		}
		
	}
}