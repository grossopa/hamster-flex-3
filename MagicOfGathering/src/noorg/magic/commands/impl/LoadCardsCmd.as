package noorg.magic.commands.impl
{
	import flash.filesystem.File;
	
	import noorg.magic.utils.FileUtil;
	
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.commands.impl.CommandQueue;

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
					cmd.collectionName = this.collectionName;
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