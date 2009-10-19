package noorg.magic.commands
{
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	
	import noorg.magic.commands.impl.GetCardFromWebCmd;
	import noorg.magic.commands.impl.GetImageToFileCmd;
	import noorg.magic.commands.impl.LoadCardCmd;
	import noorg.magic.commands.impl.SaveUserCardCollCmd;
	import noorg.magic.models.Card;
	import noorg.magic.services.DataService;
	
	public class CommandWrapper
	{
		private static const DS:DataService = DataService.getInstance();
		
		public static function getCard(pid:int):GetCardFromWebCmd
		{
			var cmd:GetCardFromWebCmd = new GetCardFromWebCmd();
			cmd.pid = pid;
			cmd.execute();
			return cmd;
		}
		
		public static function imgToFile(card:Card, folder:File):GetImageToFileCmd
		{
			var cmd:GetImageToFileCmd = new GetImageToFileCmd();
			cmd.card = card;
			cmd.folder = folder;
			cmd.execute();
			return cmd;
		}
		
		public static function loadCard(collectionName:String, file:File):LoadCardCmd
		{
			var cmd:LoadCardCmd = new LoadCardCmd();
			cmd.collectionName = collectionName;
			cmd.file = file;
			cmd.execute();
			return cmd;
		}
		
		public static function saveCollection(collectionName:String, cards:ArrayCollection = null):SaveUserCardCollCmd
		{
			var cmd:SaveUserCardCollCmd = new SaveUserCardCollCmd();
			cmd.name = collectionName;
			if (cards == null) {
				cards = DS.selectedCards;
			}
			cmd.cards = cards;
			cmd.execute();
			return cmd;
		}

	}
}