package org.hamster.gamesaver.commands
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.hamster.commands.AbstractCommand;

	public class CopyFile2TempCmd extends AbstractCommand
	{
		public var file:File;
		public var targetFolder:File;
		
		public function CopyFile2TempCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			if (!targetFolder.exists) {
				targetFolder.createDirectory();
			} else if (targetFolder.exists && !targetFolder.isDirectory) {
				this.fault(null);
			}
			file.addEventListener(Event.COMPLETE, copyCompleteHandler);
			file.copyToAsync(new File(targetFolder.nativePath + File.separator + file.name));
		}
		
		private function copyCompleteHandler(evt:Event):void
		{
			file.removeEventListener(Event.COMPLETE, copyCompleteHandler);
			this.result(data);
		}		
		
	}
}