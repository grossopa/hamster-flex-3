package org.hamster.mapleCard.base.commands
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.filesystem.File;
	import flash.system.JPEGLoaderContext;
	import flash.utils.Dictionary;
	
	import mx.graphics.codec.JPEGEncoder;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.commands.impl.CommandQueue;
	import org.hamster.mapleCard.base.constants.Constants;
	import org.hamster.mapleCard.base.constants.CreatureStatusConst;
	import org.hamster.mapleCard.base.model.support.CreatureImageInfo;
	import org.hamster.mapleCard.base.utils.FileUtil;
	
	public class CreatureImageLoaderCmd extends AbstractCommand
	{
		
		public var dir:String;
		
		private var _files:Array;
		private var _resultDict:Object;
		
		public var creatureImageInfo:CreatureImageInfo;
		
		public function CreatureImageLoaderCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			_files = new File(dir).getDirectoryListing();
			_resultDict = new Object();
			if (_files.length == 0) {
				_files = [];
				this.result(null);
			} else {
				var cmdArray:Array = [];
				
				for each (var file:File in _files) {
					var fLoader:BaseImageLoaderCmd = new BaseImageLoaderCmd();
					fLoader.key = file.name;
					fLoader.filePath = file.nativePath;
					fLoader.addEventListener(CommandEvent.COMMAND_RESULT, commandResultHandler);
					cmdArray.push(fLoader);
				}
				
				var cmdQueue:CommandQueue = new CommandQueue(cmdArray);
				cmdQueue.addEventListener(CommandEvent.COMMAND_RESULT, queueResultHandler);
				cmdQueue.addEventListener(CommandEvent.COMMAND_FAULT, queueResultHandler);
				cmdQueue.execute();
			}
		}
		
		private function commandResultHandler(evt:CommandEvent):void
		{
			var fLoader:BaseImageLoaderCmd = BaseImageLoaderCmd(evt.currentTarget);
			_resultDict[fLoader.key] = fLoader.bitmap;
		}
		
		private function queueResultHandler(evt:CommandEvent):void
		{
			creatureImageInfo = new CreatureImageInfo();
			
			for (var s:String in _resultDict) {
				var ss:String = s.substr(s.length - 5, 1);
				var idx:int = parseInt(ss);
				if (s.indexOf(CreatureStatusConst.STAND) >= 0) {
					creatureImageInfo.standImages[idx] = (_resultDict[s]);
				} else if (s.indexOf(CreatureStatusConst.MOVE) >= 0) {
					creatureImageInfo.moveImages[idx] = (_resultDict[s]);
				} else if (s.indexOf(CreatureStatusConst.HIT) >= 0) {
					creatureImageInfo.hitImages[idx] = (_resultDict[s]);
				} else if (s.indexOf(CreatureStatusConst.DIE) >= 0) {
					creatureImageInfo.dieImages[idx] = (_resultDict[s]);
				}
			}
			
			super.result(evt);
		}
		
		public static function execute(id:String):CreatureImageLoaderCmd
		{
			var cmd:CreatureImageLoaderCmd = new CreatureImageLoaderCmd();
			cmd.dir = FileUtil.creatureDir.nativePath + File.separator + id;
			cmd.execute();
			return cmd;
		}
	}
}