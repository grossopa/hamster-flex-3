package org.hamster.mapleCard.base.commands
{
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.commands.impl.CommandQueue;
	import org.hamster.mapleCard.base.constants.Constants;
	import org.hamster.mapleCard.base.model.support.CreatureImageInfo;
	
	public class CreatureImageLoaderCmd extends AbstractCommand
	{
		public var dir:String;
		
		private var _files:Array;
		private var _resultDict:Dictionary;
		
		public var creatureImageInfo:CreatureImageInfo;
		
		public function CreatureImageLoaderCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			_files = new File(dir).getDirectoryListing();
			_resultDict = new Dictionary();
			if (_files.length == 0) {
				_files = [];
				this.result(null);
			} else {
				var cmdArray:Array = [];
				
				for (var file:File in _files) {
					var fLoader:BaseFileLoaderCmd = new BaseFileLoaderCmd();
				//	fLoader.key = Constants.CREATE_KEY_PREFIX + file.name;
					fLoader.filePath = file.nativePath;
					fLoader.addEventListener(CommandEvent.COMMAND_RESULT, commandResultHandler);
					cmdArray.push(fLoader);
				}
				
				var cmdQueue:CommandQueue = new CommandQueue(cmdArray);
				cmdQueue.addEventListener(CommandEvent.COMMAND_FAULT, queueResultHandler);
				cmdQueue.execute();
			}
		}
		
		private function commandResultHandler(evt:CommandEvent):void
		{
			var fLoader:BaseFileLoaderCmd = BaseFileLoaderCmd(evt.currentTarget);
			_resultDict[fLoader.filePath] = fLoader.byteArray;
		}
		
		private function queueResultHandler(evt:CommandEvent):void
		{
			creatureImageInfo = new CreatureImageInfo();
			
		}
	}
}