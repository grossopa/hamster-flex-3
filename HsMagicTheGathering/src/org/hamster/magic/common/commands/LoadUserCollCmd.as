package org.hamster.magic.common.commands
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.magic.common.models.Card;
	import org.hamster.magic.common.models.CardCollection;
	import org.hamster.magic.common.services.DataService;
	import org.hamster.magic.common.utils.FileUtil;

	public class LoadUserCollCmd extends AbstractCommand
	{
		private static const DS:DataService = DataService.getInstance();
		
		public var name:String;
		
		public var cards:ArrayCollection;
		
		public function LoadUserCollCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			cards = new ArrayCollection();
			var file:File = FileUtil.getUserSaveMetaFileByCollection(name);
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
				for each (var cardCollection:CardCollection in DS.cardCollections) {
					if (cardCollection.name == card.collection) {
						for each (var sourceCard:Card in cardCollection.cards) {
							if (card.pid == sourceCard.pid) {
								card.imgPath = sourceCard.imgPath;
								card.decodeXML(sourceCard.toXML());
								break;
							}
						}
					}
				}
				
				cards.addItem(card);
			}
			
			this.result(null);
		}
		
	}
}