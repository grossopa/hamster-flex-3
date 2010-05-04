package org.hamster.magic.common.commands
{
	import flash.filesystem.File;
	
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.commands.impl.CommandQueue;
	import org.hamster.magic.common.utils.FileUtil;

	public class LoadCardsCmd extends CommandQueue
	{
		public var collectionName:String;
		
		public var cards:Array;
		
		public function LoadCardsCmd(failedThenQuit:Boolean=false)
		{
			super(cmdArray, failedThenQuit);
		}
		
		override public function execute():void
		{
			this.cmdArray = new Array();
			this.cards = new Array();
			
			var folder:File = FileUtil.getCardFolderByCollection(collectionName);
			var files:Array = folder.getDirectoryListing();
			cards = new Array();
			for each (var file:File in files) {
				if (!file.isDirectory && file.name.indexOf(".xml") != -1) {
					var cmd:LoadCardCmd = new LoadCardCmd();
					cmd.collection = this.collectionName;
					cmd.file = file;
					cmd.addEventListener(CommandEvent.COMMAND_RESULT, loadCardCompleteHandler);
					this.cmdArray.push(cmd);
				}
			}
			super.execute();		
		}
		
		private function loadCardCompleteHandler(evt:CommandEvent):void
		{
			var cmd:LoadCardCmd = LoadCardCmd(evt.currentTarget);
			this.cards.push(cmd.card);
		}
		
	}
}