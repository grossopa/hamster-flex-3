package org.hamster.gamesaver.commands
{
	import deng.fzip.FZip;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.formatters.DateFormatter;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.commands.impl.CommandQueue;
	import org.hamster.gamesaver.events.CommandProgressEvent;
	import org.hamster.gamesaver.models.Game;
	
	[Event(name="progressChange", 
			type="org.hamster.gamesaver.events.CommandProgressEvent")]

	public class GenerateZipCmd extends AbstractCommand
	{
		public static const TMP_FOLDER:File = new File(File.applicationDirectory.nativePath + File.separator + "temp");
		
		private var _fs:FileStream;
		
		public var games:Array;
		
		public var targetZipFolder:File;
		
		private var _targetZipFile:File;
		
		private var _perCopyCmdPercent:Number;
		private var _percent:Number;
		
		private var _failedGameArray:Array;
		
		public var isZipEnabled:Boolean = false;
		
		public function get failedGameArray():Array
		{
			return _failedGameArray;
		}
		
		public function get targetZipFile():File {
			return this._targetZipFile;
		}
		
		public function GenerateZipCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			_failedGameArray = new Array();
			var cmdArray:Array = new Array();
			var queue:CommandQueue = new CommandQueue(cmdArray);
			
			if (targetZipFolder == null) {
				targetZipFolder = new File(File.applicationDirectory.nativePath
						+ File.separator + "save_backup");
			} else if (!targetZipFolder.isDirectory) {
				targetZipFolder = new File(targetZipFolder.parent.nativePath
						+ File.separator + "save_backup");
			}
			
			for each (var game:Game in games) {
				var saveFolder:File = new File(game.savePath);
				if (!saveFolder.exists || !saveFolder.isDirectory) {
					_failedGameArray.push(game);
				} else {
					var files:Array = saveFolder.getDirectoryListing();
					
					this.parseFolder(game, saveFolder, 
							targetZipFolder.nativePath + File.separator 
							+ "save_backup"+ File.separator 
							+ game.name + File.separator
							+ new File(game.savePath).name, 
							cmdArray);
				}
			}
			_percent = 0;
			_perCopyCmdPercent = 0.9 / queue.cmdArray.length;
			queue.addEventListener(CommandEvent.COMMAND_RESULT, queueCompleteHandler);
			queue.execute();
		}
		
		private function parseFolder(game:Game, folder:File, targetFolderString:String, cmdArray:Array):void
		{
			var files:Array = folder.getDirectoryListing();
			
			var targetFolder:File = new File(targetFolderString);
			
			for each (var file:File in files) {
				if (file.isDirectory) {
					if (game.includeSubFolder) {
						parseFolder(game, file, targetFolderString + File.separator + file.name, cmdArray);
					}
				} else {
					var jump:Boolean = false;
					if (game.excludes != null) {
						for each (var exStr:String in game.excludes) {
							if (file.name.toLowerCase().indexOf(exStr.toLowerCase(), file.name.length - exStr.length) >= 0) {
								jump = true;
								break;
							}
						}
					}
					if (game.includes != null) {
						for each (var inStr:String in game.includes) {
							if (file.name.toLowerCase().indexOf(inStr.toLowerCase(), file.name.length - inStr.length) < 0) {
								jump = true;
								break;
							}
						}
					}
					
					if (jump) {
						continue;
					}
					var copyCmd:CopyFileAndReadCmd = new CopyFileAndReadCmd();
					copyCmd.file = file;
					copyCmd.targetFolder = targetFolder;
					copyCmd.addEventListener(CommandEvent.COMMAND_RESULT,
							copyCmdFinishHandler);
					copyCmd.addEventListener(CommandEvent.COMMAND_FAULT,
							copyCmdFailHandler);
					cmdArray.push(copyCmd);				
				}
			}
		}
		
		private function copyCmdFinishHandler(evt:CommandEvent):void
		{
			var cmd:CopyFileAndReadCmd = CopyFileAndReadCmd(evt.currentTarget);
			cmd.removeEventListener(CommandEvent.COMMAND_RESULT,
					copyCmdFinishHandler);
			cmd.removeEventListener(CommandEvent.COMMAND_FAULT,
					copyCmdFailHandler);
			var disEvt:CommandProgressEvent = new CommandProgressEvent(
					CommandProgressEvent.PROGRESS_CHANGE);
			disEvt.currentCmd = cmd;
			disEvt.currentResult = "success";
			this._percent += _perCopyCmdPercent;
			disEvt.percent = this._percent;
			this.dispatchEvent(disEvt);
		}
		
		private function copyCmdFailHandler(evt:CommandEvent):void
		{
			var cmd:CopyFileAndReadCmd = CopyFileAndReadCmd(evt.currentTarget);
			cmd.removeEventListener(CommandEvent.COMMAND_RESULT,
					copyCmdFinishHandler);
			cmd.removeEventListener(CommandEvent.COMMAND_FAULT,
					copyCmdFailHandler);
			var disEvt:CommandProgressEvent = new CommandProgressEvent(
					CommandProgressEvent.PROGRESS_CHANGE);
			this._percent += _perCopyCmdPercent;
			disEvt.percent = this._percent;
			this.dispatchEvent(disEvt);
		}
		
		private function queueCompleteHandler(evt:CommandEvent):void
		{
			if (!this.isZipEnabled) {
				this.result(null);
				return;
			}
			var queue:CommandQueue = CommandQueue(evt.currentTarget);
			var fZip:FZip = new FZip();
			
			for each (var copyCmd:CopyFileAndReadCmd in queue.cmdArray) {
				var file:File = copyCmd.copiedFile;
				if (file.data != null) {
					fZip.addFile(copyCmd.targetFolder.nativePath
							.replace(TMP_FOLDER.nativePath + File.separator, "")
							.replace("\\","/") + "/" + file.name, file.data);  
				}
			}
			var zipFileByteArray:ByteArray = new ByteArray();
			fZip.serialize(zipFileByteArray);
			var df:DateFormatter = new DateFormatter();
			df.formatString = "YYYYMMDD_JNNSS";
			
			_targetZipFile = new File(targetZipFolder.nativePath + File.separator + "save_"
					+ df.format(new Date()) + ".zip");
			_fs = new FileStream();
			_fs.openAsync(_targetZipFile, FileMode.WRITE);
			_fs.writeBytes(zipFileByteArray, 0, zipFileByteArray.length);
			_fs.addEventListener(Event.CLOSE, this.result);
			_fs.close();
			

		}
		
		override public function result(data:Object):void
		{
			var disEvt:CommandProgressEvent = new CommandProgressEvent(
				CommandProgressEvent.PROGRESS_CHANGE);
			this._percent = 1;
			disEvt.percent = this._percent;
			this.dispatchEvent(disEvt);
			
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();			
		}
		
		private function timerHandler(evt:TimerEvent):void
		{
			super.result(null);
		}
	}
	

}