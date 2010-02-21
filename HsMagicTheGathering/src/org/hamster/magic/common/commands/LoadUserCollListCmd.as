package org.hamster.magic.common.commands
{
	import flash.filesystem.File;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.magic.common.utils.FileUtil;

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
			var folder:File = FileUtil.getUserSaveFolder();
			var files:Array = folder.getDirectoryListing();
			for each (var file:File in files) {
				names.push(file.name);
			}
			this.result(null);
		}
		
	}
}