package org.hamster.gamesaver.commands
{
	import __AS3__.vec.Vector;
	
	import deng.fzip.FZip;
	
	import flash.filesystem.File;
	
	import nochump.util.zip.ZipFile;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.gamesaver.models.Game;

	public class GenerateZipCmd extends AbstractCommand
	{
		public var games:Array;
		
		private var _fZip:FZip;
		
		public function GenerateZipCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var zipFile:ZipFile;
			
			for each (var game:Game in games) {
				var targetFolder:File = new File(game.name);
				var saveFolder:File = new File(game.savePath);
				var files:Array = saveFolder.getDirectoryListing();
				for each (var file:File in files) {
				}
			}
		}
		
	}
}