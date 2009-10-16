package noorg.magic.commands.impl
{
	import flash.filesystem.File;
	
	import noorg.magic.utils.Configures;
	
	import org.hamster.commands.AbstractCommand;

	public class SaveCardCollCmd extends AbstractCommand
	{
		var folder:File;
		var collName:String;
		
		public function SaveCardCollCmd()
		{
			super();
			
		}
		
		override public function execute():void
		{
			folder = Configures.getUserSaveFolderByCollection(collName);
			
			if (folder != null) {
				
			}
		}
		
	}
}