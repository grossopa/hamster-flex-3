package org.hamster.mapleCard.base.commands
{
	import flash.filesystem.File;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.commands.impl.CommandQueue;
	import org.hamster.mapleCard.base.model.support.EffectImageInfo;
	import org.hamster.mapleCard.base.utils.FileUtil;
	
	public class EffectImageLoaderCmd extends AbstractCommand
	{
		public var dir:String;
		public var effectImageInfo:EffectImageInfo;
		
		private var _files:Array;
		private var _resultDict:Object;
		
		public function EffectImageLoaderCmd()
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
			effectImageInfo = new EffectImageInfo();
			for (var s:String in _resultDict) {
				var ss:String = s.substr(s.length - 5, 1);
				var idx:int = parseInt(ss);
				effectImageInfo.images[idx] = _resultDict[s];
			}
			
			super.result(evt);
		}
		
		public static function execute(id:String):EffectImageLoaderCmd
		{
			var cmd:EffectImageLoaderCmd = new EffectImageLoaderCmd();
			cmd.dir = FileUtil.effectDir.nativePath + File.separator + id;
			cmd.execute();
			return cmd;
		}
	}
}