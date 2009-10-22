package noorg.magic.commands.impl
{
	import flash.filesystem.File;
	
	import noorg.magic.utils.Configures;
	
	import org.hamster.commands.AbstractCommand;

	public class LoadUserCollListCmd extends AbstractCommand
	{
		public var names:Array;
		
		public function LoadUserCollListCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			names = new Array();
			var folder:File = Configures.getUserSaveFolder();
			var files:Array = folder.getDirectoryListing();
			for each (var file:File in files) {
				names.push(file.name);
			}
			this.result(null);
		}
		
	}
}