package org.hamster.gamesaver.commands
{
	import flash.filesystem.File;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.gamesaver.utils.FileUtil;
	
	public class LoadGameImageCmd extends AbstractCommand
	{
		public function LoadGameImageCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var rootFolder:File = FileUtil.getRootImageFolder();
			if (!rootFolder.exists) {
				rootFolder.createDirectory();
			} else {
				
			}
		}
		
		override public function fault(info:Object):void
		{
			
		}
	}
}